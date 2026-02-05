CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_dqc_metrics_size_full_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_media_image_dqc_metrics_size_full_1d/",
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_media_image_dqc_metrics_size_full_1d/dt=*"]
);