CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_renewal_conversion_rate_view`
AS SELECT
        dt,
        country_name,
        platform,
        app_version,
        user_group,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        product_id,
        simple_product_id,
        order_source,
        subscription_type,
        order_category,
        case 
            when order_type in ('renewal','paid') then 'renewal'
            when order_type in ('trial','trial_to_paid') then 'trial_to_paid'
            when order_type in ('benefit','benefit_to_paid') then 'benefit_to_paid'
            else 'unknown'
        end as renewal_type,
        subscription_renewal_user_cnt as renewal_user_cnt,
        subscription_should_expires_user_cnt as expires_user_cnt
    FROM
        `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d`
    WHERE dt is not null 
        and membership_tenure_type in('active','expiring');