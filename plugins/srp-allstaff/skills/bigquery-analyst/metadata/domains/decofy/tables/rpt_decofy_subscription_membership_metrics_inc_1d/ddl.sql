CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d`
(
  dt DATE OPTIONS(description="统计日期"),
  country_name STRING OPTIONS(description="用户国家"),
  platform STRING OPTIONS(description="平台"),
  user_group STRING OPTIONS(description="用户分组"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  order_source STRING OPTIONS(description="订单来源"),
  membership_tenure_type STRING OPTIONS(description="会员生命周期类型：new,active,expiring,expired"),
  subscription_active_user_cnt INT64 OPTIONS(description="活跃订阅用户数"),
  subscription_renewal_user_cnt INT64 OPTIONS(description="续订用户数"),
  subscription_should_expires_user_cnt INT64 OPTIONS(description="应到期订阅用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);