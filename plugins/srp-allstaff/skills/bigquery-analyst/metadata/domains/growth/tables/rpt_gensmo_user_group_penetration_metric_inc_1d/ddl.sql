CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  user_tenure_type STRING OPTIONS(description="用户周期类型: New User/Old User"),
  user_login_type STRING OPTIONS(description="是否登录用户"),
  country_name STRING OPTIONS(description="用户30日内最常使用所在国家"),
  platform STRING OPTIONS(description="用户当日使用最多的平台"),
  app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  user_group STRING OPTIONS(description="用户分组"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  group_user_cnt INT64 OPTIONS(description="用户组用户数"),
  active_user_cnt INT64 OPTIONS(description="活跃用户数")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);