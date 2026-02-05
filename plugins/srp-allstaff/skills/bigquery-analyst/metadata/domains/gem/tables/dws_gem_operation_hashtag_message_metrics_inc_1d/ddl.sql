CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d`
(
  dt DATE OPTIONS(description="统计日期"),
  user_id STRING OPTIONS(description="用户ID"),
  device_id STRING OPTIONS(description="设备ID"),
  event_item_item_id STRING OPTIONS(description="Hashtag ID"),
  count_hashtag INT64 OPTIONS(description="该设备/用户在当天点击该Hashtag的次数"),
  user_group STRING OPTIONS(description="用户分群"),
  country_name STRING OPTIONS(description="国家/地区"),
  platform STRING OPTIONS(description="平台/端"),
  app_version STRING OPTIONS(description="APP版本"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户新老类型")
)
PARTITION BY dt;