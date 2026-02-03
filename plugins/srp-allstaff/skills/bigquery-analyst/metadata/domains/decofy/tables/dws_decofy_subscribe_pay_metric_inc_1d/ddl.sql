CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_pay_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
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
  product_with_trial INT64 OPTIONS(description="首单是否使用免费试用，1表示使用，0表示未使用"),
  order_source STRING OPTIONS(description="订单来源"),
  subscribe_7d_user_id STRING OPTIONS(description="7天内有订阅的用户ID"),
  subscribe_7d_subscription_id STRING OPTIONS(description="7天内订阅的订阅ID"),
  subscribe_7d_first_order_discount_amount INT64 OPTIONS(description="订阅首笔订单优惠金额"),
  subscribe_pay_14d_user_id STRING OPTIONS(description="14天内有订阅且付费的用户ID"),
  subscribe_pay_14d_subscription_id STRING OPTIONS(description="7天内订阅且14内付费的订阅ID")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);