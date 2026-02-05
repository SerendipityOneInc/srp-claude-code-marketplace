# dwd_gem_product_image_index_full_xd_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_full_xd_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2026-01-19
**最后更新**: 2026-01-19

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| index_env_type | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |
| emb_model_version | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    DELETE FROM `favie_dw.dwd_gem_product_image_index_full_xd`
    WHERE dt = dt_param and index_env = index_env_type;

    INSERT INTO `favie_dw.dwd_gem_product_image_index_full_xd` (
        dt,
        CMD,
        record_update_time,
        record_create_time,
        index_env,

        f_sku_id,
        f_spu_id,
        site,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        norm_brand,
        is_used,
        inventory,
        f_status,
        created_time,
        emb_images,
        product_create_time,
        product_update_time
    )
    SELECT
        dt,
        CMD,
        record_update_time,
        record_create_time,
        index_env_type as index_env,
        f_sku_id,
        f_spu_id,
        site,
        local_price,
        local_currency,
        base_price,
        base_currency,
        discount,
        norm_brand,
        is_used,
        inventory,
        f_status,
        created_time,
        emb_images,
        product_create_time,
        product_update_time
    FROM favie_dw.dwd_gem_product_image_index_full_xd_function(
        dt_param,
        emb_model_version
    );

    call favie_dw.dwd_partition_clear_procedure('favie_dw','dwd_gem_product_image_index_full_xd',2);
    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_image_index_full_xd', dt_param, index_env_type);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
