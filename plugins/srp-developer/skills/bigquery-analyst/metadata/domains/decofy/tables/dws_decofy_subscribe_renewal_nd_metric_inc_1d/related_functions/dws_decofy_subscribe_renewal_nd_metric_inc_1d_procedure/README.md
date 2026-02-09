# dws_decofy_subscribe_renewal_nd_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d_procedure`
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
| n_day_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d
    WHERE dt = dt_param and n_day = n_day_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d (
        dt,
        user_id,
        appsflyer_id,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        n_day,
        first_order_due_cnt,
        first_order_renewal_cnt,
        second_order_due_cnt,
        second_order_renewal_cnt,
        third_more_order_due_cnt,
        third_more_order_renewal_cnt
    )
    SELECT
        dt,
        user_id,
        appsflyer_id,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        n_day,
        first_order_due_cnt,
        first_order_renewal_cnt,
        second_order_due_cnt,
        second_order_renewal_cnt,
        third_more_order_due_cnt,
        third_more_order_renewal_cnt
    FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d_function(dt_param,n_day_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
