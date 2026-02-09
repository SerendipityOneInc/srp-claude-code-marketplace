# dws_favie_product_data_cube_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_data_cube_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-04
**最后更新**: 2026-01-04

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| dt_param_3 | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| dt_param_7 | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| dt_param_28 | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH rpt_favie_product_sku_data AS (
        SELECT 
            f_sku_id,
            f_spu_id,
            site,
            shop_site,
            price_status,
            coalesce(inventory_status,"in_stock") as inventory_status,
            favie_dw.get_spider_update_time(f_meta) AS updates_time,
            TIMESTAMP_SECONDS(creates_at) AS creates_time,
            dt
        FROM (
            SELECT 
                f_sku_id,
                f_spu_id,
                site,
                coalesce(shop_site,site) as shop_site,
                SAFE_CAST(JSON_EXTRACT_SCALAR(price, "$.value") AS INT64) AS price_value,
                f_meta,
                price_status,
                json_value(inventory,"$.status") as inventory_status,
                SAFE_CAST(f_creates_at AS INT64) AS creates_at,
                PARSE_DATE('%Y-%m-%d', dt) as dt
            FROM `favie_dw.dwd_favie_product_detail_full_1d`
            WHERE dt is not null 
                and PARSE_DATE('%Y-%m-%d', dt) = dt_param
                -- and price IS NOT NULL
        )
        --  WHERE price_value IS NOT NULL AND price_value > 0
    ),

    rpt_favie_product_sku_tmp AS (
        SELECT 
            t1.f_sku_id AS f_sku_id,
            t1.f_spu_id AS f_spu_id,
            t1.site AS product_site,
            t1.shop_site as product_shop_site,
            t1.updates_time AS updates_time,
            t1.price_status,
            t1.inventory_status,
            date(t1.updates_time)  AS updates_date,
            date(t1.creates_time) AS creates_date,
            t1.dt AS dt
        FROM rpt_favie_product_sku_data t1 
    ),

    rpt_favie_product_spu_tmp AS (
        SELECT 
            *,
            ROW_NUMBER() OVER (PARTITION BY f_spu_id ORDER BY updates_time DESC) AS row_number
        FROM rpt_favie_product_sku_tmp
    ),

    rpt_favie_product_sku_cube AS (
        SELECT 
            product_site,
            product_shop_site,
            COUNT(f_sku_id) AS sku_uniq_cnt,
            COUNT(IF(creates_date = dt_param, f_sku_id, NULL)) AS inc_sku_uniq_cnt,
            COUNT(IF(creates_date != dt_param AND updates_date = dt_param, f_sku_id, NULL)) AS update_sku_uniq_cnt,
            COUNT(IF(updates_date >= dt_param_3,f_sku_id,NULL)) as d3_update_and_inc_sku_uniq_cnt,
            COUNT(IF(updates_date >= dt_param_7,f_sku_id,NULL)) as d7_update_and_inc_sku_uniq_cnt,
            COUNT(IF(updates_date >= dt_param_28,f_sku_id,NULL)) as d28_update_and_inc_sku_uniq_cnt,
            COUNT(IF(price_status = 1,f_sku_id,null)) as invalid_price_sku_uniq_cnt,
            COUNT(IF(price_status = 2,f_sku_id,null)) as unexpected_price_sku_uniq_cnt,
            COUNT(IF(inventory_status = "out_of_stock",f_sku_id,null)) as out_of_stock_sku_uniq_cnt,
            dt
        FROM rpt_favie_product_sku_tmp
        GROUP BY dt, product_site,product_shop_site
    ),

    rpt_favie_product_spu_cube_tmp AS (
        SELECT 
            product_site,
            product_shop_site,
            approx_count_distinct(f_spu_id) AS spu_uniq_cnt,
            approx_count_distinct(IF(creates_date = dt, f_spu_id, NULL)) AS inc_spu_uniq_cnt,
            approx_count_distinct(IF(creates_date != dt AND updates_date = dt, f_spu_id, NULL)) AS update_spu_uniq_cnt,
            approx_count_distinct(IF(updates_date >= dt_param_3, f_spu_id, NULL)) AS d3_update_and_inc_spu_uniq_cnt,
            approx_count_distinct(IF(updates_date >= dt_param_7, f_spu_id, NULL)) AS d7_update_and_inc_spu_uniq_cnt,
            approx_count_distinct(IF(updates_date >= dt_param_28, f_spu_id, NULL)) AS d28_update_and_inc_spu_uniq_cnt,
            dt
        FROM rpt_favie_product_spu_tmp
        where row_number = 1
        GROUP BY dt, product_site,product_shop_site
    ),

    rpt_favie_product_spu_cube_result as (
        SELECT 
            t1.product_site AS product_site,
            t1.product_shop_site as product_shop_site,
            t2.sku_uniq_cnt AS sku_uniq_cnt,
            t1.spu_uniq_cnt AS spu_uniq_cnt,
            t2.inc_sku_uniq_cnt AS inc_sku_uniq_cnt,
            t1.inc_spu_uniq_cnt AS inc_spu_uniq_cnt,
            t2.update_sku_uniq_cnt AS update_sku_uniq_cnt,
            t1.update_spu_uniq_cnt AS update_spu_uniq_cnt,
            t2.d3_update_and_inc_sku_uniq_cnt as d3_update_and_inc_sku_uniq_cnt,
            t1.d3_update_and_inc_spu_uniq_cnt as d3_update_and_inc_spu_uniq_cnt,
            t2.d7_update_and_inc_sku_uniq_cnt as d7_update_and_inc_sku_uniq_cnt,
            t1.d7_update_and_inc_spu_uniq_cnt as d7_update_and_inc_spu_uniq_cnt,
            t2.d28_update_and_inc_sku_uniq_cnt as d28_update_and_inc_sku_uniq_cnt,
            t1.d28_update_and_inc_spu_uniq_cnt as d28_update_and_inc_spu_uniq_cnt,
            t2.invalid_price_sku_uniq_cnt,
            t2.unexpected_price_sku_uniq_cnt,
            t2.out_of_stock_sku_uniq_cnt,
            t1.dt AS dt
        FROM rpt_favie_product_spu_cube_tmp t1 
        LEFT OUTER JOIN rpt_favie_product_sku_cube t2
        ON t1.dt = t2.dt
            AND t1.product_site = t2.product_site 
            and t1.product_shop_site = t2.product_shop_site
    )

    select 
        t1.product_site AS product_site,
        t1.product_shop_site as product_shop_site,
        IF(t2.site_domain IS NULL,t1.product_site,t2.site_domain) as site_domain,
        IF(t2.site_top_domain IS NULL, REGEXP_EXTRACT(t1.product_site, r'([^.]+\.[^.]+)$'), t2.site_top_domain) AS site_top_domain,
        IF(t2.site_tier IS NULL, "Other", t2.site_tier) AS site_tier,
        IF(t2.site_type IS NULL, "Other", t2.site_type) AS site_type,
        IF(t2.site_rank IS NULL, "Other", t2.site_rank) AS site_rank,
        IF(t2.site_categories IS NULL, "Other", t2.site_categories) AS site_categories,
        IF(t2.site_parser_type IS NULL, "Other", t2.site_parser_type) AS site_parser_type,
        IF(t2.site_country_region IS NULL, "Other", t2.site_country_region) AS site_country_region,
        t1.sku_uniq_cnt AS sku_uniq_cnt,
        t1.spu_uniq_cnt AS spu_uniq_cnt,
        t1.inc_sku_uniq_cnt AS inc_sku_uniq_cnt,
        t1.inc_spu_uniq_cnt AS inc_spu_uniq_cnt,
        t1.update_sku_uniq_cnt AS update_sku_uniq_cnt,
        t1.update_spu_uniq_cnt AS update_spu_uniq_cnt,
        t1.d3_update_and_inc_sku_uniq_cnt as d3_update_and_inc_sku_uniq_cnt,
        t1.d3_update_and_inc_spu_uniq_cnt as d3_update_and_inc_spu_uniq_cnt,
        t1.d7_update_and_inc_sku_uniq_cnt as d7_update_and_inc_sku_uniq_cnt,
        t1.d7_update_and_inc_spu_uniq_cnt as d7_update_and_inc_spu_uniq_cnt,
        t1.d28_update_and_inc_sku_uniq_cnt as d28_update_and_inc_sku_uniq_cnt,
        t1.d28_update_and_inc_spu_uniq_cnt as d28_update_and_inc_spu_uniq_cnt,
        t1.invalid_price_sku_uniq_cnt,
        t1.unexpected_price_sku_uniq_cnt,
        t1.out_of_stock_sku_uniq_cnt,
        t1.dt AS dt
        from rpt_favie_product_spu_cube_result t1
    LEFT OUTER JOIN `favie_dw.dim_site_mut_view` t2
    ON t1.product_site = t2.site_domain_without_www
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
