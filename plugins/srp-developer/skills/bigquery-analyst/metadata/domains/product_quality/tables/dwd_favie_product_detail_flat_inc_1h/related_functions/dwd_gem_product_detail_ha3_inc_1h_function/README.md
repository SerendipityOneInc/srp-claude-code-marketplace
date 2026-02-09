# dwd_gem_product_detail_ha3_inc_1h_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_inc_1h_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2026-01-13
**最后更新**: 2026-01-13

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| hour_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_flat_inc_1h` (dwd_favie_product_detail_flat_inc_1h)
- `srpproduct-dc37e.favie_dw.dim_site_mut` (dim_site_mut)

---

## 💻 函数定义

```sql
with source_data as (
        SELECT 
            f_sku_id,
            f_spu_id,
            sku_id,
            spu_id,
            site,
            SAFE.PARSE_JSON(price) as price,
            SAFE.PARSE_JSON(rrp) as rrp,
            SAFE.PARSE_JSON(inventory) as inventory_json,
            inventory,
            f_status,
            f_meta,
            (select 
                f_image
             from unnest(json_query_array(f_image_list)) as f_image
             where json_value(f_image,"$.f_link") is not null and json_value(f_image, '$.category') = 'main'
             limit 1
            ) as f_main_image,
            timestamp_seconds(safe_cast(f_creates_at as int64)) AS product_created_at,
            timestamp_seconds(safe_cast(f_updates_at as int64)) AS product_updated_at,            
            ROW_NUMBER() OVER (PARTITION BY f_sku_id ORDER BY f_updates_at DESC) AS rn
        FROM srpproduct-dc37e.favie_dw.dwd_favie_product_detail_flat_inc_1h
        WHERE date(dt) = dt_param
            AND hour = hour_param
            AND f_status = '0'
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
            where trim(index_type) = 'text'
         ) where rn = 1
    ),


    deduplicated_data AS (
        select 
            T1.f_sku_id,
            T1.f_spu_id,
            T1.sku_id,
            T1.spu_id,
            T1.site,
            T1.inventory,
            CAST(JSON_VALUE(T1.price,"$.value") AS INT64) AS local_price, 
            CAST(JSON_VALUE(T1.rrp,"$.value") AS INT64) AS base_price,
            CASE 
                WHEN JSON_VALUE(T1.rrp,"$.currency") = 'USD' THEN 0 
                ELSE -1 
            END AS local_currency,
            CASE 
                WHEN JSON_VALUE(T1.rrp,"$.currency") = 'USD' THEN 0 
                ELSE -1 
            END AS base_currency,
            if(
                T1.inventory_json is not null
                and json_value(T1.inventory_json, '$.status') is not null
                and lower(json_value(T1.inventory_json, '$.status')) = 'out_of_stock', true,false) as out_of_stock,
            T1.f_status,
            T1.f_meta,
            if (
                T1.f_main_image is not null
                and least(cast(json_value(T1.f_main_image,"$.width") as int64), cast(json_value(T1.f_main_image,"$.height") as int64)) >= 400
                ,true,false
            ) AS has_invalid_main_image,
            T1.product_created_at,
            T1.product_updated_at
        from source_data T1 
        left outer join dim_site_data T2 
        ON  T1.rn = 1 and T1.site = T2.site
        where T2.site IS NOT NULL
    ),

    final_data AS (
        select 
            CASE 
                WHEN 
                    -- 下线的三种情况
                    out_of_stock = true
                    OR f_status != '0'
                    OR has_invalid_main_image = false
                    OR local_price <= 0
                    OR base_price <= 0
                THEN 'delete' 
                ELSE 'update_field'
            END AS CMD,            
            f_sku_id,
            f_spu_id,
            sku_id,
            spu_id,
            site,
            local_price,
            local_currency,
            base_price,
            base_currency,
            CASE 
                WHEN base_price > 0 
                THEN local_price / base_price 
                ELSE 1 
            END AS discount,
            inventory,
            product_created_at,
            product_updated_at,
            CURRENT_TIMESTAMP() AS record_time
        from deduplicated_data
    )

    select 
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
        hour_param as record_hour,
        dt_param as dt
    from final_data
```

---

**文档生成**: 2026-01-30 13:41:18
**扫描工具**: scan_functions.py
