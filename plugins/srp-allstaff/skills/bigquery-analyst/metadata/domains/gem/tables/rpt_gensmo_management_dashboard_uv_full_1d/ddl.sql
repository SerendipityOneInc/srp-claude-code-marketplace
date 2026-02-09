CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_uv_full_1d`
(
  dt DATE OPTIONS(description="全量时间分区,分区字段"),
  event_dt DATE OPTIONS(description="事件日期"),
  ad_media_source STRING OPTIONS(description="广告媒体来源"),
  user_country STRING OPTIONS(description="用户所在国家"),
  last_platform STRING OPTIONS(description="用户当日使用最多的平台"),
  last_app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  user_type STRING OPTIONS(description="用户类型 (unregister/register/deregister)"),
  mau INT64 OPTIONS(description="月活跃用户数 (MAU)"),
  dau INT64 OPTIONS(description="日活跃用户数 (DAU)"),
  wau INT64 OPTIONS(description="周活跃用户数 (WAU)")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=30.0
);