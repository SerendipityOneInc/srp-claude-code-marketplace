# dws_decofy_subscribe_renewal_nd_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-25
**最后更新**: 2025-09-25

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with order_base as (
    SELECT
      dt_param as dt,
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
      order_days_to_expire
    FROM
      `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
    WHERE
      dt = (select max(dt) from `favie_dw.dwd_favie_decofy_subscription_order_full_1d`)
      and 
      (
        date(order_created_at) <= dt_param and date(order_created_at) > date_sub(dt_param, INTERVAL n_day_param DAY)
        or 
        date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)
      )
      
  ),

  renewal_metric as (
    SELECT
        dt,
        user_id,
        appsflyer_id,

        product_id,
        simple_product_id,
        product_with_trial,
        subscription_id,

        order_source,
        countif(order_subscription_seq = 1 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)) as first_order_due_cnt,
        countif(order_subscription_seq = 1 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY) and order_renewal_at is not null) as first_order_renewal_cnt,
        countif(order_subscription_seq = 2 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)) as second_order_due_cnt,
        countif(order_subscription_seq = 2 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY) and order_renewal_at is not null) as second_order_renewal_cnt,
        countif(order_subscription_seq >= 3 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)) as third_more_order_due_cnt,
        countif(order_subscription_seq >= 3 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY) and order_renewal_at is not null) as third_more_order_renewal_cnt
    FROM order_base
    GROUP BY dt, user_id, appsflyer_id, product_id, simple_product_id, product_with_trial, subscription_id, order_source
  )

  SELECT
    dt,

    user_id,
    appsflyer_id,

    product_id,
    simple_product_id,
    product_with_trial,
    order_source,

    n_day_param as n_day,

    first_order_due_cnt,
    first_order_renewal_cnt,

    second_order_due_cnt,
    second_order_renewal_cnt,

    third_more_order_due_cnt,
    third_more_order_renewal_cnt
  FROM renewal_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
