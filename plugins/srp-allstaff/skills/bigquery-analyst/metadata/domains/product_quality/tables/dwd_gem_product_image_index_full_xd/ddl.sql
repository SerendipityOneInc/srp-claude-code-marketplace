CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_full_xd`
(
  dt DATE,
  CMD STRING,
  record_update_time TIMESTAMP,
  record_create_time TIMESTAMP,
  index_env STRING,
  f_sku_id STRING,
  f_spu_id STRING,
  site STRING,
  local_price INT64,
  local_currency INT64,
  base_price INT64,
  base_currency INT64,
  discount FLOAT64,
  norm_brand STRING,
  is_used INT64,
  inventory STRING,
  f_status STRING,
  created_time STRING,
  emb_images ARRAY<STRUCT<CMD STRING, image_url STRING, update_time TIMESTAMP>>,
  product_create_time TIMESTAMP,
  product_update_time TIMESTAMP
)
PARTITION BY dt
CLUSTER BY index_env, f_sku_id
OPTIONS(
  partition_expiration_days=30.0,
  require_partition_filter=true
);