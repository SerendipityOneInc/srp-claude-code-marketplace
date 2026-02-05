CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_base_full_1h`
(
  f_sku_id STRING,
  f_spu_id STRING,
  site STRING,
  local_price INT64,
  is_used INT64,
  created_time STRING,
  inventory STRING,
  f_status STRING,
  base_update_time TIMESTAMP,
  base_update_date DATE,
  norm_brand STRING
)
PARTITION BY base_update_date
CLUSTER BY f_sku_id;