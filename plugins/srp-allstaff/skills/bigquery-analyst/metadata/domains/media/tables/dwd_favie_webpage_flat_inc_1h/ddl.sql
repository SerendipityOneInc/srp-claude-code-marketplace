CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_favie_webpage_flat_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_webpage_flat_inc_1h/",
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_webpage_flat_inc_1h/dt=*"]
);