CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_inc_1h`
(
  CMD STRING,
  f_sku_id STRING,
  site STRING,
  sku_id STRING,
  spu_id STRING,
  local_price INT64,
  local_currency INT64,
  base_price INT64,
  base_currency INT64,
  discount FLOAT64,
  inventory STRING,
  product_created_at TIMESTAMP,
  product_updated_at TIMESTAMP,
  record_time TIMESTAMP,
  record_hour STRING,
  dt DATE
)
PARTITION BY dt
CLUSTER BY record_hour
OPTIONS(
  partition_expiration_days=14.0,
  require_partition_filter=true
);