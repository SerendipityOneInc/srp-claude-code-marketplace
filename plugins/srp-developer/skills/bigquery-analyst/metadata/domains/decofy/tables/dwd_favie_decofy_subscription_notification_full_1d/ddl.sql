CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  user_id STRING OPTIONS(description="用户ID"),
  appsflyer_id STRING OPTIONS(description="appsflyer ID"),
  product_id STRING OPTIONS(description="产品ID"),
  simple_product_id STRING OPTIONS(description="简化产品ID"),
  product_price INT64 OPTIONS(description="产品价格（USD）"),
  product_first_order_price INT64 OPTIONS(description="产品首单价格（USD）"),
  product_currency STRING OPTIONS(description="产品货币"),
  product_with_trial INT64 OPTIONS(description="是否包含试用期：1(包含), 0(不包含)"),
  product_period INT64 OPTIONS(description="产品周期（天）"),
  notification_uuid STRING OPTIONS(description="订阅消息UUID"),
  notification_type STRING OPTIONS(description="订阅消息类型"),
  transaction_id STRING OPTIONS(description="交易ID"),
  original_transaction_id STRING OPTIONS(description="原始交易ID"),
  subscription_status INT64 OPTIONS(description="订阅状态"),
  subtype STRING OPTIONS(description="订阅消息子类型"),
  created_at TIMESTAMP OPTIONS(description="创建时间"),
  updated_at TIMESTAMP OPTIONS(description="更新时间")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=7.0
);