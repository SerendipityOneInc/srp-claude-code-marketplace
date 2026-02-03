CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_process_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期,分区字段,格式YYYY-MM-DD"),
  user_id STRING OPTIONS(description="用户ID"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  user_group STRING OPTIONS(description="用户分群标签"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  product_id STRING OPTIONS(description="订阅产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  order_category STRING OPTIONS(description="订单类别，如订阅、续订、试用"),
  order_type STRING OPTIONS(description="订单类型，如新订阅、续订、试用转付费"),
  subscribe_trigger_source STRING OPTIONS(description="触发订阅流程的来源"),
  subscribe_trigger_cnt INT64 OPTIONS(description="触发订阅流程的次数"),
  subscribe_trigger_user_id STRING OPTIONS(description="触发订阅流程的用户ID"),
  subscribe_first_order_cnt INT64 OPTIONS(description="首次下单的次数"),
  subscribe_first_order_user_id STRING OPTIONS(description="首次下单的用户ID")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);