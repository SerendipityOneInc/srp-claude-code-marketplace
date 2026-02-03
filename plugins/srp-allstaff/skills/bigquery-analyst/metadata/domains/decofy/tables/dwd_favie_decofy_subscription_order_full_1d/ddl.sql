CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d`
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
  subscription_id STRING OPTIONS(description="订阅ID，用于标识同一个订阅下的所有订单"),
  subscription_created_at TIMESTAMP OPTIONS(description="订阅创建时间"),
  subscription_seq INT64 OPTIONS(description="订阅序号（按订阅创建时间，1为首次）"),
  original_transaction_id STRING OPTIONS(description="原始交易ID"),
  order_id STRING OPTIONS(description="订单ID，订单记录的唯一标识"),
  order_source STRING OPTIONS(description="订单来源: iOS,Android"),
  order_paid_amount INT64 OPTIONS(description="实际支付价格"),
  order_paid_currency STRING OPTIONS(description="实际支付货币"),
  order_created_at TIMESTAMP OPTIONS(description="交易创建时间"),
  order_updated_at TIMESTAMP OPTIONS(description="交易更新时间"),
  order_expires_date TIMESTAMP OPTIONS(description="交易到期时间"),
  order_deleted_at TIMESTAMP OPTIONS(description="交易删除时间"),
  order_renewal_at TIMESTAMP OPTIONS(description="续费时间"),
  order_category STRING OPTIONS(description="订单一级分类：pay_order, trial_order, benefit_order, unknown_order"),
  order_type STRING OPTIONS(description="订单二级类型：trial, trial_to_paid, benefit, benefit_to_paid, paid, renewal, unknown"),
  order_seq INT64 OPTIONS(description="订单序号（按时间倒序，1为最新）"),
  order_subscription_seq INT64 OPTIONS(description="订单在订阅中的序号（按时间倒序，1为最新）"),
  order_days_to_expire INT64 OPTIONS(description="距离到期天数")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=7.0
);