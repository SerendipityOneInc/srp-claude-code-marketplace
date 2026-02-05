WITH user_base_dt_active_data AS (
        SELECT
            dt,
            device_id,
            user_tenure_type,
            last_day_feature.login_type as user_login_type,
            last_30_days_feature.geo_country_name as country_name,
            last_day_feature.platform as platform,
            last_day_feature.app_version as app_version
        FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt = date_sub(dt_param, interval n-1 day)
    ),

    user_base_dt_active_data_with_group AS (
        SELECT
            t1.dt,
            t1.device_id,
            t1.user_tenure_type,
            t1.user_login_type,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t2.user_group
        FROM user_base_dt_active_data t1
        INNER JOIN (
            SELECT * FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d`
            WHERE dt is not null and dt = date_sub(dt_param, interval n-1 day)
        ) t2
        ON t1.device_id = t2.device_id 
        WHERE t2.user_group IS NOT NULL
    ),

    user_future_activity AS (
        SELECT
            device_id,
            COUNT(DISTINCT dt) AS user_active_days_cnt
        FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt >= date_sub(dt_param, interval n-1 day) 
            and dt <= dt_param 
        GROUP BY device_id
    ),

    user_ltn_metrics AS (
        SELECT
            f.dt,
            f.user_tenure_type,
            f.user_login_type,
            f.country_name,
            f.platform,
            f.app_version,
            f.user_group,
            COUNT(DISTINCT f.device_id) AS active_user_cnt,
            SUM(fa.user_active_days_cnt) AS active_days_cnt
        FROM user_base_dt_active_data_with_group f
        LEFT JOIN user_future_activity fa
        ON f.device_id = fa.device_id
        GROUP BY
            f.dt,
            f.user_tenure_type,
            f.user_login_type,
            f.country_name,
            f.platform,
            f.app_version,
            f.user_group
    )

    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        n as lifetime_days,
        active_days_cnt,
        active_user_cnt
    FROM user_ltn_metrics