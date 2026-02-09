# dwd_favie_decofy_subscription_order_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-15
**最后更新**: 2025-09-15

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH  product_info AS (
        SELECT 
            product_id,
            simple_product_id,
            price_usd as product_price,
            `period` as product_period,
            'USD' AS product_currency,
            is_include_trial as product_with_trial,
            first_order_price_usd as product_first_order_price
        FROM `favie_dw.dim_decofy_package_price_mapping_view` 
    ),
 
    subscription_data AS (
        SELECT 
            t1.user_id,
            t3.appsflyer_id,
            t1.original_transaction_id,
            t1.transaction_id as order_id,
            coalesce(t1.price,0) as order_paid_amount,
            t1.currency as order_paid_currency,
            CAST(t1.created_at AS TIMESTAMP) as order_created_at,
            CAST(t1.updated_at AS TIMESTAMP) as order_updated_at,
            CAST(t1.expires_date AS TIMESTAMP) as order_expires_date,
            CAST(t1.deleted_at AS TIMESTAMP) as order_deleted_at,

            t1.product_id,
            t2.simple_product_id,
            t2.product_price,
            t2.product_first_order_price,
            t2.product_currency,
            t2.product_with_trial,
            t2.product_period,

            -- 合并订单类型字段
            CASE 
                WHEN coalesce(t1.price,0) > 0 THEN 'pay_order'
                WHEN coalesce(t1.price,0) = 0 and t2.product_with_trial = 1 THEN 'trial_order'
                WHEN coalesce(t1.price,0) = 0 and t2.product_with_trial = 0 THEN 'benefit_order'
                ELSE 'unknown_order'
            END AS order_category
        FROM `favie_dw.dim_decofy_subscriptions_view` t1
        left outer join product_info t2
        on date(t1.created_at) <= dt_param and t1.product_id = t2.product_id 
        left outer join favie_dw.dim_favie_decofy_user_account_changelog_1d t3
        on date(t1.created_at) <= dt_param and t1.user_id = t3.user_id 
        where date(t1.created_at) <= dt_param
    ),

    subscription_with_timing AS (
        SELECT 
            sd.user_id,
            sd.appsflyer_id,
            sd.original_transaction_id,
            sd.order_id,
            sd.order_paid_amount,
            sd.order_paid_currency,
            sd.order_created_at,
            sd.order_updated_at,
            sd.order_expires_date,
            sd.order_deleted_at,
            sd.order_category,
            sd.product_id,
            sd.simple_product_id,
            sd.product_price,
            sd.product_first_order_price,
            sd.product_currency,
            sd.product_with_trial,
            sd.product_period,
            DATE_DIFF(dt_param, DATE(sd.order_expires_date), DAY) as order_days_to_expire,
            ROW_NUMBER() OVER (PARTITION BY sd.user_id ORDER BY sd.order_created_at) as order_seq,
            LAG(sd.product_id) OVER (PARTITION BY sd.user_id,sd.original_transaction_id ORDER BY sd.order_created_at) as pre_product_id

        FROM subscription_data sd
    ),

    subscription_with_product_seq as (
        select 
            user_id,
            appsflyer_id,
            original_transaction_id,
            order_id,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            order_category,
            product_id,
            simple_product_id,
            product_price,
            product_first_order_price,
            product_currency,
            product_with_trial,
            product_period,
            order_seq,
            order_days_to_expire,
            sum(if(product_id != pre_product_id, 1, 0)) over subscription_window as subscription_product_seq
        from subscription_with_timing
        window subscription_window as (
                  partition by user_id,original_transaction_id
                  order by `order_created_at`
                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )
    ),
    subscription_with_decofy_id as (
        select 
            user_id,
            appsflyer_id,
            concat(original_transaction_id,"@",simple_product_id,"@",subscription_product_seq) as subscription_id,
            original_transaction_id,
            order_id,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            order_category,
            product_id,
            simple_product_id,
            product_price,
            product_first_order_price,
            product_currency,
            product_with_trial,
            product_period,
            order_seq,
            order_days_to_expire,
        from subscription_with_product_seq
    ),
    
    subscription_final_seq as (
        select 
            user_id,
            appsflyer_id,
            subscription_id,
            original_transaction_id,
            order_id,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            order_category,
            product_id,
            simple_product_id,
            product_price,
            product_first_order_price,
            product_currency,
            product_with_trial,
            product_period,
            order_seq,
            order_days_to_expire,
            FIRST_VALUE(order_created_at) OVER (
                PARTITION BY user_id,subscription_id 
                ORDER BY order_created_at 
                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) AS subscription_created_at,            
            ROW_NUMBER() OVER (PARTITION BY user_id,subscription_id ORDER BY order_created_at) as order_subscription_seq,
            LAG(order_category) OVER (PARTITION BY user_id, subscription_id ORDER BY order_created_at) as prev_order_category,
            LAG(subscription_id) OVER (PARTITION BY user_id, subscription_id ORDER BY order_created_at) as prev_subscription_id,
            LEAD(order_created_at) OVER (PARTITION BY user_id, subscription_id ORDER BY order_created_at) AS next_order_created_at
        from subscription_with_decofy_id
    ),

    subscription_final_types AS (
        SELECT
            user_id,
            order_id,
            appsflyer_id,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            next_order_created_at as order_renewal_at,
            order_category,
            product_id,
            simple_product_id,
            product_price,
            product_first_order_price,
            product_currency,
            product_with_trial,
            product_period,
            order_seq,
            order_subscription_seq,
            order_days_to_expire,
            subscription_id,
            subscription_created_at,

            DENSE_RANK() OVER (
                PARTITION BY user_id
                ORDER BY subscription_created_at
            ) as subscription_seq,

            original_transaction_id,

            CASE
                WHEN order_category = 'trial_order' and order_subscription_seq = 1 THEN 'trial'
                WHEN order_category = 'benefit_order' and order_subscription_seq = 1 THEN 'benefit'
                WHEN order_category = 'pay_order' AND (prev_subscription_id is null or subscription_id != prev_subscription_id) THEN 'paid'
                WHEN order_category = 'pay_order' 
                    AND prev_subscription_id is not null 
                    AND subscription_id = prev_subscription_id  
                    AND prev_order_category = 'trial_order' THEN 'trial_to_paid'
                WHEN order_category = 'pay_order' 
                    AND prev_subscription_id is not null 
                    AND subscription_id = prev_subscription_id 
                    AND prev_order_category = 'benefit_order' THEN 'benefit_to_paid'
                WHEN order_category = 'pay_order' 
                    AND prev_subscription_id is not null 
                    AND subscription_id = prev_subscription_id 
                    AND prev_subscription_id = subscription_id 
                    AND prev_order_category = 'pay_order' THEN 'renewal'
                ELSE 'unknown'
            END AS order_type
        FROM subscription_final_seq
    )

    SELECT 
        dt_param AS dt,
        user_id,
        appsflyer_id,

        product_id,
        simple_product_id,
        product_price,
        product_first_order_price,
        product_currency,
        product_with_trial,
        product_period,

        subscription_id,
        subscription_created_at,
        subscription_seq,
        original_transaction_id,

        order_id,
        "iOS" as order_source,
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
        order_days_to_expire,
        
    FROM subscription_final_types
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
