CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_dqc_metrics_size_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_media_image_dqc_metrics_size_inc_1h/",
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_media_image_dqc_metrics_size_inc_1h/dt=*"]
);