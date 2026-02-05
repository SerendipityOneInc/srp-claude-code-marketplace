CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_product_dw_search_metric_inc_1d_view`
AS WITH max_date AS (
  SELECT MAX(dt) AS max_dt
  FROM favie_rpt.rpt_product_dw_search_metric_inc_1d
)

SELECT
  t1.product_site,
  t1.product_shop_site,
  IF(t2.site_domain IS NULL or t2.site_domain = "shop.app" ,t1.product_shop_site,t2.site_domain) as site_domain,
  IF(t2.site_top_domain IS NULL, REGEXP_EXTRACT(t1.product_shop_site, r'([^.]+\.[^.]+)$'), t2.site_top_domain) AS site_top_domain,
  IF(t2.site_tier IS NULL, "Other", t2.site_tier) AS site_tier,
  IF(t2.site_rank IS NULL,"Other", t2.site_rank) AS site_rank,
  IF(t2.site_estimated_sku_num IS NULL, 0, t2.site_estimated_sku_num) AS site_estimated_sku_num,
  IF(t2.site_type IS NULL, "Other", t2.site_type) AS site_type,
  IF(t2.site_categories IS NULL, "Other", t2.site_categories) AS site_categories,
  IF(t2.site_parser_type IS NULL, "Other", t2.site_parser_type) AS site_parser_type,
  IF(t2.site_country_region IS NULL, "Other", t2.site_country_region) AS site_country_region,
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

  t1.gem_search_return_sku_cnt,
  t1.gem_search_return_sku_uniq_cnt,
  t1.gem_search_return_1d_update_sku_cnt,
  t1.gem_search_return_1d_update_sku_uniq_cnt,
  t1.gem_search_return_7d_update_sku_cnt,
  t1.gem_search_return_7d_update_sku_uniq_cnt,
  t1.gem_search_return_28d_update_sku_cnt,
  t1.gem_search_return_28d_update_sku_uniq_cnt,

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

  t1.gem_search_return_utilization_rate,
  t1.d1_gem_search_return_utilization_rate,
  t1.d7_gem_search_return_utilization_rate,
  t1.d28_gem_search_return_utilization_rate,

  t1.gem_moodboard_utilization_rate,
  t1.d1_gem_moodboard_utilization_rate,
  t1.d7_gem_moodboard_utilization_rate,
  t1.d28_gem_moodboard_utilization_rate,

  SAFE_DIVIDE(t3.including_preferred_image_product_uniq_cnt, t1.valid_sku_uniq_cnt) AS including_preferred_image_sku_rate,
  t3.including_preferred_image_product_uniq_cnt,

  t1.dt = max_dt as is_max_dt,
  t1.dt
FROM favie_rpt.rpt_product_dw_search_metric_inc_1d t1,max_date  
left outer join `favie_dw.dim_site_mut` t2
  on t1.product_site = t2.site_domain_without_www
left outer join `gensmo_rpt.rpt_gem_all_product_site_metric_full_1d` t3
  on t1.dt = t3.dt and t1.product_shop_site=t3.site;