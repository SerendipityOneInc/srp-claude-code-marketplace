CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_product_index_swift_pre_delete_result_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_product_index_swift_pre_delete_result_1d/",
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_product_index_swift_pre_delete_result_1d/dt=*"]
);