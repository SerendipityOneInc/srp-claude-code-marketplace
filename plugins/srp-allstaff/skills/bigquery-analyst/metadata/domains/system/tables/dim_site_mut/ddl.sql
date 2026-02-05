CREATE TABLE `srpproduct-dc37e.favie_dw.dim_site_mut`
(
  site_domain STRING,
  site_domain_without_www STRING,
  site_top_domain STRING,
  site_tier STRING,
  site_rank STRING,
  site_estimated_sku_num INT64,
  site_categories STRING,
  site_type STRING,
  site_parser_type STRING,
  site_country_region STRING,
  launch_date DATE,
  update_date DATE,
  label STRING,
  data_quality_config_json STRING,
  refresh_interval STRING,
  archive_interval INT64,
  index_config STRING
);