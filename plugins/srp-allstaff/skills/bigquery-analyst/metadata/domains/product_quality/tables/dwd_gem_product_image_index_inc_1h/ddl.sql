CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_image_index_inc_1h`
(
  dt DATE,
  CMD STRING,
  record_time TIMESTAMP,
  record_hour STRING,
  f_sku_id STRING,
  f_spu_id STRING,
  site STRING,
  f_status STRING,
  local_price INT64,
  local_currency INT64,
  base_price INT64,
  base_currency INT64,
  discount FLOAT64,
  is_used INT64,
  inventory STRING,
  image_urls ARRAY<STRING>,
  created_time STRING,
  product_create_time TIMESTAMP,
  product_update_time TIMESTAMP
)
PARTITION BY dt
CLUSTER BY f_sku_id
OPTIONS(
  partition_expiration_days=7.0,
  require_partition_filter=true
);