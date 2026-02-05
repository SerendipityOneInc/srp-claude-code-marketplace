CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_operation_pre_search_message_metrics_inc_1d`
(
  dt DATE OPTIONS(description="统计日期"),
  user_id STRING OPTIONS(description="用户ID"),
  device_id STRING OPTIONS(description="设备ID"),
  event_item_item_type STRING OPTIONS(description="事件项类型（event_item.item_type）"),
  event_item_item_name STRING OPTIONS(description="事件项名称（event_item.item_name）"),
  count_pre_search INT64 OPTIONS(description="每个device_id下每个item_type+item_name的搜索次数"),
  user_group STRING OPTIONS(description="用户分组"),
  country_name STRING OPTIONS(description="国家名称"),
  platform STRING OPTIONS(description="平台/端"),
  app_version STRING OPTIONS(description="APP版本"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户新老类型")
)
PARTITION BY dt;