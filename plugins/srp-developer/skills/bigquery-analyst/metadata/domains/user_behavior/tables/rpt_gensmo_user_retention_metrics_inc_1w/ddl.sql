CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w`
(
  week_end_dt DATE,
  country_name STRING,
  platform STRING,
  app_version STRING,
  user_login_type STRING,
  user_tenure_type STRING,
  user_group STRING,
  retention_user_w1_cnt INT64,
  active_user_cnt INT64,
  ad_source STRING OPTIONS(description="广告来源"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  ad_id STRING OPTIONS(description="广告ID")
)
PARTITION BY week_end_dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);