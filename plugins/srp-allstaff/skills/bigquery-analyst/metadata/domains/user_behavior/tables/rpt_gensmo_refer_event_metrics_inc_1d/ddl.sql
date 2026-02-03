CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_event_metrics_inc_1d`
(
  refer STRING OPTIONS(description="来源"),
  pre_refer STRING OPTIONS(description="上级来源"),
  ap_name STRING OPTIONS(description="ap名称"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件方法"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="app版本"),
  native_version STRING OPTIONS(description="native版本"),
  event_cnt INT64 OPTIONS(description="事件数"),
  event_user_cnt INT64 OPTIONS(description="事件访客数"),
  dt DATE OPTIONS(description="分区，日期")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);