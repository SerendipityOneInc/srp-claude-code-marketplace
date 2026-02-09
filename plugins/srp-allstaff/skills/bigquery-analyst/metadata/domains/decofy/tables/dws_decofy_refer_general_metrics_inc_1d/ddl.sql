CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_refer_general_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  user_id STRING OPTIONS(description="用户ID"),
  refer STRING OPTIONS(description="页面名称"),
  ap_name STRING OPTIONS(description="AP名称"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件方法"),
  event_action_type STRING OPTIONS(description="事件动作类型"),
  data_name STRING OPTIONS(description="数据名称"),
  data_value FLOAT64 OPTIONS(description="数据值")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);