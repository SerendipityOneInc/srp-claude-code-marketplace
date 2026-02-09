CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_cube_inc_1d`
(
  raw_query STRING,
  qr_query STRING,
  qp_query STRING,
  query_modality STRING,
  query_source STRING,
  query_intention_level1 STRING,
  query_intention_level2 STRING,
  user_type STRING,
  user_login_type STRING,
  user_tenure_type STRING,
  country_name STRING,
  platform STRING,
  app_version STRING,
  ad_source STRING,
  ad_campaign_id STRING,
  ad_group_id STRING,
  ad_id STRING,
  raw_query_word_amt INT64,
  qr_query_word_amt INT64,
  qp_query_word_amt INT64,
  query_cnt INT64,
  query_user_uniq_cnt INT64,
  dt DATE
)
PARTITION BY dt;