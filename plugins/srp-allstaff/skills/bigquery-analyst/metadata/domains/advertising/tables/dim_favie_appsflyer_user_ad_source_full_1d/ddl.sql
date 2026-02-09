CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_appsflyer_user_ad_source_full_1d`
(
  dt DATE OPTIONS(description="快照日期"),
  created_date DATE OPTIONS(description="创建日期"),
  appsflyer_id STRING OPTIONS(description="广告平台用户ID"),
  source STRING OPTIONS(description="广告来源"),
  channel STRING OPTIONS(description="广告渠道"),
  platform STRING OPTIONS(description="平台"),
  campaign_id STRING OPTIONS(description="广告活动ID"),
  campaign_name STRING OPTIONS(description="广告活动名称"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_group_name STRING OPTIONS(description="广告组名称"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_name STRING OPTIONS(description="广告名称"),
  country_code STRING OPTIONS(description="国家代码"),
  event_name STRING OPTIONS(description="事件名称"),
  app_name STRING OPTIONS(description="应用名称")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=7.0
);