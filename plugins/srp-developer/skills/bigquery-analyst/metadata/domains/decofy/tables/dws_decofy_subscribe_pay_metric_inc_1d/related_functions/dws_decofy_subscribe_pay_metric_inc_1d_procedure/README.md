# dws_decofy_subscribe_pay_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_pay_metric_inc_1d_procedure`
**类型**: PROCEDURE
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
BEGIN
  -- 删除指定分区，避免重复插入
  DELETE FROM favie_dw.dws_decofy_subscribe_pay_metric_inc_1d
  WHERE dt > date_sub(dt_param,INTERVAL 14 DAY) and dt <= dt_param;

  -- 插入新数据
  INSERT INTO favie_dw.dws_decofy_subscribe_pay_metric_inc_1d (
    dt,
    user_id,
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
    subscribe_7d_user_id,
    subscribe_7d_subscription_id,
    subscribe_7d_first_order_discount_amount,
    subscribe_pay_14d_user_id,
    subscribe_pay_14d_subscription_id
  )
  SELECT
    dt,
    user_id,
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
    subscribe_7d_user_id,
    subscribe_7d_subscription_id,
    subscribe_7d_first_order_discount_amount,
    subscribe_pay_14d_user_id,
    subscribe_pay_14d_subscription_id
  FROM favie_dw.dws_decofy_subscribe_pay_metric_inc_1d_function(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
