WITH user_base_dt_active_data AS (
        SELECT
            dt,
            device_id,
            action.action_type
        FROM `favie_dw.dws_gensmo_user_activity_profile_inc_1d`,unnest(common_actions) as action
        WHERE  dt >= date_sub(dt_param, interval n-1 day) 
            and dt <= dt_param
            and action.action_type is not null
    ),

    user_base_dt_active_data_n as (
        SELECT
            dt,
            device_id,
            action_type
        FROM user_base_dt_active_data
        WHERE dt = date_sub(dt_param, interval n-1 day)
    ),


    user_group_info as (
        select 
            user_group,
            device_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_segment,
            user_tenure_type,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        from favie_dw.dws_gensmo_user_group_inc_1d 
        where dt = date_sub(dt_param, interval n-1 day)
    ),

    user_base_dt_active_data_with_group AS (
        SELECT
            t1.dt,
            t1.device_id,
            t1.action_type,
            t2.user_tenure_type,
            t2.user_tenure_segment,
            t2.user_login_type,
            t2.country_name,
            t2.platform,
            t2.app_version,

            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id,

            t2.user_group
        FROM user_base_dt_active_data_n t1
        INNER JOIN user_group_info t2
        ON t1.device_id = t2.device_id 
        WHERE t2.user_group IS NOT NULL
    ),

    user_future_activity AS (
        SELECT
            device_id,
            action_type,
            COUNT(DISTINCT dt) AS user_active_days_cnt
        FROM user_base_dt_active_data
        GROUP BY device_id,action_type
    ),

    user_ltn_metrics AS (
        SELECT
            f.dt,
            f.action_type,
            f.user_tenure_segment,
            f.user_tenure_type,
            f.user_login_type,
            f.country_name,
            f.platform,
            f.app_version,

            f.ad_source,
            f.ad_id,
            f.ad_group_id,
            f.ad_campaign_id,

            f.user_group,

            COUNT(DISTINCT f.device_id) AS active_user_cnt,
            SUM(fa.user_active_days_cnt) AS active_days_cnt
        FROM user_base_dt_active_data_with_group f
        LEFT JOIN user_future_activity fa
        ON f.device_id = fa.device_id AND f.action_type = fa.action_type
        GROUP BY
            f.dt,
            f.action_type,
            f.user_tenure_segment,
            f.user_tenure_type,
            f.user_login_type,
            f.country_name,
            f.platform,
            f.app_version,
            f.ad_source,
            f.ad_id,
            f.ad_group_id,
            f.ad_campaign_id,
            f.user_group
    )

    SELECT
        dt,
        action_type,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_segment,
        user_tenure_type,

        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        user_group,

        n as lifetime_days,
        active_days_cnt,
        active_user_cnt
    FROM user_ltn_metrics