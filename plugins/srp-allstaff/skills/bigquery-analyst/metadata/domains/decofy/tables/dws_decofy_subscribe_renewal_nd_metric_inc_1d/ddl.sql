CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  user_id STRING OPTIONS(description="用户ID"),
  appsflyer_id STRING OPTIONS(description="appsflyer用户ID"),
  product_id STRING OPTIONS(description="订阅产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  product_with_trial INT64 OPTIONS(description="首单是否使用免费试用，1表示使用，0表示未使用"),
  order_source STRING OPTIONS(description="订单来源"),
  n_day INT64 OPTIONS(description="N天"),
  first_order_due_cnt INT64 OPTIONS(description="首单到期订单数"),
  first_order_renewal_cnt INT64 OPTIONS(description="首单续订订单数"),
  second_order_due_cnt INT64 OPTIONS(description="二单到期订单数"),
  second_order_renewal_cnt INT64 OPTIONS(description="二单续订订单数"),
  third_more_order_due_cnt INT64 OPTIONS(description="三+单到期订单数"),
  third_more_order_renewal_cnt INT64 OPTIONS(description="三+单续订订单数")
)
PARTITION BY dt
CLUSTER BY n_day
OPTIONS(
  require_partition_filter=true
);