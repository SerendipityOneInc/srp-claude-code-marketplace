CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_ltv_metric_view`
AS with pay_metric as (
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
            product_id,
            simple_product_id,
            product_with_trial,
            order_source,
            count(distinct user_id) as new_user_cnt,
            count(distinct subscribe_7d_user_id) as subscribe_7d_user_cnt,
            count(distinct subscribe_7d_subscription_id) as subscribe_7d_subscription_cnt,
            sum(subscribe_7d_first_order_discount_amount) as subscribe_7d_first_order_discount_amt,
            count(distinct subscribe_pay_14d_user_id) as subscribe_pay_14d_user_cnt,
            count(distinct subscribe_pay_14d_subscription_id) as subscribe_pay_14d_subscription_cnt
        from favie_dw.dws_decofy_subscribe_pay_metric_inc_1d
        where dt is not null
        group by
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
            product_with_trial,
            order_source
    ),

    lt_metric as (
        select
            dt,
            product_id,
            simple_product_id,
            product_with_trial,
            order_source,
            subscription_LT,
            subscription_paid_LT,
            free_trial_paid_rate,
            first_order_renewal_rate,
            paid_LT
        from favie_rpt.rpt_decofy_subscribe_lt_metric_view
    ),

    ltv_metric as (
        select 
            t1.dt,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_group,
            t1.ad_source,
            t1.ad_id,
            t1.ad_group_id,
            t1.ad_campaign_id,
            t1.product_id,
            t1.simple_product_id,
            t1.product_with_trial,
            t1.new_user_cnt,
            t1.subscribe_7d_user_cnt,
            t1.subscribe_7d_subscription_cnt,
            t1.subscribe_7d_first_order_discount_amt,
            t1.subscribe_pay_14d_user_cnt,
            if(t1.product_with_trial=1,subscribe_7d_user_cnt*t2.first_order_renewal_rate,t1.subscribe_7d_user_cnt) as predict_subscribe_7d_user_cnt,
            t1.subscribe_pay_14d_subscription_cnt,
            t1.order_source,
            t2.subscription_LT,
            t2.subscription_paid_LT,
            t2.free_trial_paid_rate,
            t2.paid_LT,
            t3.price_usd as product_price,
            (t1.subscribe_7d_subscription_cnt * t3.price_usd * t2.subscription_paid_LT - t1.subscribe_7d_first_order_discount_amt) * 0.001 as LTV_7d
        from pay_metric t1 
        left join lt_metric t2
        on t1.dt = t2.dt
            and t1.product_id = t2.product_id
            and t1.simple_product_id = t2.simple_product_id
            and t1.product_with_trial = t2.product_with_trial
            and t1.order_source = t2.order_source
        left outer join favie_dw.dim_decofy_product_config t3
        on t1.product_id = t3.product_id
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
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        new_user_cnt,
        subscribe_7d_user_cnt,
        subscribe_7d_subscription_cnt,
        subscribe_7d_first_order_discount_amt,
        subscribe_pay_14d_user_cnt,
        subscribe_pay_14d_subscription_cnt,
        predict_subscribe_7d_user_cnt,
        subscription_LT,
        subscription_paid_LT,
        free_trial_paid_rate,
        paid_LT,
        product_price,
        round(LTV_7d,2) as LTV_7d
    from ltv_metric;