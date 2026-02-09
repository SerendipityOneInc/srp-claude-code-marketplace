CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_revenue_view`
AS with decofy_revenue_data as (
        select 
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            user_subcription_type,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            
            -- 总用户数
            'first_paid_revenue' as revenue_type,
            new_paid_revenue_amt as revenue_amt
        from favie_rpt.rpt_decofy_user_subscription_metrics_inc_1d
        union all
        select
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            user_subcription_type,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            -- 总用户数
            'renewal_revenue' as revenue_type,
            new_renewal_revenue_amt as revenue_amt
        from favie_rpt.rpt_decofy_user_subscription_metrics_inc_1d
        union all
        select
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            user_subcription_type,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            -- 总用户数
            'trial_to_paid_revenue' as revenue_type,
            new_trial_to_paid_revenue_amt as revenue_amt
        from favie_rpt.rpt_decofy_user_subscription_metrics_inc_1d
    )

    select 
        dt,
        country_name,
        platform,
        app_version,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        revenue_type,
        SUM(revenue_amt) as total_revenue_amt
    from decofy_revenue_data
    GROUP BY 
        dt,
        country_name,
        platform,
        app_version,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        revenue_type;