CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_decofy_user_subscription_view`
AS WITH subscription_intension_data AS (
        SELECT 
            dt,
            user_id,
            cal_pre_refer,
            (
                select 
                    event_item.item_name
                from unnest(event_items) as event_item
                where event_item.item_type = "trigger_reason"
                limit 1
            ) as trigger_pay_reason,
            event_timestamp
        FROM favie_dw.dwd_favie_decofy_events_inc_1d
        WHERE dt IS NOT NULL
            AND refer = 'unsubscribe_view'
            and event_action_type = 'trigger_pay'

    ),
    subscription_order_data AS (
        SELECT 
            dt,
            user_id,
            appsflyer_id,
            product_id,
            simple_product_id,
            product_price,
            product_currency,
            product_with_trial,
            subscription_id,
            subscription_created_at,
            subscription_seq,
            order_id,
            order_source,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            order_renewal_at,
            order_category,
            order_type,
            order_seq,
            order_subscription_seq,
            order_category_seq,
            order_days_to_expire
        FROM favie_dw.dwd_favie_decofy_subscription_order_full_1d 
        WHERE dt = (SELECT max(dt) FROM favie_dw.dwd_favie_decofy_subscription_order_full_1d WHERE dt IS NOT NULL)
    ),
    joined AS (
        SELECT
            a.dt,
            a.user_id,
            a.trigger_pay_reason,
            a.event_timestamp AS trigger_pay_timestamp,
            b.appsflyer_id,
            b.product_id,
            b.simple_product_id,
            b.product_price,
            b.product_currency,
            b.product_with_trial,
            b.subscription_id,
            b.subscription_created_at,
            b.subscription_seq,
            b.order_id,
            b.order_source,
            b.order_paid_amount,
            b.order_paid_currency,
            b.order_created_at,
            b.order_updated_at,
            b.order_expires_date,
            b.order_deleted_at,
            b.order_renewal_at,
            b.order_category,
            b.order_type,
            b.order_seq,
            b.order_subscription_seq,
            b.order_category_seq,
            b.order_days_to_expire,
            ROW_NUMBER() OVER (
                PARTITION BY a.user_id, a.event_timestamp
                ORDER BY b.order_created_at ASC
            ) AS rn
        FROM subscription_intension_data a
        LEFT JOIN subscription_order_data b
            ON a.user_id = b.user_id
         AND b.order_created_at > a.event_timestamp
    )
    SELECT
        dt,
        user_id,
        trigger_pay_reason as intension_source,
        trigger_pay_timestamp as intension_timestamp,
        appsflyer_id,
        product_id,
        simple_product_id,
        product_price,
        product_currency,
        product_with_trial,
        subscription_id,
        subscription_created_at,
        subscription_seq,
        order_id,
        order_source,
        order_paid_amount,
        order_paid_currency,
        order_created_at,
        order_updated_at,
        order_expires_date,
        order_deleted_at,
        order_renewal_at,
        order_category,
        order_type,
        order_seq,
        order_subscription_seq,
        order_category_seq,
        order_days_to_expire
    FROM joined
    WHERE rn = 1;