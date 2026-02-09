CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_feed_user_operation_30days_inc_1d_view`
AS WITH filtered_behavior AS (
    SELECT
        gensmo_active_id,
        event_date,
        method,
        refer,
        item_list_name,
        event_name,
        action_type,
        item_id
    FROM
        `srpproduct-dc37e.gensmo_dw.dwd_gem_user_behavior_wide_inc_1d`
    WHERE
        event_date BETWEEN CAST(DATE_SUB(CURRENT_DATE(), INTERVAL 15 DAY) AS STRING) AND CAST(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS STRING)
        AND gensmo_active_id IS NOT NULL
),
filtered_users AS (
    SELECT
        device_id AS gensmo_active_id,
        user_id,
        is_registered_user,
        geos,
        is_effective_user,
        user_email,
        created_date
    FROM
        `srpproduct-dc37e.gensmo_dim.dim_gem_user_full_1d_view`
    WHERE
        device_id IN (SELECT DISTINCT gensmo_active_id FROM filtered_behavior)
),
ranked_users AS (
    SELECT
        gensmo_active_id,
        user_id,
        is_registered_user,
        geos,
        is_effective_user,
        user_email,
        created_date,
        ROW_NUMBER() OVER (PARTITION BY gensmo_active_id ORDER BY created_date DESC) AS rn
    FROM
        filtered_users
),
user_device_mapping AS (
    SELECT
        gensmo_active_id,
        user_id,
        is_registered_user,
        geos,
        is_effective_user,
        user_email,
        created_date
    FROM
        ranked_users
    WHERE
        rn = 1
),
user_profile AS (
    SELECT
        user_id,
        ARRAY_AGG(gensmo_active_id) AS device_ids,
        MAX(is_registered_user) AS is_registered_user,
        ANY_VALUE(geos) AS geos,
        MAX(is_effective_user) AS is_effective_user,
        MAX(user_email) AS user_email,
        MAX(created_date) AS created_date
    FROM
        user_device_mapping
    GROUP BY
        user_id
),
behavior_with_user_id AS (
    SELECT
        COALESCE(u.user_id, 'unknown') AS user_id,
        t.gensmo_active_id,
        t.event_date,
        t.method,
        refer,
        t.item_list_name,
        t.event_name,
        t.action_type,
        t.item_id
    FROM
        filtered_behavior t
    LEFT JOIN
        user_device_mapping u
    ON
        t.gensmo_active_id = u.gensmo_active_id
),
-- 计算用户停留时长（按用户聚合设备数据）
user_duration AS (
    SELECT 
        u.user_id,
        d.dt,
        SUM(d.feed_duration_total) AS user_feed_duration_total
    FROM (
        SELECT 
            device_id,
            SUM(duration) AS feed_duration_total,
            CAST(dt AS STRING) AS dt
        FROM 
            `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE 
            (refer = 'home' OR refer = 'collage_detail' OR refer = 'feed_detail')
            AND dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 15 DAY)
        GROUP BY 
            device_id, dt
    ) d
    LEFT JOIN user_device_mapping u
    ON d.device_id = u.gensmo_active_id
    WHERE u.user_id IS NOT NULL  -- 仅保留已知用户
    GROUP BY 
        u.user_id, d.dt
)
-- 主查询，从关联后的行为表、用户信息表和停留时长表中获取所需信息
SELECT
    b.user_id,
    b.event_date,
    ARRAY_AGG(DISTINCT b.gensmo_active_id) AS device_ids,
    -- feed 浏览量
    SUM(CASE WHEN b.method = 'true_view_trigger' AND b.refer = 'home' THEN 1 ELSE 0 END) AS user_view_cnt,
    -- 内容点击量
    SUM(CASE WHEN b.method = 'click' AND (
        b.item_list_name = 'ap_dual_column_feed_for_you_list_item_cover' 
        OR b.item_list_name = 'ap_dual_column_feed_popular_list_item_cover' 
        OR b.item_list_name = 'ap_dual_column_feed_recent_list_item_cover'
    ) AND b.event_name = 'select_item' THEN 1 ELSE 0 END) AS user_click_cnt,
    -- 搜索数量
    SUM(CASE WHEN b.refer = 'search_boot' AND b.event_name = 'select_item' AND b.item_list_name = 'ap_generate_btn' AND b.method = 'click' AND b.action_type = 'collage_gen' THEN 1 ELSE 0 END) AS user_search_cnt,
    -- 试穿量
    SUM(CASE WHEN (b.item_list_name = 'ap_try_on_bottom_btn' OR b.item_list_name = 'ap_try_on_side_btn') THEN 1 ELSE 0 END) +
    SUM(CASE WHEN b.item_id IS NOT NULL AND b.refer = 'home' AND b.method = 'click' AND b.action_type = 'try_on' THEN 1 ELSE 0 END) AS user_try_on_cnt,
    -- remix 量
    SUM(CASE WHEN b.item_list_name = 'ap_remix_bottom_btn' THEN 1 ELSE 0 END) AS user_remix_cnt,
    -- share 量
    SUM(CASE WHEN b.item_list_name = 'ap_share_btn' THEN 1 ELSE 0 END) AS user_share_cnt,
    -- save 量
    SUM(CASE WHEN b.method = 'click' AND b.action_type = 'save' THEN 1 ELSE 0 END) -
    SUM(CASE WHEN b.method = 'click' AND b.action_type = 'unsave' THEN 1 ELSE 0 END) AS user_save_cnt,
    -- 产品点击量
    SUM(CASE WHEN (b.refer = 'feed_detail' AND b.item_list_name = 'ap_collage_entity_list_entity' AND b.method = 'click') 
            OR (b.refer = 'feed_detail' AND b.method = 'click' AND b.item_list_name = 'ap_product_list_product') THEN 1 ELSE 0 END) AS product_click_cnt,
    -- 产品链接点击量
    SUM(CASE WHEN b.event_name = 'select_item' AND b.item_list_name = 'ap_product_card' AND b.method = 'click' AND b.action_type = 'product_external_jump' AND b.refer = 'product_detail' THEN 1 ELSE 0 END) AS product_link_click_cnt,
    -- 用户停留时长（使用ANY_VALUE处理非聚合字段）
    ANY_VALUE(d.user_feed_duration_total) AS user_stay_duration,
    -- 使用ANY_VALUE聚合用户信息字段
    ANY_VALUE(u.is_registered_user) AS is_registered_user,
    ANY_VALUE(u.geos) AS geos,
    ANY_VALUE(u.is_effective_user) AS is_effective_user,
    ANY_VALUE(u.user_email) AS user_email,
    ANY_VALUE(u.created_date) AS created_date
FROM
    behavior_with_user_id b
LEFT JOIN
    user_profile u
ON
    b.user_id = u.user_id
LEFT JOIN
    user_duration d
ON
    b.user_id = d.user_id
    AND b.event_date = d.dt
GROUP BY
    b.user_id,
    b.event_date  
ORDER BY
    b.event_date,
    b.user_id;