CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_product_quality_result_integration_field_metadata_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  description="商品数据质量检查 Field 级别元数据表（外表），支持精确的优先级控制和白名单过滤",
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp_datalake-production/product_quality/product_data_check_hourly/dwd_product_quality_result_integration_field_metadata_inc_1h/",
  require_hive_partition_filter=true,
  uris=["gs://srp_datalake-production/product_quality/product_data_check_hourly/dwd_product_quality_result_integration_field_metadata_inc_1h/dt=*"]
);