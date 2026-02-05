CREATE TABLE `srpproduct-dc37e.favie_dw.tmp_dwd_gem_images_index_keys_inc_1h`
(
  biz_time TIMESTAMP,
  f_sku_id STRING,
  product_status STRING,
  f_url STRING
)
PARTITION BY TIMESTAMP_TRUNC(biz_time, HOUR)
CLUSTER BY f_sku_id
OPTIONS(
  partition_expiration_days=1.0
);