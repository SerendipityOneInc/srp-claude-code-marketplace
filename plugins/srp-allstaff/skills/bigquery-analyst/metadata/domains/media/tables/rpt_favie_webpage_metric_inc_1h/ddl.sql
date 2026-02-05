CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_webpage_metric_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_webpage_metric_inc_1h/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_webpage_metric_inc_1h/dt=*"]
);