CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_user_active_metrics_inc_1w`
(
  week_end_dt DATE OPTIONS(description="分区，周结束日期"),
  country_name STRING OPTIONS(description="用户30日内最常使用所在国家"),
  platform STRING OPTIONS(description="用户当周使用最多的平台"),
  app_version STRING OPTIONS(description="用户当周使用最多的app版本号"),
  user_login_type STRING OPTIONS(description="是否登录用户"),
  user_tenure_type STRING OPTIONS(description="是否新用户"),
  user_group STRING OPTIONS(description="用户分组"),
  active_user_w1_cnt INT64 OPTIONS(description="周活跃用户数"),
  total_duration FLOAT64 OPTIONS(description="总停留时长"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID")
)
PARTITION BY week_end_dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);