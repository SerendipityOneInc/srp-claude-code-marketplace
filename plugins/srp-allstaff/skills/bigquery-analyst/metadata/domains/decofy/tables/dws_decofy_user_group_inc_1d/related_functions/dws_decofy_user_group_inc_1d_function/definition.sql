WITH ab_info as (
        SELECT dt, 
            ab_project,
            ab_router ,
            ab_unique_id,
            user_id,
        FROM favie_dw.dwd_favie_decofy_ab_active_users_inc_1d
        where dt = dt_param
    ), 

    user_all_group as (
        select 
            dt_param as dt,
            'all' as user_group,
            user_id,
            coalesce(last_access_info.appsflyer_id,"unknown") as appsflyer_id,
            coalesce(permanent_geo_address.geo_country_name,"unknown") as country_name,
            coalesce(last_access_info.app_info.platform,"unknown") as platform,
            coalesce(last_access_info.app_info.app_version,"unknown") as app_version,
            user_login_type,
            user_tenure_type,
            user_activity_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        from favie_dw.dim_favie_decofy_user_account_snapshot_with_ad_function(dt_param,false)
    ),

    user_ab_groups_base AS (
        SELECT DISTINCT 
            t1.dt, 
            'ab_' || t1.ab_project || '@' || t1.ab_router || '@' || t1.ab_unique_id AS user_group,
            t1.user_id
        FROM ab_info t1 
        left outer join ab_info t2
        ON t1.dt = t2.dt AND t1.ab_project = t2.ab_project
        where t2.ab_project is not null
    ),

    user_decofy_complete_base as (
        select distinct 
            dt_param as dt,
            'decofy_complete' as user_group,
            user_id,
        from favie_dw.dws_decofy_refer_general_metrics_inc_1d
        where dt > DATE_SUB(dt_param, INTERVAL 30 DAY)
            and dt <= dt_param
            and refer = 'chat' 
            AND ap_name = 'ap_deco_result'
            and data_name = 'refer_view_item_list_cnt'
            and data_value > 0            
    ),

    other_groups_base AS (
        select 
            dt,
            user_group,
            user_id
        from user_decofy_complete_base
        union all
        select 
            dt,
            user_group,
            user_id
        from user_ab_groups_base
    ),

    other_groups as (
        SELECT 
            t1.dt,
            t1.user_group,
            t1.user_id,
            t2.appsflyer_id,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_login_type,
            t2.user_tenure_type,
            t2.user_activity_type,
            t2.membership_tenure_type,
            t2.membership_pay_status,
            t2.ad_source,
            t2.ad_id,
            t2.ad_group_id,
            t2.ad_campaign_id
        FROM other_groups_base t1
        left outer join user_all_group t2
        on t1.user_id = t2.user_id and t2.dt = dt_param
    ),

    result_group as (
        SELECT 
            dt,
            user_group,
            user_id,
            appsflyer_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_activity_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        FROM user_all_group
        UNION ALL
        SELECT 
            dt,
            user_group,
            user_id,
            appsflyer_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_activity_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        FROM other_groups
    )

    select 
        dt,
        user_group,
        user_id,
        appsflyer_id,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_type,
        user_activity_type,
        membership_tenure_type,
        membership_pay_status,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id
    from result_group