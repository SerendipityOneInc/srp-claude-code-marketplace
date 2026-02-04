CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_images_embedding_full_1d`
(
  f_sku_id STRING,
  f_url STRING,
  target_image_id STRING,
  embedding ARRAY<FLOAT64>,
  emb_update_time TIMESTAMP,
  emb_update_date DATE
)
PARTITION BY emb_update_date
CLUSTER BY f_sku_id, f_url;