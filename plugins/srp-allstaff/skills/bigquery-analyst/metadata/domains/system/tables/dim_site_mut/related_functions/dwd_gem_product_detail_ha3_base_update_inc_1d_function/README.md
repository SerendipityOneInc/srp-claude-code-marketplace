# dwd_gem_product_detail_ha3_base_update_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_base_update_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2026-01-07
**最后更新**: 2026-01-07

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dim_site_mut` (dim_site_mut)
- `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_inc_1d` (dwd_favie_product_detail_inc_1d)
- `srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d` (dwd_favie_product_review_combined_full_1d)

---

## 💻 函数定义

```sql
with source_data as (
        SELECT 
            f_sku_id,
            f_spu_id,
            site,
            sku_id,
            spu_id,
            request_sku_id,
            title,
            link,
            sub_title,
            sub_title_link,
            shop_id,
            shop_name,
            shop_site,
            link_in_shop,
            description,
            description_external_link,
            rich_product_description,
            SAFE.PARSE_JSON(price) as price,
            SAFE.PARSE_JSON(rrp) as rrp,
            images,
            json_query_array(categories) as categories,
            json_query_array(f_categories) as f_categories,
            videos,
            f_videos,
            SAFE.PARSE_JSON(f_brand) as f_brand_json,
            keywords,
            feature_bullets,
            attributes,
            JSON_QUERY_ARRAY(specifications) as specifications,
            SAFE.PARSE_JSON(extended_info) as extended_info,
            best_seller_rank,
            seller,
            inventory,
            SAFE.PARSE_JSON(deal) as deal,
            returns_policy,
            SAFE.PARSE_JSON(review_summary) as review_summary,
            promotion,
            variants,
            f_meta,
            f_updates_at,
            f_creates_at,
            f_tags,
            first_parser_name,
            last_parser_name,
            f_system_tags,
            json_query_array(f_image_list) as f_image_list,
            f_status,
            sku_link,
            f_cate_tags,
            SAFE.PARSE_JSON(brand) as brand_json
        FROM srpproduct-dc37e.favie_dw.dwd_favie_product_detail_inc_1d
        WHERE date(dt) = dt_param
        -- todo ： 过滤掉库存状态为缺货的商品
            AND (
                inventory is null 
                or lower(JSON_EXTRACT_SCALAR(inventory, '$.status')) != 'out_of_stock'
            )
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

    product_view_data as (
        SELECT 
            f_spu_id,
            combined_title_body
        FROM 
            srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d
            WHERE dt is not null and dt = (select max(dt) from srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d where dt is not null)
    ),

    today_hour_increment as (
        select 
            *
        from(
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
                row_number() over(partition by f_sku_id order by product_updated_at desc) as rn
            from favie_dw.dwd_gem_product_detail_ha3_inc_1h
            where dt = date_add(dt_param, interval 1 day)
                and CMD = 'update_field'
        ) where rn = 1
    ),


    final_data as (

        SELECT
            'add' AS CMD,
            T1.f_sku_id,
            T1.f_spu_id,
            T1.site,
            T1.site as site_info,
            T1.sku_id,
            T1.spu_id,
            T1.title,
            T1.link,
            COALESCE(T1.keywords, '') AS keywords,
            json_value(T1.brand_json,"$.name") AS brand, -- 从原始字段 `brand` 解析
            lower(COALESCE(json_value(T1.f_brand_json,"$.name"),json_value(T1.brand_json,"$.name"))) AS f_brand,
            CASE
                WHEN STRPOS(json_value(T1.f_brand_json,"$.link"), T1.site) > 0 THEN '1'
                ELSE '0'
            END AS is_brand_site,
            lower(COALESCE(json_value(T1.f_brand_json,"$.parent_name"), json_value(T1.f_brand_json,"$.name"))) AS norm_brand, -- 从f_brand中获取归一化后的品牌
            ARRAY_TO_STRING(ARRAY(SELECT json_value(cat,"$.id") 
                                FROM UNNEST(T1.categories) AS cat), '\x1D') AS category_id, -- 从 `categories` 直接解析
            ARRAY_TO_STRING(ARRAY(SELECT json_value(cat,"$.name") 
                                FROM UNNEST(T1.categories) AS cat), '\x1D') AS category_names, -- 从 `categories` 直接解析
            ARRAY_TO_STRING(ARRAY(SELECT json_value(cat,"$.id") 
                                FROM UNNEST(T1.f_categories) AS cat), '\x1D') AS f_category_id, -- 从 `f_categories` 直接解析,
            ARRAY_TO_STRING(ARRAY(SELECT json_value(cat,"$.name") 
                                FROM UNNEST(T1.f_categories) AS cat), '\x1D') AS f_category_names, -- 从 `f_categories` 直接解析
            CASE 
                WHEN T1.site = 'shop.app' THEN COALESCE(T1.description, '') 
                ELSE '' 
            END AS description,
            T3.combined_title_body as user_reviews_infos,
            '' AS extend_text,
            REGEXP_REPLACE(ARRAY_TO_STRING(ARRAY(SELECT json_value(spec,"$.value") 
                                                FROM UNNEST(T1.specifications) AS spec), ','), 
                        r'\x{200E}', '') AS specifications, -- 从 `specifications` 直接解析
            '' AS item_emb,
            '' AS pidvid,
            '' AS auction_tag,
            json_value(T1.f_categories[SAFE_OFFSET(0)],"$.id") AS f_level_one_category, -- 一级分类直接从 `f_categories` 的第一个对象中提取
            json_value(T1.f_categories[SAFE_OFFSET(ARRAY_LENGTH(T1.f_categories) - 1)],"$.id") AS f_level_leaf_category, -- 叶子分类直接从 `f_categories` 的最后一个对象中提取
            '' AS attr_name,
            CASE 
                WHEN lower(T2.site_rank) = 'high' THEN 1 
                ELSE 0
            END AS is_excellent, -- 通过站点过滤判断是否为精品库商品
            CAST(CAST(JSON_VALUE(T1.review_summary,"$.rating") AS FLOAT64) * 100 AS INT64) AS rating, -- 从 `review_summary` 直接解析
            CAST(CAST(JSON_VALUE(T1.review_summary,"$.ratings_total")AS int64) AS INT64) AS ratings_total, -- 从 `review_summary` 直接解析
            COALESCE(T4.local_price, CAST(JSON_VALUE(T1.price,"$.value") AS INT64)) AS local_price, -- 从 `price` 直接解析
            COALESCE(T4.base_price, CAST(JSON_VALUE(T1.rrp,"$.value") AS INT64)) AS base_price, -- 从 `rrp` 直接解析
            0 AS uv_sum,
            0 AS seller_score,
            0 AS price_power_score,
            1 AS status,
            COALESCE(T4.base_currency, 
                CASE 
                    WHEN JSON_VALUE(T1.rrp,"$.currency") = 'USD' THEN 0 
                    ELSE -1 
                END
            ) AS base_currency,
            COALESCE(T4.local_currency, 
                CASE 
                    WHEN JSON_VALUE(T1.price,"$.currency") = 'USD' THEN 0 
                    ELSE -1 
                END
            ) AS local_currency,
            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_used")) = 'true' THEN 1 
                ELSE 0 
            END AS is_used, -- 从 `extended_info` 直接解析

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_bundle")) = 'true' THEN 1 
                ELSE 0 
            END AS is_bundle, -- 从 `extended_info` 直接解析

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_preorder")) = 'true' THEN 1 
                ELSE 0 
            END AS is_preorder, -- 从 `extended_info` 直接解析

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_best_offer")) = 'true' THEN 1 
                ELSE 0 
            END AS is_best_offer, -- 从 `extended_info` 直接解析

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_marketplace_item")) = 'true' THEN 1 
                ELSE 0 
            END AS is_marketplace_item, -- 从 `extended_info` 直接解析

            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_private_brand")) = 'true' THEN 1 
                ELSE 0 
            END AS is_private_brand, -- 从 `extended_info` 直接解析

            IFNULL(CAST(JSON_VALUE(T1.extended_info,"$.recent_sales") AS INT64), 0) AS recent_sales, -- 从 `extended_info` 直接解析
            CASE 
                WHEN LOWER(JSON_VALUE(T1.extended_info,"$.is_best_seller")) = 'true' THEN 1
                ELSE 0 
            END AS is_best_seller, -- 从 `extended_info` 提取布尔值

            COALESCE(T4.inventory, T1.inventory) AS inventory, -- 库存字段，未改动

            CASE 
                WHEN T1.deal IS NOT NULL THEN 1 
                ELSE 0 
            END AS is_deal,

            CASE 
                WHEN LOWER(json_value(T1.deal,"$.is_lightning_deal")) = 'true' THEN 1
                ELSE 0 
            END AS is_lightning_deal, -- 从 `deal` 直接解析

            CASE 
                WHEN LOWER(json_value(T1.deal,"$.is_member_exclusive")) = 'true' THEN 1
                ELSE 0 
            END AS is_member_exclusive, -- 从 `deal` 直接解析

            COALESCE(T4.discount,
                CASE 
                    WHEN CAST(json_value(T1.rrp,"$.value") AS FLOAT64) > 0 
                    THEN CAST(json_value(T1.price,"$.value") AS FLOAT64) / CAST(json_value(T1.rrp,"$.value") AS FLOAT64) 
                    ELSE 1 
                END 
            ) AS discount,
            CAST(json_value(T1.extended_info,"$.last_month_sell_amount") AS INT64) AS sell_amount_last_month, -- 从 `extended_info` 直接解析
            0 AS brand_score,
            0 AS saving_score,
            ARRAY_TO_STRING(ARRAY(SELECT CONCAT(json_value(kv,"$.name"), ":", json_value(kv,"$.value")) 
                                FROM UNNEST(T1.specifications) AS kv), '\x01') AS specifications_kv, -- 从 `specifications` 直接解析
            T1.title AS text_info,
            ARRAY_TO_STRING(
                (
                    select 
                        ARRAY_AGG(distinct json_value(f_image,"$.f_link"))
                    from unnest(T1.f_image_list) as f_image
                    where json_value(f_image,"$.f_link") IS NOT NULL
                ), '\x1D') AS f_images, -- 提取 `f_images` 内的 `images`
            (
                select 
                    json_value(f_image,"$.f_link")
                from unnest(T1.f_image_list) as f_image
                where json_value(f_image,"$.category") = 'main'
                limit 1
            ) AS f_main_image_url,
            ARRAY_TO_STRING(JSON_EXTRACT_STRING_ARRAY(T1.feature_bullets, '$'), ',') AS feature_bullets, -- 从 `feature_bullets` 中解析数组
            T1.f_creates_at as created_time,
            timestamp_seconds(safe_cast(T1.f_creates_at as int64)) AS product_created_at,
            timestamp_seconds(safe_cast(T1.f_updates_at as int64)) AS product_updated_at
        FROM source_data T1
        LEFT OUTER JOIN dim_site_data T2 ON T1.site = T2.site
        LEFT OUTER JOIN product_view_data T3 ON T1.f_spu_id = T3.f_spu_id
        LEFT OUTER JOIN today_hour_increment T4 ON T1.f_sku_id = T4.f_sku_id
        where t2.site IS NOT NULL
            and CAST(json_value(T1.price,"$.value") AS INT64) > 0
            and exists (
                select 
                    1
                from unnest(T1.f_image_list) as f_image
                where json_value(f_image,"$.category") = 'main'
                and least(cast(json_value(f_image,"$.width") as int64), cast(json_value(f_image,"$.height") as int64)) >= 400
                limit 1
            )
    )

    select
        CMD,
        f_sku_id,
        f_spu_id,
        site,
        site_info,
        sku_id,
        spu_id,
        title,
        link,
        keywords,
        brand,
        f_brand,
        is_brand_site,
        norm_brand,
        category_id,
        category_names,
        f_category_id,
        f_category_names,
        description,
        user_reviews_infos,
        extend_text,
        specifications,
        item_emb,
        pidvid,
        auction_tag,
        f_level_one_category,
        f_level_leaf_category,
        attr_name,
        is_excellent,
        rating,
        ratings_total,
        local_price,
        base_price,
        uv_sum,
        seller_score,
        price_power_score,
        status,
        base_currency,
        local_currency,
        is_used,
        is_bundle,
        is_preorder,
        is_best_offer,
        is_marketplace_item,
        is_private_brand,
        recent_sales,
        is_best_seller,
        inventory,
        is_deal,
        is_lightning_deal,
        is_member_exclusive,
        discount,
        sell_amount_last_month,
        brand_score,
        saving_score,
        specifications_kv,
        text_info,
        f_images,
        f_main_image_url,
        feature_bullets,
        created_time,
        product_created_at,
        product_updated_at
    from final_data
```

---

**文档生成**: 2026-01-30 13:41:14
**扫描工具**: scan_functions.py
