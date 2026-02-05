CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_refer_event_metrics_inc_1d`
(
  device_id STRING OPTIONS(description="设备ID"),
  user_tenure_type STRING OPTIONS(description="是否新用户"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_country_name STRING OPTIONS(description="用户国家"),
  refer STRING OPTIONS(description="来源"),
  ap_name STRING OPTIONS(description="ap名称"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件方法"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  pre_refer STRING OPTIONS(description="上级来源"),
  pre_refer_ap_name STRING OPTIONS(description="上级ap名称"),
  pre_refer_event_name STRING OPTIONS(description="上级事件名称"),
  pre_refer_event_method STRING OPTIONS(description="上级事件方法"),
  pre_refer_event_action_type STRING OPTIONS(description="上级事件行为类型"),
  next_refer STRING OPTIONS(description="下级来源"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="app版本"),
  web_version STRING OPTIONS(description="native版本"),
  event_version STRING OPTIONS(description="事件版本"),
  event_cnt INT64 OPTIONS(description="事件数"),
  dt DATE OPTIONS(description="分区，日期")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);