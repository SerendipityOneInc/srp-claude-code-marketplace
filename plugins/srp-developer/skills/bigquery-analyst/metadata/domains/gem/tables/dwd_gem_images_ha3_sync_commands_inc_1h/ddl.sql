CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_images_ha3_sync_commands_inc_1h`
(
  biz_time TIMESTAMP,
  CMD STRING,
  target_image_id STRING,
  f_sku_id STRING,
  f_url STRING,
  embedding ARRAY<FLOAT64>
)
PARTITION BY TIMESTAMP_TRUNC(biz_time, HOUR)
CLUSTER BY f_sku_id
OPTIONS(
  partition_expiration_days=7.0
);