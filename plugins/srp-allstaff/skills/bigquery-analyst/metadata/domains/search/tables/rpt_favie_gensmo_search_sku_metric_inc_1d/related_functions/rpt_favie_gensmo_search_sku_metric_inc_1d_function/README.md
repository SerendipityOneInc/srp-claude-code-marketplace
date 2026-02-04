# rpt_favie_gensmo_search_sku_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.rpt_favie_gensmo_search_sku_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-16
**最后更新**: 2025-12-16

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
WITH 
  base_data AS (
      SELECT
          dt_param AS dt,
          product_site,          
          --aditional info
          raw_query,
          qp_query,
          product_id,
          time_gap
      FROM `favie_dw.dwd_favie_gensmo_moodboard_product_inc_1d`
      WHERE
          dt IS NOT NULL AND dt = dt_param
          AND raw_query IS NOT NULL
          AND raw_query != '' 
          AND qp_query IS NOT NULL
          AND qp_query != ''
          AND product_created_time IS NOT NULL
  ),
  data_agg AS (
      SELECT
          -- basic info
          dt,
          product_site,

          -- raw query
          COUNT(DISTINCT raw_query) AS gem_sku_raw_query_uniq_cnt,

          --qp query
          COUNT(DISTINCT qp_query) AS gem_sku_qp_query_uniq_cnt,

          -- sku
          COUNT(1) AS gem_moodboard_sku_cnt,
          COUNT(DISTINCT product_id) AS gem_moodboard_sku_uniq_cnt,

          -- sku update 1d
          COUNTIF(time_gap <= 86400) AS gem_moodboard_1d_update_sku_cnt,
          COUNT(DISTINCT IF(time_gap <= 86400, product_id, NULL)) AS gem_moodboard_1d_update_sku_uniq_cnt,

          -- sku update 3d
          COUNTIF(time_gap <= 259200) AS gem_moodboard_3d_update_sku_cnt,
          COUNT(DISTINCT IF(time_gap <= 259200, product_id, NULL)) AS gem_moodboard_3d_update_sku_uniq_cnt,

          -- sku update 7d
          COUNTIF(time_gap <= 604800) AS gem_moodboard_7d_update_sku_cnt,
          COUNT(DISTINCT IF(time_gap <= 604800, product_id, NULL)) AS gem_moodboard_7d_update_sku_uniq_cnt,

          -- sku update 28d
          COUNTIF(time_gap <= 2419200) AS gem_moodboard_28d_update_sku_cnt,
          COUNT(DISTINCT IF(time_gap <= 2419200, product_id, NULL)) AS gem_moodboard_28d_update_sku_uniq_cnt,

          -- sku p5/25/50/75/95
          APPROX_QUANTILES(time_gap, 100)[OFFSET(5)] AS gem_moodboard_p5_sku_seconds_amt,
          APPROX_QUANTILES(time_gap, 100)[OFFSET(25)] AS gem_moodboard_p25_sku_seconds_amt,
          APPROX_QUANTILES(time_gap, 100)[OFFSET(50)] AS gem_moodboard_p50_sku_seconds_amt,
          APPROX_QUANTILES(time_gap, 100)[OFFSET(75)] AS gem_moodboard_p75_sku_seconds_amt,
          APPROX_QUANTILES(time_gap, 100)[OFFSET(95)] AS gem_moodboard_p95_sku_seconds_amt
      FROM base_data 
      GROUP BY
          dt,
          product_site  
  ),
  product_cube AS (
    SELECT
      product_site,
      product_shop_site,

      SUM(IF(dt = dt_param, sku_uniq_cnt, 0)) AS sku_uniq_cnt,
      SUM(IF(dt = dt_param, inc_sku_uniq_cnt, 0)) AS inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param, update_sku_uniq_cnt, 0)) AS update_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_3, inc_sku_uniq_cnt, 0)) AS d3_inc_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_7, inc_sku_uniq_cnt, 0)) AS d7_inc_sku_uniq_cnt,
      SUM(IF(dt >= dt_param_28, inc_sku_uniq_cnt, 0)) AS d28_inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param,d7_update_and_inc_sku_uniq_cnt,0)) as d7_update_and_inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param,d28_update_and_inc_sku_uniq_cnt,0)) as d28_update_and_inc_sku_uniq_cnt,
      SUM(IF(dt = dt_param,d3_update_and_inc_sku_uniq_cnt,0)) as d3_update_and_inc_sku_uniq_cnt
    FROM `srpproduct-dc37e.favie_dw.dws_favie_product_data_cube_inc_1d`
    WHERE dt >= dt_param_28 AND dt <= dt_param
      AND product_site IS NOT NULL AND product_site != ''
    GROUP BY
      product_site,
      product_shop_site
  )

SELECT
  dt_param AS dt,
  COALESCE(t2.product_shop_site, t2.product_site) AS product_site,
  CAST(null AS STRING) AS product_shop_site,
  t1.gem_sku_raw_query_uniq_cnt,
  t1.gem_sku_qp_query_uniq_cnt,
  t1.gem_moodboard_sku_cnt,
  t1.gem_moodboard_sku_uniq_cnt,
  t1.gem_moodboard_1d_update_sku_cnt,
  t1.gem_moodboard_1d_update_sku_uniq_cnt,
  t1.gem_moodboard_7d_update_sku_cnt,
  t1.gem_moodboard_7d_update_sku_uniq_cnt,
  t1.gem_moodboard_28d_update_sku_cnt,
  t1.gem_moodboard_28d_update_sku_uniq_cnt,
  t1.gem_moodboard_p5_sku_seconds_amt,
  t1.gem_moodboard_p25_sku_seconds_amt,
  t1.gem_moodboard_p50_sku_seconds_amt,
  t1.gem_moodboard_p75_sku_seconds_amt,
  t1.gem_moodboard_p95_sku_seconds_amt,
  t2.inc_sku_uniq_cnt,
  t2.update_sku_uniq_cnt,
  t2.d7_update_and_inc_sku_uniq_cnt,
  t2.d28_update_and_inc_sku_uniq_cnt,
  t2.sku_uniq_cnt,
  t2.d7_inc_sku_uniq_cnt,
  t2.d28_inc_sku_uniq_cnt,
  t1.gem_moodboard_3d_update_sku_cnt,
  t1.gem_moodboard_3d_update_sku_uniq_cnt,
  t2.d3_update_and_inc_sku_uniq_cnt,
  t2.d3_inc_sku_uniq_cnt
FROM data_agg t1
RIGHT JOIN product_cube t2
  ON t1.product_site = COALESCE(t2.product_shop_site, t2.product_site)
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
