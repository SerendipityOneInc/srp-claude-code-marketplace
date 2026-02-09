CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期"),
  refer STRING OPTIONS(description="页面名"),
  ap_name STRING OPTIONS(description="交互点名称"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件方法"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  item_type STRING OPTIONS(description="item类型"),
  app_version STRING OPTIONS(description="应用版本"),
  platform STRING OPTIONS(description="平台"),
  event_cnt INT64 OPTIONS(description="事件发生次数")
);