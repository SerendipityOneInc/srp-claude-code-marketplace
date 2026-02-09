CREATE VIEW `srpproduct-dc37e.favie_dw.dim_site_mut_view`
AS SELECT 
  site_domain,
  REGEXP_REPLACE(site_domain, r'^www\.', '') as site_domain_without_www,
  REGEXP_EXTRACT(site_domain, r'([^.]+\.[^.]+)$') AS site_top_domain,  
  site_tier,
  `rank` as site_rank,
  estimated_sku_num as site_estimated_sku_num,
  categories as site_categories,
  site_type,
  parser_type as site_parser_type,
  country_region as site_country_region,
  launch_date,
  update_date,
  label,
  data_quality_config_json,
  refresh_interval,
  archive_interval,
  index_config
from favie_dw.dim_site_mut_google_sheet;