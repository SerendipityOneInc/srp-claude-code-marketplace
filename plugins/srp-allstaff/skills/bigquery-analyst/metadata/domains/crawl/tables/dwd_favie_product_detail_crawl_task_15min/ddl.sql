CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_crawl_task_15min`
WITH PARTITION COLUMNS (
  dt STRING,
  hh STRING,
  mm STRING,
  biz STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_product_detail_crawl_task_15min/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_product_detail_crawl_task_15min/dt=*"]
);