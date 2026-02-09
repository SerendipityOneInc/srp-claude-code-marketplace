CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_gem_product_ha3_merge_config_inc_1d`
(
  dt DATE,
  biz STRING,
  merge_mode STRING,
  model_config STRUCT<collage_category_model_version STRING, product_enhanced_category_model_version STRING, product_enhanced_title_model_version STRING, product_image_score_model_version STRING, product_item_profile_model_version STRING>,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=180.0
);