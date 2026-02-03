CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  country_name STRING OPTIONS(description="用户30日内最常使用所在国家"),
  platform STRING OPTIONS(description="用户当日使用最多的平台"),
  app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  user_login_type STRING OPTIONS(description="是否登录用户"),
  user_tenure_type STRING OPTIONS(description="用户使用时长类型，分为新用户和老用户"),
  user_group STRING OPTIONS(description="用户分组"),
  retention_user_d1_cnt INT64 OPTIONS(description="次日留存用户数"),
  active_user_cnt FLOAT64 OPTIONS(description="当日活跃用户数"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  ad_id STRING OPTIONS(description="广告ID")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);