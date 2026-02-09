# rpt_product_dw_search_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_product_dw_search_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-08
**最后更新**: 2025-10-08

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| dt_param_7 | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| dt_param_28 | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with product_metric as (
    SELECT 
      product_site,
      product_shop_site,
      site_domain,
      site_top_domain,
      site_tier,
      site_type,
      site_categories,
      site_parser_type,
      site_country_region,
      SUM(IF(dt = dt_param, valid_sku_uniq_cnt, 0)) AS valid_sku_uniq_cnt,
      SUM(IF(dt = dt_param, valid_spu_uniq_cnt, 0)) AS valid_spu_uniq_cnt,
      SUM(IF(dt = dt_param, inc_sku_uniq_cnt, 0)) AS inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param, inc_spu_uniq_cnt, 0)) AS inc_spu_uniq_cnt,
      SUM(IF(dt = dt_param, update_sku_uniq_cnt, 0)) AS update_sku_uniq_cnt,
      SUM(IF(dt = dt_param, update_spu_uniq_cnt, 0)) AS update_spu_uniq_cnt,
      SUM(IF(dt >= dt_param_7, inc_sku_uniq_cnt, 0)) AS d7_inc_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_7, inc_spu_uniq_cnt, 0)) AS d7_inc_spu_uniq_cnt,
      SUM(IF(dt >= dt_param_7, update_sku_uniq_cnt, 0)) AS d7_update_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_7, update_spu_uniq_cnt, 0)) AS d7_update_spu_uniq_cnt,
      SUM(IF(dt >= dt_param_28, inc_sku_uniq_cnt, 0)) AS d28_inc_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_28, inc_spu_uniq_cnt, 0)) AS d28_inc_spu_uniq_cnt,
      SUM(IF(dt >= dt_param_28, update_sku_uniq_cnt, 0)) AS d28_update_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_28, update_spu_uniq_cnt, 0)) AS d28_update_spu_uniq_cnt,
      SUM(IF(dt = dt_param,d7_update_and_inc_sku_uniq_cnt,0)) as d7_update_and_inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param,d7_update_and_inc_spu_uniq_cnt,0)) as d7_update_and_inc_spu_uniq_cnt,
      SUM(IF(dt = dt_param,d28_update_and_inc_sku_uniq_cnt,0)) as d28_update_and_inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param,d28_update_and_inc_spu_uniq_cnt,0)) as d28_update_and_inc_spu_uniq_cnt,
      DATE(dt_param) AS dt
    FROM favie_dw.dws_favie_product_data_cube_inc_1d
    WHERE dt >= dt_param_28 and dt <= dt_param
    GROUP BY product_site,product_shop_site, site_domain, site_top_domain, site_tier, site_type, site_categories, site_parser_type, site_country_region
  ),

  search_metric as (
    select 
      product_site,
      product_shop_site, 
      site_domain, 
      site_top_domain, 
      site_tier, 
      site_type, 
      site_categories, 
      site_parser_type, 
      site_country_region,
      -- SUM(gem_ha3_recall_sku_cnt) AS gem_ha3_recall_sku_cnt,
      -- SUM(gem_ha3_recall_sku_uniq_cnt) AS gem_ha3_recall_sku_uniq_cnt,
      -- SUM(gem_ha3_recall_1d_update_sku_cnt) AS gem_ha3_recall_1d_update_sku_cnt,
      -- SUM(gem_ha3_recall_1d_update_sku_uniq_cnt) AS gem_ha3_recall_1d_update_sku_uniq_cnt,
      -- SUM(gem_ha3_recall_7d_update_sku_cnt) AS gem_ha3_recall_7d_update_sku_cnt,
      -- SUM(gem_ha3_recall_7d_update_sku_uniq_cnt) AS gem_ha3_recall_7d_update_sku_uniq_cnt,
      -- SUM(gem_ha3_recall_28d_update_sku_cnt) AS gem_ha3_recall_28d_update_sku_cnt,
      -- SUM(gem_ha3_recall_28d_update_sku_uniq_cnt) AS gem_ha3_recall_28d_update_sku_uniq_cnt,
      -- SUM(gem_ha3_recall_archive_sku_cnt) AS gem_ha3_recall_archive_sku_cnt,
      -- SUM(gem_ha3_recall_archive_sku_uniq_cnt) AS gem_ha3_recall_archive_sku_uniq_cnt,

      -- SUM(valid_gem_ha3_recall_sku_cnt) AS valid_gem_ha3_recall_sku_cnt,
      -- SUM(valid_gem_ha3_recall_sku_uniq_cnt) AS valid_gem_ha3_recall_sku_uniq_cnt,
      -- SUM(valid_gem_ha3_recall_1d_update_sku_cnt) AS valid_gem_ha3_recall_1d_update_sku_cnt,
      -- SUM(valid_gem_ha3_recall_1d_update_sku_uniq_cnt) AS valid_gem_ha3_recall_1d_update_sku_uniq_cnt,
      -- SUM(valid_gem_ha3_recall_7d_update_sku_cnt) AS valid_gem_ha3_recall_7d_update_sku_cnt,
      -- SUM(valid_gem_ha3_recall_7d_update_sku_uniq_cnt) AS valid_gem_ha3_recall_7d_update_sku_uniq_cnt,
      -- SUM(valid_gem_ha3_recall_28d_update_sku_cnt) AS valid_gem_ha3_recall_28d_update_sku_cnt,
      -- SUM(valid_gem_ha3_recall_28d_update_sku_uniq_cnt) AS valid_gem_ha3_recall_28d_update_sku_uniq_cnt,
      -- SUM(valid_gem_ha3_recall_archive_sku_cnt) AS valid_gem_ha3_recall_archive_sku_cnt,
      -- SUM(valid_gem_ha3_recall_archive_sku_uniq_cnt) AS valid_gem_ha3_recall_archive_sku_uniq_cnt,

      SUM(gem_search_return_sku_cnt) AS gem_search_return_sku_cnt,
      SUM(gem_search_return_sku_uniq_cnt) AS gem_search_return_sku_uniq_cnt,
      SUM(gem_search_return_1d_update_sku_cnt) AS gem_search_return_1d_update_sku_cnt,
      SUM(gem_search_return_1d_update_sku_uniq_cnt) AS gem_search_return_1d_update_sku_uniq_cnt,
      SUM(gem_search_return_7d_update_sku_cnt) AS gem_search_return_7d_update_sku_cnt,
      SUM(gem_search_return_7d_update_sku_uniq_cnt) AS gem_search_return_7d_update_sku_uniq_cnt,
      SUM(gem_search_return_28d_update_sku_cnt) AS gem_search_return_28d_update_sku_cnt,
      SUM(gem_search_return_28d_update_sku_uniq_cnt) AS gem_search_return_28d_update_sku_uniq_cnt,

      SUM(gem_moodboard_sku_cnt) AS gem_moodboard_sku_cnt,
      SUM(gem_moodboard_sku_uniq_cnt) AS gem_moodboard_sku_uniq_cnt,
      -- SUM(first_gem_moodboard_sku_cnt) AS first_gem_moodboard_sku_cnt,
      -- SUM(first_gem_moodboard_sku_uniq_cnt) AS first_gem_moodboard_sku_uniq_cnt,
      SUM(gem_moodboard_1d_update_sku_cnt) AS gem_moodboard_1d_update_sku_cnt,
      SUM(gem_moodboard_1d_update_sku_uniq_cnt) AS gem_moodboard_1d_update_sku_uniq_cnt,
      SUM(gem_moodboard_7d_update_sku_cnt) AS gem_moodboard_7d_update_sku_cnt,
      SUM(gem_moodboard_7d_update_sku_uniq_cnt) AS gem_moodboard_7d_update_sku_uniq_cnt,
      SUM(gem_moodboard_28d_update_sku_cnt) AS gem_moodboard_28d_update_sku_cnt,
      SUM(gem_moodboard_28d_update_sku_uniq_cnt) AS gem_moodboard_28d_update_sku_uniq_cnt,

      SUM(gem_moodboard_p5_sku_seconds_amt) AS gem_moodboard_p5_sku_seconds_amt,
      SUM(gem_moodboard_p25_sku_seconds_amt) AS gem_moodboard_p25_sku_seconds_amt,
      SUM(gem_moodboard_p50_sku_seconds_amt) AS gem_moodboard_p50_sku_seconds_amt,
      SUM(gem_moodboard_p75_sku_seconds_amt) AS gem_moodboard_p75_sku_seconds_amt,
      SUM(gem_moodboard_p95_sku_seconds_amt) AS gem_moodboard_p95_sku_seconds_amt,

      dt
    from favie_dw.dws_favie_gem_search_sku_cube_inc_1d
    where dt = dt_param
    group by dt, product_site,
      product_shop_site, 
      site_domain, 
      site_top_domain, 
      site_tier, 
      site_type, 
      site_categories, 
      site_parser_type, 
      site_country_region
  )

      SELECT
          t1.product_site,
          t1.product_shop_site,
          t1.site_domain,
          t1.site_top_domain,
          t1.site_tier,
          t1.site_type,
          t1.site_categories,
          t1.site_parser_type,
          t1.site_country_region,    
          t1.valid_sku_uniq_cnt,
          t1.valid_spu_uniq_cnt,
          t1.d7_inc_sku_uniq_cnt,
          t1.d7_inc_spu_uniq_cnt,
          t1.d7_update_sku_uniq_cnt,
          t1.d7_update_spu_uniq_cnt,
          t1.d28_inc_sku_uniq_cnt,
          t1.d28_inc_spu_uniq_cnt,
          t1.d28_update_sku_uniq_cnt,
          t1.d28_update_spu_uniq_cnt,
          
          -- t2.gem_ha3_recall_sku_cnt,
          -- t2.gem_ha3_recall_sku_uniq_cnt,
          -- t2.gem_ha3_recall_1d_update_sku_cnt,
          -- t2.gem_ha3_recall_1d_update_sku_uniq_cnt,
          -- t2.gem_ha3_recall_7d_update_sku_cnt,
          -- t2.gem_ha3_recall_7d_update_sku_uniq_cnt,
          -- t2.gem_ha3_recall_28d_update_sku_cnt,
          -- t2.gem_ha3_recall_28d_update_sku_uniq_cnt,
          -- t2.gem_ha3_recall_archive_sku_cnt,
          -- t2.gem_ha3_recall_archive_sku_uniq_cnt,

          -- t2.valid_gem_ha3_recall_sku_cnt,
          -- t2.valid_gem_ha3_recall_sku_uniq_cnt,
          -- t2.valid_gem_ha3_recall_1d_update_sku_cnt,
          -- t2.valid_gem_ha3_recall_1d_update_sku_uniq_cnt,
          -- t2.valid_gem_ha3_recall_7d_update_sku_cnt,
          -- t2.valid_gem_ha3_recall_7d_update_sku_uniq_cnt,
          -- t2.valid_gem_ha3_recall_28d_update_sku_cnt,
          -- t2.valid_gem_ha3_recall_28d_update_sku_uniq_cnt,
          -- t2.valid_gem_ha3_recall_archive_sku_cnt,
          -- t2.valid_gem_ha3_recall_archive_sku_uniq_cnt,

          t2.gem_search_return_sku_cnt,
          t2.gem_search_return_sku_uniq_cnt,
          t2.gem_search_return_1d_update_sku_cnt,
          t2.gem_search_return_1d_update_sku_uniq_cnt,
          t2.gem_search_return_7d_update_sku_cnt,
          t2.gem_search_return_7d_update_sku_uniq_cnt,
          t2.gem_search_return_28d_update_sku_cnt,
          t2.gem_search_return_28d_update_sku_uniq_cnt,
          
          t2.gem_moodboard_sku_cnt,
          t2.gem_moodboard_sku_uniq_cnt,
          -- t2.first_gem_moodboard_sku_cnt,
          -- t2.first_gem_moodboard_sku_uniq_cnt,
          t2.gem_moodboard_1d_update_sku_cnt,
          t2.gem_moodboard_1d_update_sku_uniq_cnt,
          t2.gem_moodboard_7d_update_sku_cnt,
          t2.gem_moodboard_7d_update_sku_uniq_cnt,
          t2.gem_moodboard_28d_update_sku_cnt,
          t2.gem_moodboard_28d_update_sku_uniq_cnt,

          t2.gem_moodboard_p5_sku_seconds_amt,
          t2.gem_moodboard_p25_sku_seconds_amt,
          t2.gem_moodboard_p50_sku_seconds_amt,
          t2.gem_moodboard_p75_sku_seconds_amt,
          t2.gem_moodboard_p95_sku_seconds_amt,

          -- IFNULL(t2.gem_ha3_recall_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS gem_ha3_recall_utilization_rate,
          -- IFNULL(t2.gem_ha3_recall_1d_update_sku_uniq_cnt / NULLIF((t1.inc_sku_uniq_cnt + t1.update_sku_uniq_cnt), 0), 0) AS d1_gem_ha3_recall_utilization_rate,
          -- IFNULL(t2.gem_ha3_recall_7d_update_sku_uniq_cnt / NULLIF((t1.d7_update_and_inc_sku_uniq_cnt), 0), 0) AS d7_gem_ha3_recall_utilization_rate,
          -- IFNULL(t2.gem_ha3_recall_28d_update_sku_uniq_cnt / NULLIF((t1.d28_update_and_inc_sku_uniq_cnt), 0), 0) AS d28_gem_ha3_recall_utilization_rate,

          -- IFNULL(t2.valid_gem_ha3_recall_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS valid_gem_ha3_recall_utilization_rate,
          -- IFNULL(t2.valid_gem_ha3_recall_1d_update_sku_uniq_cnt / NULLIF((t1.inc_sku_uniq_cnt + t1.update_sku_uniq_cnt), 0), 0) AS d1_valid_gem_ha3_recall_utilization_rate,
          -- IFNULL(t2.valid_gem_ha3_recall_7d_update_sku_uniq_cnt / NULLIF((t1.d7_update_and_inc_sku_uniq_cnt), 0), 0) AS d7_valid_gem_ha3_recall_utilization_rate,
          -- IFNULL(t2.valid_gem_ha3_recall_28d_update_sku_uniq_cnt / NULLIF((t1.d28_update_and_inc_sku_uniq_cnt), 0), 0) AS d28_valid_gem_ha3_recall_utilization_rate,

          IFNULL(t2.gem_search_return_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS gem_search_return_utilization_rate,
          IFNULL(t2.gem_search_return_1d_update_sku_uniq_cnt / NULLIF((t1.inc_sku_uniq_cnt + t1.update_sku_uniq_cnt), 0), 0) AS d1_gem_search_return_utilization_rate,
          IFNULL(t2.gem_search_return_7d_update_sku_uniq_cnt / NULLIF((t1.d7_update_and_inc_sku_uniq_cnt), 0), 0) AS d7_gem_search_return_utilization_rate,
          IFNULL(t2.gem_search_return_28d_update_sku_uniq_cnt / NULLIF((t1.d28_update_and_inc_sku_uniq_cnt), 0), 0) AS d28_gem_search_return_utilization_rate,

          IFNULL(t2.gem_moodboard_sku_uniq_cnt / NULLIF(t1.valid_sku_uniq_cnt, 0), 0) AS gem_moodboard_utilization_rate,
          IFNULL(t2.gem_moodboard_1d_update_sku_uniq_cnt / NULLIF((t1.inc_sku_uniq_cnt + t1.update_sku_uniq_cnt), 0), 0) AS d1_gem_moodboard_utilization_rate,
          IFNULL(t2.gem_moodboard_7d_update_sku_uniq_cnt / NULLIF((t1.d7_update_and_inc_sku_uniq_cnt), 0), 0) AS d7_gem_moodboard_utilization_rate,
          IFNULL(t2.gem_moodboard_28d_update_sku_uniq_cnt / NULLIF((t1.d28_update_and_inc_sku_uniq_cnt), 0), 0) AS d28_gem_moodboard_utilization_rate,

          t1.dt AS dt
      FROM product_metric t1
      LEFT JOIN search_metric t2 
      ON t1.dt = t2.dt
        AND t1.site_domain = t2.site_domain
        AND t1.site_top_domain = t2.site_top_domain
        AND t1.product_site = t2.product_site
        and t1.product_shop_site = t2.product_shop_site
        AND t1.site_tier = t2.site_tier
        AND t1.site_type = t2.site_type
        AND t1.site_categories = t2.site_categories
        AND t1.site_parser_type = t2.site_parser_type
        AND t1.site_country_region = t2.site_country_region
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
