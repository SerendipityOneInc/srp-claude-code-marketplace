CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_full_1d`
(
  dt DATE OPTIONS(description="全量时间分区,分区字段"),
  event_dt DATE OPTIONS(description="事件日期"),
  is_new_user STRING OPTIONS(description="是否为新用户 (new/old)"),
  ad_media_source STRING OPTIONS(description="广告媒体来源"),
  user_country STRING OPTIONS(description="用户所在国家"),
  last_platform STRING OPTIONS(description="用户当日使用最多的平台"),
  last_app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  user_type STRING OPTIONS(description="用户类型 (unregister/register/deregister)"),
  d0_active INT64 OPTIONS(description="基准日活跃用户数"),
  d1_retention INT64 OPTIONS(description="次日留存用户数"),
  d2_retention INT64 OPTIONS(description="D+2日留存用户数"),
  d6_retention INT64 OPTIONS(description="D+6日留存用户数"),
  LT_1_to_6 INT64 OPTIONS(description="D+1到D+6日期间用户总留存天"),
  w1_retention INT64 OPTIONS(description="第一周（D+7到D+13）留存用户数"),
  d1_7_retention INT64 OPTIONS(description="D+1到D+7日期间留存用户数")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=30.0
);