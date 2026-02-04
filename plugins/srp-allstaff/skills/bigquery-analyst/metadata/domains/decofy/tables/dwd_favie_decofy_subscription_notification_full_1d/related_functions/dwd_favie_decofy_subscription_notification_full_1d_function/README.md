# dwd_favie_decofy_subscription_notification_full_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-05
**最后更新**: 2025-09-05

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
            'USD' AS product_currency,
            is_include_trial as product_with_trial,
            `period` as product_period,
            first_order_price_usd as product_first_order_price
        FROM `favie_dw.dim_decofy_package_price_mapping_view` 
    ),
 
    subscription_notification_data AS(
        select 
            dt_param as dt,
            notification_uuid,
            notification_type,
            json_value(renewal_info,"$.originalTransactionId") as original_transaction_id,
            json_value(transaction_info,"$.transactionId") as transaction_id,
            json_value(renewal_info,"$.productId") as product_id,
            json_value(renewal_info,"$.autoRenewProductId") as auto_renew_product_id,
            json_value(renewal_info,"$.expirationIntent") as expiration_intent,
            json_value(renewal_info,"$.autoRenewStatus") as auto_renew_status,
            subscription_status,
            subtype,
            created_at,
            updated_at
        from favie_dw.dim_decofy_subscription_notification_view 
        where date(created_at) <= dt_param
    ),

    user_id_map as (
        select
            original_transaction_id,
            user_id,
            appsflyer_id,
            row_number() over(partition by original_transaction_id order by order_updated_at desc) as rn
        from favie_dw.dwd_favie_decofy_subscription_order_full_1d
        where dt = (select max(dt) from favie_dw.dwd_favie_decofy_subscription_order_full_1d where dt is not null)
    ),


    joined_data as (
        SELECT 
            t1.dt,
            t2.user_id,
            t2.appsflyer_id,
            t1.product_id,
            t3.simple_product_id,
            t3.product_price,
            t3.product_first_order_price,
            t3.product_currency,
            t3.product_with_trial,
            t3.product_period,
            t1.notification_uuid,
            t1.notification_type,
            t1.transaction_id,
            t1.original_transaction_id,
            t1.subscription_status,
            t1.subtype,
            t1.created_at,
            t1.updated_at
        FROM subscription_notification_data t1
        LEFT OUTER JOIN user_id_map t2
        ON t1.original_transaction_id = t2.original_transaction_id and t2.rn = 1
        LEFT OUTER JOIN product_info t3
        ON t1.product_id = t3.product_id
    )

    SELECT 
        dt,
        user_id,
        appsflyer_id,
        product_id,
        simple_product_id,
        product_price,
        product_first_order_price,
        product_currency,
        product_with_trial,
        product_period,
        notification_uuid,
        notification_type,
        transaction_id,
        original_transaction_id,
        subscription_status,
        subtype,
        created_at,
        updated_at
    FROM joined_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
