with active_users as (
        select 
            dt,
            user_id,
            last_30_days_feature.geo_country_name as country_name,  
            last_day_feature.platform as platform, 
            last_day_feature.app_version as app_version,  
            last_day_feature.login_type as user_login_type,
            user_tenure_type,
            last_day_feature.duration as last_duration,
        FROM favie_dw.dws_favie_decofy_user_feature_inc_1d
        WHERE dt = dt_param
            -- and DATE(last_access_at) = dt_param
    ),

    user_group_info as (
        select 
            user_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group
        from favie_dw.dws_decofy_user_group_inc_1d 
        where dt = dt_param
    ),

    user_active_with_group_info as (
        SELECT
            t1.dt,
            t1.user_id,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_login_type,
            t2.user_tenure_type,
            t2.membership_tenure_type,
            t2.membership_pay_status,
            t1.last_duration,
            t2.user_group,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        FROM active_users t1 
        left outer join user_group_info t2 
        on t1.user_id = t2.user_id
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
            membership_tenure_type,
            membership_pay_status,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            COUNT(1) AS active_user_d1_cnt,
            SUM(last_duration) AS total_duration,
        FROM user_active_with_group_info
        GROUP BY
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
    )

    SELECT
        dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        membership_tenure_type,
        membership_pay_status,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        active_user_d1_cnt,
        total_duration
    FROM
        user_actvice_metric