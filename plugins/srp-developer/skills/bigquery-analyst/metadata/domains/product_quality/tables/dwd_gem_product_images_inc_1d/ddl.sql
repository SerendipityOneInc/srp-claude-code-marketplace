CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_images_inc_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_gem_product_images_inc_1d/",
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_gem_product_images_inc_1d/dt=*"]
);