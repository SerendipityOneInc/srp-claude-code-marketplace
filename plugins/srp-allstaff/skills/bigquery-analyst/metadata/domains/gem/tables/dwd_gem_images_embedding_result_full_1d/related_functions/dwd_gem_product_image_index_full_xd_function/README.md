# dwd_gem_product_image_index_full_xd_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_full_xd_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2026-01-19
**最后更新**: 2026-01-19

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| emb_model_version | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dim_site_mut` (dim_site_mut)
- `srpproduct-dc37e.favie_algo.dwd_gem_images_embedding_result_full_1d` (dwd_gem_images_embedding_result_full_1d)
- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d` (dwd_favie_product_detail_full_1d)
- `srpproduct-dc37e.favie_algo.dwd_gem_product_display_score_full_1d` (dwd_gem_product_display_score_full_1d)

---

## 💻 函数定义

```sql
with source_data as (
        SELECT 
            f_sku_id,
            f_spu_id,
            site,
            SAFE.PARSE_JSON(price) as price,
            SAFE.PARSE_JSON(rrp) as rrp,
            f_updates_at,
            f_creates_at,
            f_image_list,
            SAFE.PARSE_JSON(extended_info) as extended_info,
            SAFE.PARSE_JSON(f_brand) as f_brand_json,
            inventory,
            f_status
        FROM srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d
        WHERE date(dt) = dt_param
            AND (
                inventory is null 
                or lower(JSON_EXTRACT_SCALAR(inventory, '$.status')) != 'out_of_stock'
            )
            AND f_status = '0'
            AND EXISTS (
                SELECT 1
                FROM UNNEST(JSON_EXTRACT_ARRAY(f_image_list)) AS image_element
                WHERE
                JSON_EXTRACT_SCALAR(image_element, '$.category') = 'main'
                AND JSON_EXTRACT_SCALAR(image_element, '$.f_link') IS NOT NULL
            )
    ),

    dim_site_data as (
        select 
            site,
            site_rank
        from (
            SELECT 
                site_domain_without_www as site,
                site_rank,
                row_number() over(partition by site_domain_without_www) as rn
            FROM `srpproduct-dc37e.favie_dw.dim_site_mut`,
            UNNEST(split(index_config, ',')) AS index_type
            where trim(index_type) = 'image'
         ) where rn = 1
    ),

    emb_images as (
        SELECT
            DISTINCT
            f_sku_id,
            f_url
        FROM `srpproduct-dc37e.favie_algo.dwd_gem_images_embedding_result_full_1d`
        WHERE date(dt) = dt_param AND model_version = emb_model_version
    ),
    flat_images as (
        SELECT
            f_sku_id,
            display_image AS f_url
        FROM `srpproduct-dc37e.favie_algo.dwd_gem_product_display_score_full_1d`
        WHERE date(dt) = dt_param 
    ),

    final_images as (
        SELECT
            T1.f_sku_id,
            T1.f_url
        FROM emb_images T1
        INNER JOIN flat_images T2 ON T1.f_sku_id = T2.f_sku_id AND T1.f_url = T2.f_url
    ),

    product_with_image as (
        SELECT
            T1.f_sku_id,
            T1.f_spu_id,
            T1.site,

            CAST(JSON_VALUE(T1.price,"$.value") AS INT64) AS local_price, 
            CASE 
                WHEN JSON_VALUE(T1.price,"$.currency") = 'USD' THEN 0 
                ELSE -1 
            END AS local_currency,  

            CAST(JSON_VALUE(T1.rrp,"$.value") AS INT64) AS base_price, 
            CASE 
                WHEN JSON_VALUE(T1.rrp,"$.currency") = 'USD' THEN 0 
                ELSE -1 
            END AS base_currency,

            CASE 
                WHEN CAST(json_value(T1.rrp,"$.value") AS FLOAT64) > 0 
                THEN CAST(json_value(T1.price,"$.value") AS FLOAT64) / CAST(json_value(T1.rrp,"$.value") AS FLOAT64) 
                ELSE 1 
            END AS discount,

            lower(COALESCE(json_value(T1.f_brand_json,"$.parent_name"), json_value(T1.f_brand_json,"$.name"))) AS norm_brand, -- 从f_brand中获取归一化后的品牌

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_used")) = 'true' THEN 1 
                ELSE 0 
            END AS is_used, -- 从 `extended_info` 直接解析

            T1.inventory,
            T1.f_status,
            T3.f_url AS image_url,

            T1.f_creates_at as created_time,
            timestamp_seconds(safe_cast(T1.f_creates_at as int64)) AS product_create_time,
            timestamp_seconds(safe_cast(T1.f_updates_at as int64)) AS product_update_time            
          
        from source_data T1
        INNER JOIN dim_site_data T2 ON T1.site = T2.site
        INNER JOIN final_images T3 ON T1.f_sku_id = T3.f_sku_id
    ),

    final_data as (
        SELECT
            'add' AS CMD,
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
            array_agg(
                STRUCT<
                    CMD STRING,
                    image_url STRING,
                    update_time TIMESTAMP
                >(
                    'add',
                    image_url,
                    CURRENT_TIMESTAMP()
                )
            ) AS emb_images,
            product_create_time,
            product_update_time,
            CURRENT_TIMESTAMP() AS record_update_time,
            CURRENT_TIMESTAMP() AS record_create_time,
        FROM product_with_image
        GROUP BY 
            f_sku_id, 
            f_spu_id,
            site,
            local_price,
            local_currency,
            base_price,
            base_currency,
            discount,
            is_used,
            inventory,
            norm_brand,
            f_status,
            created_time,
            product_create_time,
            product_update_time
    )
    select 
        dt_param as dt,
        CMD,
        record_update_time,
        record_create_time,

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
    from final_data
```

---

**文档生成**: 2026-01-30 13:41:27
**扫描工具**: scan_functions.py
