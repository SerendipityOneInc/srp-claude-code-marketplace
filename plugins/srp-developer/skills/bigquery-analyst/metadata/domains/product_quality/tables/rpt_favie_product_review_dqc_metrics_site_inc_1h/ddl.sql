CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_dqc_metrics_site_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_product_review_dqc_metrics_site_inc_1h/",
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_product_review_dqc_metrics_site_inc_1h/dt=*"]
);