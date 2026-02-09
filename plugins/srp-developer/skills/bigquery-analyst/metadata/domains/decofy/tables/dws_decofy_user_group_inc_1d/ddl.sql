CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_user_group_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  user_group STRING OPTIONS(description="分组名称"),
  user_id STRING OPTIONS(description="用户ID"),
  appsflyer_id STRING OPTIONS(description="Appsflyer ID"),
  country_name STRING OPTIONS(description="国家名称"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="应用版本"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户使用时长类型"),
  user_activity_type STRING OPTIONS(description="用户活跃状态: active,inactive"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  membership_tenure_type STRING OPTIONS(description="会员生命周期: new,active,expiring,expired"),
  membership_pay_status STRING OPTIONS(description="是否付费过费： paid,unpaid")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);