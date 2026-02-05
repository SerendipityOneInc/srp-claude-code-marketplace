CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_product_index_swift_write_result_add_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_product_index_swift_write_result_add_1h/",
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_product_index_swift_write_result_add_1h/dt=*"]
);