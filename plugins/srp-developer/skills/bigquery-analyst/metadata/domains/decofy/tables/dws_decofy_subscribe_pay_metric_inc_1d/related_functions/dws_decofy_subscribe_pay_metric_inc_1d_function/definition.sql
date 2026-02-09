WITH new_user_base AS (
		SELECT
            date(created_at) as user_created_date,
            user_id,
            first_access_info.appsflyer_id as appsflyer_id,
            permanent_geo_address as geo_address,
            last_access_info.app_info as app_info,
            created_at
		FROM favie_dw.dim_favie_decofy_user_account_scd2_1d
		WHERE is_current = true 
            and date(created_at) > date_sub(dt_param, INTERVAL 14 DAY)
            and date(created_at) <= dt_param
            and not is_internal_user
	),

    new_user_order_base as (
        select 
            t1.user_created_date,
            t1.user_id,
            t1.geo_address,
            t1.app_info,
            t2.order_source,
            t2.order_created_at,
            t2.order_paid_amount,
            t2.order_subscription_seq,
            t2.product_id,
            t2.simple_product_id,
            t2.product_with_trial,
            t2.subscription_id,
            t2.product_price,
            t2.product_first_order_price,
            if(t2.product_with_trial = 1,0,t2.product_price - t2.product_first_order_price) as product_first_order_discount_amount,
            first_value(if(t2.order_subscription_seq = 1,t2.order_created_at ,null)) over(partition by t2.user_id,t2.subscription_id order by t2.order_created_at) as subscribe_at
        from new_user_base t1 
        left outer join (
          select * from  favie_dw.dwd_favie_decofy_subscription_order_full_1d
          where dt = (select max(dt) from favie_dw.dwd_favie_decofy_subscription_order_full_1d)
        ) t2 on t1.user_id = t2.user_id
    ),


    new_user_order_info as (
        select 
            user_created_date,
            user_id,
            geo_address,
            app_info,

            product_id,
            simple_product_id,
            subscription_id,
            product_with_trial,
            order_source,

            if(
                subscribe_at is not null 
                and order_subscription_seq = 1
                and date(subscribe_at) < date_add(user_created_date, INTERVAL 7 DAY), 
            user_id, null) as subscribe_7d_user_id,            
            if(
                subscribe_at is not null 
                and order_subscription_seq = 1
                and date(subscribe_at) < date_add(user_created_date, INTERVAL 7 DAY), 
            subscription_id, null) as subscribe_7d_subscription_id,
            if(
                subscribe_at is not null 
                and order_subscription_seq = 1
                and date(subscribe_at) < date_add(user_created_date, INTERVAL 7 DAY), 
            product_first_order_discount_amount, null) as subscribe_7d_first_order_discount_amount,

            if(
                order_paid_amount > 0
                and subscribe_at is not null
                and date(subscribe_at) < date_add(user_created_date, INTERVAL 7 DAY) 
                and date(order_created_at) < date_add(user_created_date, INTERVAL 14 DAY), 
            user_id, null) as subscribe_pay_14d_user_id,

            if(
                order_paid_amount > 0
                and subscribe_at is not null
                and date(subscribe_at) < date_add(user_created_date, INTERVAL 7 DAY) 
                and date(order_created_at) < date_add(user_created_date, INTERVAL 14 DAY), 
            subscription_id, null) as subscribe_pay_14d_subscription_id

        from new_user_order_base
    ),

    user_order_metrics as (
        select
            user_created_date,
            user_id,
            product_id,
            simple_product_id,
            subscription_id,
            product_with_trial,
            order_source,
            max(subscribe_7d_user_id) as subscribe_7d_user_id,
            max(subscribe_7d_subscription_id) as subscribe_7d_subscription_id,
            sum(subscribe_7d_first_order_discount_amount) as subscribe_7d_first_order_discount_amount,
            max(subscribe_pay_14d_user_id) as subscribe_pay_14d_user_id,
            max(subscribe_pay_14d_subscription_id) as subscribe_pay_14d_subscription_id
        from new_user_order_info
        group by user_created_date, user_id, product_id, simple_product_id, subscription_id,product_with_trial,order_source
    ),

    user_group AS (
        SELECT
            dt,
            user_id,
            user_group,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        FROM favie_dw.dws_decofy_user_group_inc_1d
        where dt > date_sub(dt_param, INTERVAL 14 DAY)
            and dt <= dt_param
    )

    SELECT
        t1.user_created_date as dt,
        t1.user_id,
        t2.country_name,
        t2.platform,
        t2.app_version,
        t2.user_group,
        t2.ad_source,
        t2.ad_id,
        t2.ad_group_id,
        t2.ad_campaign_id,
        t1.product_id,
        t1.simple_product_id,
        t1.product_with_trial,
        t1.order_source,
        t1.subscribe_7d_user_id,
        t1.subscribe_7d_subscription_id,
        t1.subscribe_7d_first_order_discount_amount,
        t1.subscribe_pay_14d_user_id,
        t1.subscribe_pay_14d_subscription_id
    FROM user_order_metrics t1
    LEFT JOIN user_group t2
        ON t1.user_id = t2.user_id AND t1.user_created_date = t2.dt
    where t2.user_id is not null