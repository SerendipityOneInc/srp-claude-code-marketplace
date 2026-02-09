# rpt_decofy_subscribe_renewal_30d_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_renewal_30d_metric_inc_1d_function`
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

**返回类型**: None

---

## 💻 函数定义

```sql
with renewal_30_day as (
    SELECT
      dt,

      user_id,
      appsflyer_id,

      product_id,
      simple_product_id,
      product_with_trial,
      order_source,

      first_order_due_cnt as first_order_due_30d_cnt,
      first_order_renewal_cnt as first_order_renewal_30d_cnt,

      second_order_due_cnt as second_order_due_30d_cnt,
      second_order_renewal_cnt as second_order_renewal_30d_cnt,

      third_more_order_due_cnt as third_more_order_due_30d_cnt,
      third_more_order_renewal_cnt as third_more_order_renewal_30d_cnt
    FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d
    where dt = dt_param and n_day = 30
  ),

  user_group AS (
    select
        *
    from(
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
            ad_campaign_id,
            row_number() over(partition by user_id,user_group order by dt desc) as rn
        FROM favie_dw.dws_decofy_user_group_inc_1d
        where dt > date_sub(dt_param, INTERVAL 30 DAY)
            and dt <= dt_param
    ) where rn = 1
  ),

  final_data as (
    SELECT
      t1.dt,

      t2.user_group,
      t2.country_name,
      t2.platform,
      t2.ad_source,
      t2.ad_id,
      t2.ad_group_id,
      t2.ad_campaign_id,

      t1.product_id,
      t1.simple_product_id,
      t1.product_with_trial,
      t1.order_source,

      sum(t1.first_order_due_30d_cnt) as first_order_due_30d_cnt,
      sum(t1.first_order_renewal_30d_cnt) as first_order_renewal_30d_cnt,

      sum(t1.second_order_due_30d_cnt) as second_order_due_30d_cnt,
      sum(t1.second_order_renewal_30d_cnt) as second_order_renewal_30d_cnt,

      sum(t1.third_more_order_due_30d_cnt) as third_more_order_due_30d_cnt,
      sum(t1.third_more_order_renewal_30d_cnt) as third_more_order_renewal_30d_cnt
    FROM renewal_30_day t1 left outer join user_group t2
      on t1.user_id = t2.user_id
    where t2.user_id is not null

    GROUP BY 
      t1.dt,
      t1.product_id,
      t1.simple_product_id,
      t1.product_with_trial,
      t1.order_source,
      t2.user_group,
      t2.country_name,
      t2.platform,
      t2.ad_source,
      t2.ad_id,
      t2.ad_group_id,
      t2.ad_campaign_id
  )

  SELECT
    dt,

    user_group,
    country_name,
    platform,
    ad_source,
    ad_id,
    ad_group_id,
    ad_campaign_id,

    product_id,
    simple_product_id,
    product_with_trial,
    order_source,

    first_order_due_30d_cnt,
    first_order_renewal_30d_cnt,

    second_order_due_30d_cnt,
    second_order_renewal_30d_cnt,

    third_more_order_due_30d_cnt,
    third_more_order_renewal_30d_cnt
  FROM final_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
