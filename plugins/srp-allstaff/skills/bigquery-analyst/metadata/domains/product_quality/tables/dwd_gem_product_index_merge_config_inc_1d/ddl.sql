CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_index_merge_config_inc_1d`
(
  dt DATE,
  biz STRING,
  index_env STRING,
  merge_mode STRING,
  model_config STRING,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=180.0
);