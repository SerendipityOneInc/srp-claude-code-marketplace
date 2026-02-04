CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_source_breakdown_analysis_in_avatar_generation_view`
AS WITH event_info AS (
    SELECT
        refer,
        pre_refer,
        ap_name,
        pre_refer_ap_name,
        pre_refer_event_action_type,
        pre_refer_event_name,
        pre_refer_event_method,
        event_name,
        event_method,
        event_action_type,
        device_id,
        dt,
        platform,
        app_version,
        user_country_name AS country,
        COALESCE(user_tenure_type, 'unknown') AS user_tenure_type,
        COALESCE(user_login_type, 'unknown') AS user_login_type
    FROM
        `srpproduct-dc37e.favie_dw.dws_gensmo_refer_event_metrics_inc_1d`
    WHERE
        dt is not null
),

info AS (
    SELECT
        i.refer,
        i.pre_refer,
        i.ap_name,
        i.pre_refer_ap_name,
        i.pre_refer_event_action_type,
        i.pre_refer_event_name,
        i.pre_refer_event_method,
        i.event_name,
        i.event_method,
        i.event_action_type,
        i.device_id,
        i.dt,
        i.platform,
        i.app_version,
        i.country,
        i.user_tenure_type,
        i.user_login_type,
        g.user_group
    FROM
        event_info i
    LEFT JOIN `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` g
    ON
        i.device_id = g.device_id AND g.dt = i.dt
    WHERE
        i.dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 14 DAY) AND g.user_group IS NOT NULL
)

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CONCAT(COALESCE(pre_refer, 'unknown'), '@', COALESCE(pre_refer_ap_name, 'unknown')) AS source,
    '进入Avatar创建' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    refer = 'create_replica' AND pre_refer NOT IN ('pic_upload_option', 'login_half_screen', 'camera_set_face')
GROUP BY
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    (CASE 
        WHEN ((
              (pre_refer = 'home' and pre_refer_ap_name like 'ap_dual_column%btn')
              or 
              ((pre_refer_ap_name like '%try_on%btn' or pre_refer_ap_name like '%retry%') and pre_refer_ap_name NOT IN ('ap_try_on_history_list_item_delete_btn'))
            )
            and pre_refer_event_name = 'select_item' 
            and pre_refer_event_method = 'click')
            or
            (pre_refer_event_name = 'select_item' and pre_refer_event_method = 'shake')
            THEN '被动进入avatar创建' ELSE '主动进入Avatar创建' END) AS source,
    '进入Avatar创建的主被动来源' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    refer = 'create_replica' AND pre_refer NOT IN ('pic_upload_option', 'login_half_screen', 'camera_set_face')
GROUP BY
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CONCAT(COALESCE(pre_refer, 'unknown'), '@', COALESCE(pre_refer_ap_name, 'unknown')) AS source,
    '发起Avatar生成' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    refer = 'create_replica' AND ap_name = 'ap_avatar_generate_btn'
GROUP BY
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CONCAT(COALESCE(pre_refer, 'unknown'), '@', COALESCE(pre_refer_ap_name, 'unknown')) AS source,
    '确认默认Avatar' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    ap_name = 'ap_confirm_btn' AND refer = 'select_model'
GROUP BY
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CASE
        WHEN refer = 'select_model' AND ap_name = 'ap_confirm_btn' THEN '使用默认avatar' 
        WHEN refer = 'create_replica' AND ap_name = 'ap_avatar_generate_btn' THEN '上传自定义avatar' 
    END AS source,
    '提交avatar创建的分布' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE (refer = 'select_model' AND ap_name = 'ap_confirm_btn') OR (refer = 'create_replica' AND ap_name = 'ap_avatar_generate_btn')
GROUP BY
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CONCAT(COALESCE(pre_refer, 'unknown'), '@', COALESCE(pre_refer_ap_name, 'unknown')) AS source,
    '在avatar管理页中查看avatar列表' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    ap_name = 'ap_avatar_option_list' AND refer = 'avatar_manage'
GROUP BY 
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CONCAT(COALESCE(pre_refer, 'unknown'), '@', COALESCE(pre_refer_ap_name, 'unknown')) AS source,
    '发起try on生成' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    event_action_type IN ('try_on', 'try_on_no_avatar')
GROUP BY
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source

UNION ALL

SELECT
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    CONCAT(COALESCE(pre_refer, 'unknown'), '@', COALESCE(pre_refer_ap_name, 'unknown')) AS source,
    'try on行为产生进一步互动' AS scene,
    COUNT(DISTINCT device_id) AS source_cnt,
    COUNT(1) AS total_cnt
FROM
    info
WHERE
    refer = 'try_on_gen' AND pre_refer NOT IN ('ai_wardrobe', 'avatar_manage') AND event_method IN ('click', 'screenshot')
GROUP BY 
    dt,
    platform,
    app_version,
    country,
    user_tenure_type,
    user_login_type,
    user_group,
    source;