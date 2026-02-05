with active_users_base as (
        select 
            dt,
            device_id,
            last_day_feature.duration as duration,
            FIRST_VALUE(last_30_days_feature.geo_country_name) OVER (PARTITION BY device_id ORDER BY if(last_30_days_feature.geo_country_name is not null,0,1), dt DESC) as country_name,  
            FIRST_VALUE(last_day_feature.platform) OVER (PARTITION BY device_id ORDER BY if(last_day_feature.platform is not null,0,1), dt DESC) as platform, 
            FIRST_VALUE(last_day_feature.app_version) OVER (PARTITION BY device_id ORDER BY if(last_day_feature.app_version is not null,0,1), dt DESC) as app_version,  
            FIRST_VALUE(last_day_feature.login_type) OVER (PARTITION BY device_id ORDER BY if(last_day_feature.login_type is not null,0,1), IF(last_day_feature.login_type = 'login', 0, 1)) as user_login_type,
            FIRST_VALUE(user_tenure_type) OVER (PARTITION BY device_id ORDER BY if(user_tenure_type is not null,0,1), IF(user_tenure_type = "New User", 0, 1)) as user_tenure_type
        FROM favie_dw.dws_favie_gensmo_user_feature_inc_1d
        WHERE dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
    ),

    active_users as (
        select 
            device_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            SUM(duration) as total_duration,
        from active_users_base
        GROUP BY device_id, country_name, platform, app_version, user_login_type, user_tenure_type
    ),

    user_group_info as (
        SELECT
            t1.device_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.total_duration,
            t2.user_group
        FROM active_users t1 
        left outer join (
            select distinct device_id, user_group 
            from favie_dw.dws_gensmo_user_group_inc_1d 
            where dt is not null and dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
                AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
        ) t2 
        on t1.device_id = t2.device_id
        where t2.user_group is not null),
    
    user_active_metric AS (
        SELECT
            DATE_TRUNC(dt_param, WEEK(SUNDAY)) AS week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            COUNT(DISTINCT device_id) AS active_user_w1_cnt,
            SUM(total_duration) AS total_duration
        FROM user_group_info
        GROUP BY
            week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group         
    )

    SELECT
        week_end_dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_w1_cnt,
        total_duration
    FROM
        user_active_metric