WITH 
  base_data AS (
      SELECT
          dt_param AS dt,
          JSON_VALUE(moodboard_product,'$.source') AS product_site,
          CAST(NULL AS STRING) AS product_shop_site,
          
          --aditional info
          query AS raw_query,
          JSON_VALUE(moodboard_product,'$.query') AS qp_query,
          JSON_VALUE(moodboard_product,'$.id') AS product_id,
          TIMESTAMP_DIFF(
            created_time,
            TIMESTAMP_SECONDS(
              SAFE_CAST(
                COALESCE(
                  JSON_VALUE(moodboard_product,'$.f_updates_at'),
                  JSON_VALUE(moodboard_product,'$.f_creates_at')
                )
              AS INT)
            ),
            SECOND
          ) AS time_gap
      FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
      CROSS JOIN UNNEST(moodboard_products) AS moodboard_product
      WHERE
          DATE(created_time) = dt_param AND
          query IS NOT NULL AND 
          query != '' AND
          JSON_VALUE(moodboard_product,'$.query') IS NOT NULL AND 
          JSON_VALUE(moodboard_product,'$.query') != '' AND
          JSON_VALUE(moodboard_product,'$.f_creates_at') IS NOT NULL AND
          JSON_VALUE(moodboard_product,'$.f_creates_at') != ''
  ),
  data_agg AS (
      SELECT
          -- basic info
          dt,
          product_site,
          product_shop_site,


          -- raw query
          COUNT(DISTINCT raw_query) AS gem_sku_raw_query_uniq_cnt,

          --qp query
          COUNT(DISTINCT qp_query) AS gem_sku_qp_query_uniq_cnt,

          -- sku
          COUNT(1) AS gem_moodboard_sku_cnt,
          COUNT(DISTINCT product_id) AS gem_moodboard_sku_uniq_cnt,

          -- sku upate 1d
          COUNTIF(time_gap <= 86400) AS gem_moodboard_1d_update_sku_cnt,
          COUNT(DISTINCT IF(time_gap <= 86400, product_id, NULL)) AS gem_moodboard_1d_update_sku_uniq_cnt,

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
          product_site,
          product_shop_site
  )

SELECT
  t1.dt,
  t1.product_site,
  t1.product_shop_site,
  t2.site_domain,
  t2.site_top_domain,
  t2.site_tier,
  t2.site_type,
  t2.site_categories,
  t2.site_parser_type,
  t2.site_country_region,
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
  t2.site_rank
FROM data_agg t1
LEFT JOIN `srpproduct-dc37e.favie_dw.dim_site_mut_view` t2
  ON t1.product_site = t2.site_domain_without_www