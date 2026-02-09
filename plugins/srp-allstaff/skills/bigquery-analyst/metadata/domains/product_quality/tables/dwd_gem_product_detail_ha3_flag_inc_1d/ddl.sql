CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_flag_inc_1d`
(
  mode STRING,
  dt DATE
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=180.0,
  require_partition_filter=true
);