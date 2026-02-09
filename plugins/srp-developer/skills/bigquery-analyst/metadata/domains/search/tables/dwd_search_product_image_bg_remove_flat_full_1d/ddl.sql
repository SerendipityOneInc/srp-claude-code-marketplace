CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_search_product_image_bg_remove_flat_full_1d`
WITH PARTITION COLUMNS (
  dt STRING,
  model_version STRING
)
OPTIONS(
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_search_product_image_bg_remove_flat_full_1d/",
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_search_product_image_bg_remove_flat_full_1d/dt=*"]
);