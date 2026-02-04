CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_user_penetration_rate_view`
AS select 
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
        SUM(current_user_cnt) AS total_user_cnt,
        
        -- 订阅用户数（有任何订阅状态的用户，排除无订阅）
        SUM(CASE WHEN user_subcription_type != 'no_subscription' THEN current_user_cnt ELSE 0 END) AS subscription_user_cnt
        
    from favie_rpt.rpt_decofy_user_subscription_metrics_inc_1d
    GROUP BY 
        dt,
        country_name,
        platform,
        app_version,
        user_group,
        user_subcription_type,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id;