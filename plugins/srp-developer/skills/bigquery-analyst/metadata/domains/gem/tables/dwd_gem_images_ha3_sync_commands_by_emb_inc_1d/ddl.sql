CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_images_ha3_sync_commands_by_emb_inc_1d`
(
  dt DATE,
  CMD STRING,
  target_image_id STRING,
  f_sku_id STRING,
  f_url STRING,
  embedding ARRAY<FLOAT64>
)
PARTITION BY dt
CLUSTER BY f_sku_id
OPTIONS(
  partition_expiration_days=30.0
);