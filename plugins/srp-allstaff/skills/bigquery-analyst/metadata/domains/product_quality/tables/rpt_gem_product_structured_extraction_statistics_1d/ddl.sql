CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_gem_product_structured_extraction_statistics_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  enable_list_inference=true,
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_gem_product_structured_extraction_statistics_1d/",
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_gem_product_structured_extraction_statistics_1d/dt=*"]
);