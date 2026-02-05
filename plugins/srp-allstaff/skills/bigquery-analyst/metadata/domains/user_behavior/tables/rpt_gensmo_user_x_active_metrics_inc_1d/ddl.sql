CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  country_name STRING OPTIONS(description="用户30日内最常使用所在国家"),
  platform STRING OPTIONS(description="用户当日使用最多的平台"),
  app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  user_login_type STRING OPTIONS(description="是否登录用户"),
  user_tenure_segment STRING OPTIONS(description="用户周期细分类型: New User(1 Day)/New User(2-7 Days)/New User(8-30 Days)/Old User"),
  user_tenure_type STRING OPTIONS(description="用户周期类型: New User/Old User"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  user_group STRING OPTIONS(description="用户分组"),
  active_period INT64 OPTIONS(description="活跃周期：1、7、30天"),
  active_user_cnt INT64 OPTIONS(description="1日活跃用户数"),
  user_duration FLOAT64 OPTIONS(description="1日活跃用户总停留时长"),
  group_type STRING OPTIONS(description="数据分组类型")
)
PARTITION BY dt
CLUSTER BY group_type, user_group, active_period
OPTIONS(
  require_partition_filter=true
);