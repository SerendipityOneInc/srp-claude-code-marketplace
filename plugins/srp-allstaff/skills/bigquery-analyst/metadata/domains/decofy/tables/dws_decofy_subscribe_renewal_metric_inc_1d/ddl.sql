CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_renewal_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  user_id STRING OPTIONS(description="用户ID"),
  appsflyer_id STRING OPTIONS(description="appsflyer_id"),
  country_name STRING OPTIONS(description="国家名称"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="应用版本"),
  user_group STRING OPTIONS(description="用户组"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  product_id STRING OPTIONS(description="订阅产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  is_first_order_paid INT64 OPTIONS(description="首单是否付费，1表示付费，0表示未付费"),
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