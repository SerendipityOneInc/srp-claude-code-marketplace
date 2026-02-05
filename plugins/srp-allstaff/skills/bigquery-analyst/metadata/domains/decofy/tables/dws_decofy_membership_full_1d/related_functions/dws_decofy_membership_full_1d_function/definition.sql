WITH base_data AS (
        SELECT
            dt_param AS dt,
            user_id,
            appsflyer_id,
            order_source,
            product_id,
            simple_product_id,
            order_id,
            subscription_id,
            order_created_at,
            order_expires_date,
            order_renewal_at,
            order_type,
            order_category,
            order_paid_amount,
            order_seq,
            order_subscription_seq,
            subscription_seq,
            first_value(order_created_at) OVER (PARTITION BY user_id,subscription_id ORDER BY order_created_at ASC)  AS subscribe_at,
            row_number() OVER (PARTITION BY user_id ORDER BY order_created_at ASC) AS rn_asc,
            row_number() OVER (PARTITION BY user_id ORDER BY order_created_at DESC) AS rn_desc
        FROM favie_dw.dwd_favie_decofy_subscription_order_full_1d
        WHERE dt = (SELECT max(dt) FROM favie_dw.dwd_favie_decofy_subscription_order_full_1d WHERE dt IS NOT NULL)
            AND date(order_created_at) <= dt_param
    )
    SELECT
        dt,
        user_id,
        appsflyer_id,
        order_source,
        -- 会员生命周期
        MAX(CASE WHEN rn_desc = 1 THEN
            CASE
                WHEN date(order_created_at) = dt_param AND order_subscription_seq = 1 THEN 'new'
                WHEN date(order_expires_date) > dt_param THEN 'active'
                WHEN date(order_expires_date) = dt_param THEN 'expiring'
                WHEN date(order_expires_date) < dt_param THEN 'expired'
                ELSE 'unknown'
            END
        END) AS membership_tenure_type,
        -- 首次订阅
        MIN(order_created_at) AS first_subscribe_at,
        MIN(CASE WHEN rn_asc = 1 THEN product_id END) AS first_subscribe_product_id,
        MIN(CASE WHEN rn_asc = 1 THEN simple_product_id END) AS first_subscribe_simple_product_id,
        MIN(CASE WHEN order_paid_amount > 0 THEN order_created_at END) AS first_pay_at,
        min(CASE WHEN order_paid_amount > 0 THEN subscribe_at ELSE NULL END) AS first_pay_subscribe_at,

        -- 最近一次订阅
        MAX(if(order_subscription_seq = 1, order_created_at, NULL)) AS latest_subscribe_at,
        MAX(subscription_seq) AS latest_subscribe_seq,
        -- 最近一次订单
        MAX(CASE WHEN rn_desc = 1 THEN product_id END) AS latest_order_product_id,
        MAX(CASE WHEN rn_desc = 1 THEN simple_product_id END) AS latest_order_simple_product_id,
        MAX(CASE WHEN rn_desc = 1 THEN order_expires_date END) AS latest_order_expires_date,
        MAX(CASE WHEN rn_desc = 1 THEN order_renewal_at END) AS latest_order_renewal_at,
        MAX(CASE WHEN rn_desc = 1 THEN order_created_at END) AS latest_order_created_at,
        MAX(CASE WHEN rn_desc = 1 THEN order_subscription_seq END) AS latest_order_subscription_seq,
        MAX(CASE WHEN rn_desc = 1 THEN order_category END) AS latest_order_category,
        MAX(CASE WHEN rn_desc = 1 THEN order_type END) AS latest_order_type,
        MAX(CASE WHEN rn_desc = 1 THEN order_seq END) AS latest_order_seq,
        -- 新增累计指标
        COUNT(1) AS total_order_cnt,
        COUNTIF(order_paid_amount > 0) AS total_paid_order_cnt,
        SUM(CASE WHEN order_paid_amount > 0 THEN order_paid_amount ELSE 0 END) AS total_paid_order_usd_amount,
        COUNT(DISTINCT subscription_id) AS total_subscribe_cnt,
        COUNT(DISTINCT product_id) AS total_subscribe_product_cnt,
        ARRAY_AGG(DISTINCT product_id) AS subscribe_products
    FROM base_data
    GROUP BY dt, user_id, appsflyer_id, order_source