CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_renewal_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  country_name STRING OPTIONS(description="国家名称"),
  platform STRING OPTIONS(description="平台"),
  user_group STRING OPTIONS(description="用户组"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  product_id STRING OPTIONS(description="订阅产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  product_with_trial INT64 OPTIONS(description="首单是否使用免费试用，1表示使用，0表示未使用"),
  order_source STRING OPTIONS(description="订单来源"),
  first_order_due_cnt INT64 OPTIONS(description="首单到期订单数数"),
  first_order_renewal_cnt INT64 OPTIONS(description="首单续订订单数"),
  second_order_due_cnt INT64 OPTIONS(description="二单到期订单数"),
  second_order_renewal_cnt INT64 OPTIONS(description="二单续订订单数"),
  third_more_order_due_cnt INT64 OPTIONS(description="三单到期订单数"),
  third_more_order_renewal_cnt INT64 OPTIONS(description="三单续订订单数")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);