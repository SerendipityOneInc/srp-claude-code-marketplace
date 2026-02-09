CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_structured_extraction_demographic_full_1d`
WITH PARTITION COLUMNS (
  dt STRING,
  model_version STRING,
  bucket STRING,
  world_size STRING,
  rank STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp_dataset-production/algo/dwd_gem_product_structured_extraction_demographic_full_1d/",
  uris=["gs://srp_dataset-production/algo/dwd_gem_product_structured_extraction_demographic_full_1d/dt=*"]
);