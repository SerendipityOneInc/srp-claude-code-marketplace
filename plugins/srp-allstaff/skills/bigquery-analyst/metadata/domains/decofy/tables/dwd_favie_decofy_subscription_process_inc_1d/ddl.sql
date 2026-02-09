CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_process_inc_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  user_id STRING OPTIONS(description="用户ID"),
  process_node STRING OPTIONS(description="节点类型"),
  trigger_source STRING OPTIONS(description="触发来源"),
  product_id STRING OPTIONS(description="产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  order_id STRING OPTIONS(description="订单ID"),
  order_category STRING OPTIONS(description="订单类目"),
  order_type STRING OPTIONS(description="订单类型"),
  order_subscription_seq INT64 OPTIONS(description="订单订阅序号"),
  process_time TIMESTAMP OPTIONS(description="节点时间"),
  trigger_pay_seq INT64 OPTIONS(description="trigger_pay序号"),
  subscription_id STRING OPTIONS(description="订阅ID")
)
PARTITION BY dt;