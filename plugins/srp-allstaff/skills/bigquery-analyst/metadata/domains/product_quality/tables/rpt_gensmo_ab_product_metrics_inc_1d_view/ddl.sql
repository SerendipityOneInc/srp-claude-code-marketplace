CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_product_metrics_inc_1d_view`
AS WITH user_product_metrics AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,

            SUM(product_external_jump_click_cnt) AS product_external_jump_click_cnt,
            COUNT(DISTINCT product_external_jump_click_device_id) AS product_external_jump_click_user_cnt,
            SUM(product_detail_pv_cnt) AS product_detail_pv_cnt,
            COUNT(DISTINCT product_detail_pv_device_id) AS product_detail_pv_user_cnt,
            SUM(IF(cal_pre_refer != 'feed_detail', product_external_jump_click_cnt, 0)) AS product_external_jump_click_in_channel_cnt,
            COUNT(DISTINCT CASE WHEN cal_pre_refer != 'feed_detail' THEN product_external_jump_click_device_id END) AS product_external_jump_click_in_channel_user_cnt,
            SUM(IF(cal_pre_refer != 'feed_detail', product_detail_pv_cnt, 0)) AS product_detail_pv_in_channel_cnt,
            COUNT(DISTINCT CASE WHEN cal_pre_refer != 'feed_detail' THEN product_detail_pv_device_id END) AS product_detail_pv_in_channel_user_cnt
        FROM
            `srpproduct-dc37e.favie_dw.dws_favie_gensmo_product_bysource_metric_inc_1d`
        WHERE
            dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND user_group LIKE 'ab%'
        GROUP BY
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name
    ),

    channel_info AS (
      SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
        SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
        SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,
        SUM(user_channel_cnt) AS user_channel_cnt
      FROM
        `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d`
      WHERE
        dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND user_group LIKE 'ab%'
      GROUP BY
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name
    ),

    dau_info AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,
            active_user_d1_cnt AS DAU
        FROM
            `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d`
        WHERE
            dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) 
            AND user_group LIKE 'ab%'
            AND active_user_d1_cnt > 0
    )
    
    SELECT
        b.dt,
        b.user_tenure_type,
        b.user_login_type,
        b.country_name,
        b.platform,
        b.app_version,
        b.ab_project_name,
        b.ab_router_id,
        b.ab_router_name,

        COALESCE(a.product_external_jump_click_cnt, 0) AS product_external_jump_click_cnt,
        COALESCE(a.product_detail_pv_cnt, 0) AS product_detail_pv_cnt,

        COALESCE(a.product_external_jump_click_user_cnt, 0) AS product_external_jump_click_user_cnt,
        COALESCE(a.product_detail_pv_user_cnt, 0) AS product_detail_pv_user_cnt,

        COALESCE(a.product_external_jump_click_in_channel_cnt, 0) AS product_external_jump_click_in_channel_cnt,
        COALESCE(a.product_external_jump_click_in_channel_user_cnt, 0) AS product_external_jump_click_in_channel_user_cnt,

        COALESCE(a.product_detail_pv_in_channel_cnt, 0) AS product_detail_pv_in_channel_cnt,
        COALESCE(a.product_detail_pv_in_channel_user_cnt, 0) AS product_detail_pv_in_channel_user_cnt,
        b.DAU,
        c.user_channel_cnt
    FROM
        dau_info b
    LEFT JOIN
        user_product_metrics a
    ON
        a.dt = b.dt
        AND a.user_tenure_type = b.user_tenure_type
        AND a.user_login_type = b.user_login_type
        AND a.country_name = b.country_name
        AND a.platform = b.platform
        AND a.app_version = b.app_version
        AND a.ab_project_name = b.ab_project_name
        AND a.ab_router_id = b.ab_router_id
        AND a.ab_router_name = b.ab_router_name
    LEFT JOIN
        channel_info c
    ON
        c.dt = b.dt
        AND c.user_tenure_type = b.user_tenure_type
        AND c.user_login_type = b.user_login_type
        AND c.country_name = b.country_name
        AND c.platform = b.platform
        AND c.app_version = b.app_version
        AND c.ab_project_name = b.ab_project_name
        AND c.ab_router_id = b.ab_router_id
        AND c.ab_router_name = b.ab_router_name;