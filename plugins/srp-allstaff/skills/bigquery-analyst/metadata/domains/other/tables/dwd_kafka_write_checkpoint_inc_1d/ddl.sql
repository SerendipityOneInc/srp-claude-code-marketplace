CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_kafka_write_checkpoint_inc_1d`
WITH PARTITION COLUMNS (
  dt STRING,
  task STRING,
  biz STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_kafka_write_checkpoint_inc_1d/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_kafka_write_checkpoint_inc_1d/dt=*"]
);