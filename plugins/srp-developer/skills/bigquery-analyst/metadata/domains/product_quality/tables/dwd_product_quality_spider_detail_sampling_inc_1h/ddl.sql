CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_product_quality_spider_detail_sampling_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp_datalake-production/product_quality/product_data_check_hourly/ods_product_quality_spider_detail_sampling_inc_1h/",
  require_hive_partition_filter=true,
  uris=["gs://srp_datalake-production/product_quality/product_data_check_hourly/ods_product_quality_spider_detail_sampling_inc_1h/dt=*"]
);