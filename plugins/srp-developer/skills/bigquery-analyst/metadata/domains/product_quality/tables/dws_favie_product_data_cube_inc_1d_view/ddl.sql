CREATE VIEW `srpproduct-dc37e.favie_dw.dws_favie_product_data_cube_inc_1d_view`
AS SELECT
  t1.product_site,
  t1.product_site as site,
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
  t1.sku_uniq_cnt,
  t1.spu_uniq_cnt,
  t1.inc_sku_uniq_cnt,
  t1.inc_spu_uniq_cnt,
  t1.update_sku_uniq_cnt,
  t1.update_spu_uniq_cnt,
  t1.d7_update_and_inc_sku_uniq_cnt,
  t1.d7_update_and_inc_spu_uniq_cnt,
  t1.d28_update_and_inc_sku_uniq_cnt,
  t1.d28_update_and_inc_spu_uniq_cnt,
  t1.dt
FROM favie_dw.dws_favie_product_data_cube_inc_1d t1
left outer join `favie_dw.dim_site_mut` t2
  on t1.product_site = t2.site_domain_without_www;