CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_user_ltn_metrics_inc_1d`
(
  dt DATE,
  user_tenure_type STRING,
  user_login_type STRING,
  country_name STRING,
  platform STRING,
  app_version STRING,
  user_group STRING,
  lifetime_days INT64,
  active_days_cnt INT64,
  active_user_cnt INT64,
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