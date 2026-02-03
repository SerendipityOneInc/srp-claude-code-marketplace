# dwd_favie_decofy_subscription_order_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d_procedure`
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
        -- 删除目标日期的现有数据
        DELETE FROM `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
        WHERE dt = current_dt;

        -- 插入新数据
        INSERT INTO `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
        (
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
            order_days_to_expire,
            
        FROM `favie_dw.dwd_favie_decofy_subscription_order_full_1d_function`(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
