CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_inc_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_product_detail_inc_1d/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_product_detail_inc_1d/dt=*"]
);