CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_notification_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
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
  subscribe_disable_notification_cnt INT64 OPTIONS(description="订阅禁用通知次数"),
  subscribe_refund_notification_cnt INT64 OPTIONS(description="订阅退款通知次数")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);