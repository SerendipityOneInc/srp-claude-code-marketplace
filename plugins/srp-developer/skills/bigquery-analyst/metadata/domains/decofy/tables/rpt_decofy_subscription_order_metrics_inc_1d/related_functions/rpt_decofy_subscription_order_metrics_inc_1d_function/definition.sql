WITH order_base AS (
        SELECT
            o.dt,
            o.user_id,
            o.appsflyer_id,
            o.order_source,
            o.product_id,
            o.simple_product_id,
            o.order_id,
            if(o.order_paid_amount>0,o.product_price,0) as order_paid_amount,
            o.order_expires_date,
            o.order_category,
            o.order_type,
            o.subscription_id,
            o.subscription_seq,
            o.order_created_at,
            o.order_renewal_at,
        FROM favie_dw.dwd_favie_decofy_subscription_order_full_1d o
        WHERE o.dt = (SELECT MAX(dt) FROM favie_dw.dwd_favie_decofy_subscription_order_full_1d)
            and (
                date(o.order_created_at) = dt_param 
                or date(o.order_expires_date) = dt_param
            )
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
      where  dt = dt_param
    ),

    joined AS (
        SELECT
            o.dt,
            u.country_name,
            u.platform,
            u.app_version,
            u.user_group,
            u.ad_source,
            u.ad_id,
            u.ad_group_id,
            u.ad_campaign_id,
            o.product_id,
            o.simple_product_id,
            o.order_source,
            -- 订阅类型
            CASE WHEN o.subscription_seq = 1 THEN 'first_subscription' ELSE 'resubscription' END AS subscription_type,
            o.order_category,
            o.order_type,
            o.user_id,
            o.order_id,
            o.order_paid_amount,
            o.order_expires_date,
            o.order_renewal_at,
            o.order_created_at
        FROM order_base o
        LEFT JOIN user_group u ON o.user_id = u.user_id
        WHERE u.user_group is not null
    )

    SELECT
        dt_param as dt,
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
        order_type,

        COUNTIF(DATE(order_created_at) = dt_param) AS created_order_cnt,
        SUM(IF(DATE(order_created_at) = dt_param, order_paid_amount, 0)) AS created_order_amount,
        -- 新增：到期订单
        SUM(CASE WHEN date(order_expires_date) = dt_param THEN 1 ELSE 0 END) AS due_order_cnt,
        SUM(CASE WHEN date(order_expires_date) = dt_param THEN order_paid_amount ELSE 0 END) AS due_order_amount,
        -- 新增：续订订单
        SUM(CASE WHEN date(order_expires_date) = dt_param AND order_renewal_at IS NOT NULL THEN 1 ELSE 0 END) AS renewed_order_cnt,
        SUM(CASE WHEN date(order_expires_date) = dt_param AND order_renewal_at IS NOT NULL THEN order_paid_amount ELSE 0 END) AS renewed_order_amount
    FROM  joined
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
        product_id,
        simple_product_id,
        order_source,
        subscription_type,
        order_category,
        order_type