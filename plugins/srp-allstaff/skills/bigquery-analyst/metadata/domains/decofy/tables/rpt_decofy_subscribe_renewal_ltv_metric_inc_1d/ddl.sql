CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  product_id STRING OPTIONS(description="订阅产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  product_with_trial INT64 OPTIONS(description="首单是否使用免费试用，1表示使用，0表示未使用"),
  order_source STRING OPTIONS(description="订单来源"),
  first_order_due_30d_cnt INT64 OPTIONS(description="最近30天首单到期订单数"),
  first_order_renewal_30d_cnt INT64 OPTIONS(description="最近30天首单续订订单数"),
  first_order_due_60d_cnt INT64 OPTIONS(description="最近60天首单到期订单数"),
  first_order_renewal_60d_cnt INT64 OPTIONS(description="最近60天首单续订订单数"),
  default_first_order_renewal_rate FLOAT64 OPTIONS(description="兜底首单续订率"),
  second_order_due_30d_cnt INT64 OPTIONS(description="最近30天二单到期订单数"),
  second_order_renewal_30d_cnt INT64 OPTIONS(description="最近30天二单续订订单数"),
  second_order_due_60d_cnt INT64 OPTIONS(description="最近60天二单到期订单数"),
  second_order_renewal_60d_cnt INT64 OPTIONS(description="最近60天二单续订订单数"),
  default_second_order_renewal_rate FLOAT64 OPTIONS(description="兜底二单续订率"),
  third_more_order_due_30d_cnt INT64 OPTIONS(description="最近30天三单到期订单数"),
  third_more_order_renewal_30d_cnt INT64 OPTIONS(description="最近30天三单续订订单数"),
  third_more_order_due_60d_cnt INT64 OPTIONS(description="最近60天三单到期订单数"),
  third_more_order_renewal_60d_cnt INT64 OPTIONS(description="最近60天三单续订订单数"),
  default_third_more_order_renewal_rate FLOAT64 OPTIONS(description="兜底三单续订率")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);