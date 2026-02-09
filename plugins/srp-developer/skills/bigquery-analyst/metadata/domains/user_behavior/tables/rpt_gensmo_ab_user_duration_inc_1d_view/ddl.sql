CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_user_duration_inc_1d_view`
AS WITH user_duration AS(
        SELECT
            dt,
            device_id,
            user_tenure_type,
            last_day_feature.login_type AS user_login_type,
            last_30_days_feature.geo_country_name AS country_name,
            last_day_feature.platform AS platform,
            last_day_feature.app_version AS app_version,
            last_day_feature.duration AS user_duration
        FROM
            `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
    ),

    user_duration_with_group AS (
        SELECT
            d.dt,
            d.device_id,
            d.user_tenure_type,
            d.user_login_type,
            d.country_name,
            d.platform,
            d.app_version,
            d.user_duration,
            
            SPLIT(g.user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(g.user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(g.user_group, '@')[OFFSET(1)] AS ab_router_name
        FROM
            user_duration d
        INNER JOIN(
            SELECT * FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY),CURRENT_DATE()) WHERE user_group LIKE 'ab%'
        ) g
        ON d.dt = g.dt AND d.device_id = g.device_id AND g.user_group IS NOT NULL
    )

    SELECT
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name,
        user_duration
    FROM
        user_duration_with_group;