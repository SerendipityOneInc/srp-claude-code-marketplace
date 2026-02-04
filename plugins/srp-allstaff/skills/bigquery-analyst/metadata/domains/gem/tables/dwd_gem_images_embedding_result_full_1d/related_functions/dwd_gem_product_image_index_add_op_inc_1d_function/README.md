# dwd_gem_product_image_index_add_op_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_add_op_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2026-01-21
**最后更新**: 2026-01-21

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| index_env_type | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |
| emb_model_version | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_algo.dwd_gem_images_embedding_result_full_1d` (dwd_gem_images_embedding_result_full_1d)

---

## 💻 函数定义

```sql
with source_data as (
        select 
            dt_param as dt,
            full_xd.CMD,
            full_xd.record_update_time,
            full_xd.record_create_time,

            full_xd.f_sku_id,
            full_xd.f_spu_id,
            full_xd.site,
            full_xd.local_price,
            full_xd.local_currency,
            full_xd.base_price,
            full_xd.base_currency,
            full_xd.discount,
            full_xd.is_used,
            full_xd.inventory,
            full_xd.f_status,
            full_xd.created_time,
            emb_image,

            full_xd.product_create_time,
            full_xd.product_update_time
        from favie_dw.dwd_gem_product_image_index_full_xd as full_xd,unnest(emb_images) as emb_image
        where dt is not null and dt = (select max(dt) from favie_dw.dwd_gem_product_image_index_full_xd where dt is not null)
            and date(record_update_time) >= dt_param
            and date(emb_image.update_time) >= dt_param
            and emb_image.CMD = 'add'
            and full_xd.CMD = 'add'
            and emb_image.image_url is not null
            and emb_image is not null
            and full_xd.index_env = index_env_type
    ),

    emb_images as (
        SELECT
            f_sku_id,
            f_url,
            result as embedding
        FROM `srpproduct-dc37e.favie_algo.dwd_gem_images_embedding_result_full_1d`
        WHERE date(dt) = dt_param AND model_version = emb_model_version
    )

    SELECT
        'add' as CMD,
        CONCAT(T1.f_sku_id, '_',T1.emb_image.image_url) AS target_image_id,
        T1.f_sku_id,
        T1.f_spu_id,
        T1.site,
        T1.emb_image.image_url AS f_url,
        T1.local_price,
        T1.local_currency,
        T1.base_price,
        T1.base_currency,
        T1.discount,
        T1.is_used,
        T1.inventory,
        T1.f_status,
        T1.created_time,
        T1.product_create_time,
        T1.product_update_time,
        T2.embedding
    FROM source_data T1
    INNER JOIN emb_images T2 ON T1.f_sku_id = T2.f_sku_id AND T1.emb_image.image_url = T2.f_url
```

---

**文档生成**: 2026-01-30 13:41:23
**扫描工具**: scan_functions.py
