CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_action_user_penetration_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期"),
  user_tenure_type STRING OPTIONS(description="用户生命周期类型"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  country_name STRING OPTIONS(description="国家名称"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="应用版本"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  user_group STRING OPTIONS(description="用户分组"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  event_action_user_cnt INT64 OPTIONS(description="事件行为用户数"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true,
  description="Gensmo事件行为用户渗透率报表"
);