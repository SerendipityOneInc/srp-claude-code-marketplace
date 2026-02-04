with active_users_base as (
        select 
            dt,
            user_id,
            last_day_feature.duration as duration,
        FROM favie_dw.dws_favie_decofy_user_feature_inc_1d
        WHERE dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
    ),

    week_user_group as (
        select 
            *
        from(
            select 
                user_id, 
                user_group,
                country_name,
                platform,
                app_version,
                user_login_type,
                user_tenure_type,
                ad_source,
                ad_id,
                ad_group_id,
                ad_campaign_id,
                row_number() over (partition by user_id,user_group order by dt) as row_num
            from favie_dw.dws_decofy_user_group_inc_1d 
            where dt is not null and dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
                AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
        ) where row_num = 1
    ),

    with_user_group_info as (
        SELECT
            t1.user_id,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_login_type,
            t2.user_tenure_type,
            t1.duration,
            t2.user_group,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        FROM active_users_base t1 
        left outer join week_user_group t2 
        on t1.user_id = t2.user_id
        where t2.user_group is not null
    ),
    
    user_active_metric AS (
        SELECT
            DATE_TRUNC(dt_param, WEEK(SUNDAY)) AS week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COUNT(DISTINCT user_id) AS active_user_w1_cnt,
            SUM(duration) AS total_duration
        FROM with_user_group_info
        GROUP BY
            week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id         
    )

    SELECT
        week_end_dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        active_user_w1_cnt,
        total_duration
    FROM
        user_active_metric