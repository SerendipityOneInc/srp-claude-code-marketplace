with active_users as (
        select 
            dt,
            device_id,
            last_30_days_feature.geo_country_name as country_name,  
            last_day_feature.platform as platform, 
            last_day_feature.app_version as app_version,  
            last_day_feature.login_type as user_login_type,
            user_tenure_type,
            last_day_feature.duration as last_duration,
        FROM favie_dw.dws_favie_gensmo_user_feature_inc_1d
        WHERE dt = dt_param
            -- and DATE(last_access_at) = dt_param
    ),

    user_group_info as (
        SELECT
            t1.dt,
            t1.device_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.last_duration,
            t2.user_group
        FROM active_users t1 
        left outer join (select * from favie_dw.dws_gensmo_user_group_inc_1d where dt is not null and  dt = dt_param) t2 
        on t1.device_id = t2.device_id
        where t2.user_group is not null
    ),
    
    user_actvice_metric AS (
        SELECT
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            COUNT(1) AS active_user_d1_cnt,
            SUM(last_duration) AS total_duration,
        FROM user_group_info
        GROUP BY
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group         
    )

    SELECT
        dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        total_duration
    FROM
        user_actvice_metric