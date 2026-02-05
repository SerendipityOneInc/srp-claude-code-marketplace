# dwd_gem_product_image_index_inc_1h_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_inc_1h_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-20
**最后更新**: 2026-01-20

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
    DELETE FROM `favie_dw.dwd_gem_product_image_index_inc_1h`
    WHERE dt = dt_param AND record_hour = hour_param;

    INSERT INTO `favie_dw.dwd_gem_product_image_index_inc_1h` (
        dt,
        CMD,
        record_time,
        record_hour,

        f_sku_id,
        f_spu_id,
        site,
        f_status,

        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        is_used,
        inventory,
        image_urls,
        created_time,
        product_create_time,
        product_update_time
    )
    SELECT
        dt,
        CMD,
        record_time,
        record_hour,

        f_sku_id,
        f_spu_id,
        site,
        f_status,

        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        is_used,
        inventory,
        image_urls,
        created_time,
        product_create_time,
        product_update_time
    FROM favie_dw.dwd_gem_product_image_index_inc_1h_function(
        dt_param,
        hour_param
    );

    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_image_index_inc_1h', dt_param, hour_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
