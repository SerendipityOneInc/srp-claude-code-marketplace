# dwd_gem_product_detail_ha3_inc_1h_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_inc_1h_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-14
**最后更新**: 2026-01-14

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| hour_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    DELETE FROM `favie_dw.dwd_gem_product_detail_ha3_inc_1h`
    WHERE dt = dt_param AND record_hour = hour_param;

    INSERT INTO `favie_dw.dwd_gem_product_detail_ha3_inc_1h` (
        CMD,
        f_sku_id,
        site,
        sku_id,
        spu_id,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        inventory,
        product_created_at,
        product_updated_at,
        record_time,
        record_hour,
        dt
    )
    SELECT
        CMD,
        f_sku_id,
        site,
        sku_id,
        spu_id,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        inventory,
        product_created_at,
        product_updated_at,
        record_time,
        record_hour,
        dt
    FROM favie_dw.dwd_gem_product_detail_ha3_inc_1h_function(dt_param, hour_param);

    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_detail_ha3_inc_1h', dt_param, hour_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
