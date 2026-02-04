CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_order_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  country_name STRING OPTIONS(description="用户30日内最常使用所在国家"),
  platform STRING OPTIONS(description="用户当日使用最多的平台"),
  app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  user_group STRING OPTIONS(description="用户分组"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  order_source STRING OPTIONS(description="订单来源"),
  product_id STRING OPTIONS(description="产品ID"),
  simple_product_id STRING OPTIONS(description="产品简化ID"),
  subscription_type STRING OPTIONS(description="订阅类型：first_subscription, resubscription"),
  order_category STRING OPTIONS(description="订单一级分类：pay_order, trial_order, benefit_order, unknown_order"),
  order_type STRING OPTIONS(description="订单二级分类：trial, trial_to_paid, benefit, benefit_to_paid, paid, renewal, unknown"),
  created_order_cnt INT64 OPTIONS(description="当天创建订单数"),
  created_order_amount INT64 OPTIONS(description="当天创建订单收入"),
  due_order_cnt INT64 OPTIONS(description="当天到期订单数"),
  due_order_amount INT64 OPTIONS(description="当天到期订单收入"),
  renewed_order_cnt INT64 OPTIONS(description="当天续订订单数"),
  renewed_order_amount INT64 OPTIONS(description="当天续订订单收入")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);