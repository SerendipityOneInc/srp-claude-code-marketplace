CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_operation_push_message_metrics_inc_1d`
(
  dt DATE OPTIONS(description="统计日期（按推送完成日期）"),
  user_id STRING OPTIONS(description="用户ID"),
  push_name STRING OPTIONS(description="推送事件名称"),
  sent_count INT64 OPTIONS(description="发送次数（实际发送成功的次数）"),
  click_count INT64 OPTIONS(description="点击次数（实际点击次数）"),
  platform STRING OPTIONS(description="推送平台/端"),
  user_type STRING OPTIONS(description="用户类型：新用户或老用户")
)
PARTITION BY dt;