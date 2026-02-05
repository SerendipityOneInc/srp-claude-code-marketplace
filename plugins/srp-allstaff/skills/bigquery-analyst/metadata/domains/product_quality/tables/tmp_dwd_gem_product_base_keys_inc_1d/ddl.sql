CREATE TABLE `srpproduct-dc37e.favie_dw.tmp_dwd_gem_product_base_keys_inc_1d`
(
  dt DATE,
  f_sku_id STRING
)
PARTITION BY dt
CLUSTER BY f_sku_id
OPTIONS(
  partition_expiration_days=3.0
);