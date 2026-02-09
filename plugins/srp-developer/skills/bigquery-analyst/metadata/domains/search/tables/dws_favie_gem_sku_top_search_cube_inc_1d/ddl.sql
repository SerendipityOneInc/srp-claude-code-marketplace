CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`
(
  product_site STRING,
  product_shop_site STRING,
  user_type STRING,
  country_name STRING,
  user_login_type STRING,
  user_tenure_type STRING,
  platform STRING,
  app_version STRING,
  ad_source STRING,
  ad_campaign_id STRING,
  ad_group_id STRING,
  ad_id STRING,
  product_sku_id STRING,
  product_cate_tag STRING,
  product_title STRING,
  product_link STRING,
  product_image_link STRING,
  product_price_raw STRING,
  product_gem_return_cnt INT64,
  product_gem_return_user_uniq_cnt INT64,
  product_moodboard_cnt INT64,
  product_moodboard_user_uniq_cnt INT64,
  dt DATE
)
PARTITION BY dt;