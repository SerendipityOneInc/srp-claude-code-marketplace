# rpt_decofy_subscribe_renewal_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_renewal_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-23
**最后更新**: 2025-09-23

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

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
      and date(order_created_at) <= dt_param
      and date(order_expires_date) <= dt_param  
      and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day DAY)
  ),

  user_group AS (
    select 
      *
    from (
      SELECT
          dt,
          user_id,
          user_group,
          country_name,
          platform,
          ad_source,
          ad_id,
          ad_group_id,
          ad_campaign_id,
          row_number() over(partition by user_id,user_group order by dt) as rn
      FROM favie_dw.dws_decofy_user_group_inc_1d
      WHERE dt > DATE_SUB(dt_param, INTERVAL 14 DAY)
          AND dt <= dt_param
    ) where rn = 1
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
        countif(order_subscription_seq = 1) as first_order_due_cnt,
        countif(order_subscription_seq = 1 and order_renewal_at is not null) as first_order_renewal_cnt,
        countif(order_subscription_seq = 2) as second_order_due_cnt,
        countif(order_subscription_seq = 2 and order_renewal_at is not null) as second_order_renewal_cnt,
        countif(order_subscription_seq >= 3) as third_more_order_due_cnt,
        countif(order_subscription_seq >= 3 and order_renewal_at is not null) as third_more_order_renewal_cnt
    FROM order_base
    GROUP BY dt, user_id, appsflyer_id, product_id, simple_product_id, product_with_trial, subscription_id, order_source
  ),

  final_data as (
    SELECT
      t1.dt,
      t2.country_name,
      t2.platform,
      t2.user_group,
      t2.ad_source,
      t2.ad_id,
      t2.ad_group_id,
      t2.ad_campaign_id,
      t1.product_id,
      t1.simple_product_id,
      t1.product_with_trial,
      t1.order_source,
      sum(t1.first_order_due_cnt) as first_order_due_cnt,
      sum(t1.first_order_renewal_cnt) as first_order_renewal_cnt,
      sum(t1.second_order_due_cnt) as second_order_due_cnt,
      sum(t1.second_order_renewal_cnt) as second_order_renewal_cnt,
      sum(t1.third_more_order_due_cnt) as third_more_order_due_cnt,
      sum(t1.third_more_order_renewal_cnt) as third_more_order_renewal_cnt
    FROM renewal_metric t1 left outer join user_group t2
      on t1.user_id = t2.user_id 
    where t2.user_id is not null
    GROUP BY 
      t1.dt,
      t2.country_name,
      t2.platform,
      t2.user_group,
      t2.ad_source,
      t2.ad_id,
      t2.ad_group_id,
      t2.ad_campaign_id,
      t1.product_id,
      t1.simple_product_id,
      t1.product_with_trial,
      t1.order_source
  )


  SELECT
    dt,

    country_name,
    platform,
    user_group,
    ad_source,
    ad_id,
    ad_group_id,
    ad_campaign_id,

    product_id,
    simple_product_id,
    product_with_trial,
    order_source,

    first_order_due_cnt,
    first_order_renewal_cnt,

    second_order_due_cnt,
    second_order_renewal_cnt,


    third_more_order_due_cnt,
    third_more_order_renewal_cnt
  FROM final_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
