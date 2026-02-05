WITH user_metrics AS (
        SELECT *
        FROM `favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d_function`(dt_param)
    ),
    
    aggregation_by_pv AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name,
            refer,
            SUM(user_content_consumption) AS content_consumption_pv_cnt,
            SUM(user_feed_stay_interval) AS feed_stay_interval_total_cnt,
            SUM(user_feed_true_view) AS feed_true_view_pv_cnt
        FROM
            user_metrics
        GROUP BY
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name,
            refer
    ),

    aggregation_by_uv AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name,
            refer,
            COUNT(DISTINCT CASE WHEN user_content_consumption > 0 THEN device_id END) AS content_consumption_user_cnt,
            COUNT(DISTINCT CASE WHEN user_feed_stay_interval > 0 THEN device_id END) AS feed_stay_user_cnt,
            COUNT(DISTINCT CASE WHEN user_feed_true_view > 0 THEN device_id END) AS feed_true_view_user_cnt
        FROM
            user_metrics
        GROUP BY
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name,
            refer
    )

    -- 最终结果合并
    SELECT
        COALESCE(a.dt, b.dt) AS dt,
        COALESCE(a.user_tenure_type, b.user_tenure_type) AS user_tenure_type,
        COALESCE(a.user_login_type, b.user_login_type) AS user_login_type,
        COALESCE(a.country_name, b.country_name) AS country_name,
        COALESCE(a.platform, b.platform) AS platform,
        COALESCE(a.app_version, b.app_version) AS app_version,
        COALESCE(a.ab_project_name, b.ab_project_name) AS ab_project_name,
        COALESCE(a.ab_router_id, b.ab_router_id) AS ab_router_id,
        COALESCE(a.ab_router_name, b.ab_router_name) AS ab_router_name,
        COALESCE(a.refer, b.refer) AS refer,
        -- PV指标
        b.content_consumption_pv_cnt,
        b.feed_stay_interval_total_cnt,
        b.feed_true_view_pv_cnt,
        
        -- UV指标
        a.content_consumption_user_cnt,
        a.feed_stay_user_cnt,
        a.feed_true_view_user_cnt
    FROM
        aggregation_by_uv a
    FULL OUTER JOIN
        aggregation_by_pv b
    ON
        a.dt = b.dt
        AND a.user_login_type = b.user_login_type
        AND a.user_tenure_type = b.user_tenure_type
        AND a.country_name = b.country_name
        AND a.platform = b.platform
        AND a.app_version = b.app_version
        AND a.ab_project_name = b.ab_project_name
        AND a.ab_router_id = b.ab_router_id
        AND a.ab_router_name = b.ab_router_name
        AND a.refer = b.refer