# dws_decofy_membership_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_membership_full_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-11
**最后更新**: 2025-09-11

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
BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;
  WHILE n_day >= 1 DO
    DELETE FROM favie_dw.dws_decofy_membership_full_1d
    WHERE dt = current_dt;
    INSERT INTO favie_dw.dws_decofy_membership_full_1d
    (
      dt,
      user_id,
      appsflyer_id,
      order_source,
      membership_tenure_type,
      first_subscribe_at,
      first_subscribe_product_id,
      first_subscribe_simple_product_id,
      first_pay_at,
      first_pay_subscribe_at,
      latest_subscribe_at,
      latest_subscribe_seq,
      latest_order_product_id,
      latest_order_simple_product_id,
      latest_order_expires_date,
      latest_order_renewal_at,
      latest_order_created_at,
      latest_order_subscription_seq,
      latest_order_category,
      latest_order_type,
      latest_order_seq,
      total_paid_order_cnt,
      total_paid_order_usd_amount,
      total_subscribe_cnt,
      total_subscribe_product_cnt,
      total_order_cnt,
      subscribe_products
    )
    SELECT
      dt,
      user_id,
      appsflyer_id,
      order_source,
      membership_tenure_type,
      first_subscribe_at,
      first_subscribe_product_id,
      first_subscribe_simple_product_id,
      first_pay_at,
      first_pay_subscribe_at,
      latest_subscribe_at,
      latest_subscribe_seq,
      latest_order_product_id,
      latest_order_simple_product_id,
      latest_order_expires_date,
      latest_order_renewal_at,
      latest_order_created_at,
      latest_order_subscription_seq,
      latest_order_category,
      latest_order_type,
      latest_order_seq,
      total_order_cnt,
      total_paid_order_cnt,
      total_paid_order_usd_amount,
      total_subscribe_cnt,
      total_subscribe_product_cnt,
      subscribe_products
    FROM favie_dw.dws_decofy_membership_full_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
