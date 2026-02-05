CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.ads_gem_image_tagging_statistics_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/ads_gem_image_tagging_statistics_1d/",
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/ads_gem_image_tagging_statistics_1d/dt=*"]
);