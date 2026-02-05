CREATE TABLE `srpproduct-dc37e.favie_dw.tmp_dwd_gem_images_index_keys_full_1d`
(
  dt DATE,
  f_sku_id STRING,
  f_url STRING
)
PARTITION BY dt
CLUSTER BY f_sku_id
OPTIONS(
  partition_expiration_days=14.0
);