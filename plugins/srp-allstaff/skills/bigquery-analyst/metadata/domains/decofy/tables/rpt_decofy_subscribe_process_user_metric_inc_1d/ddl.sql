CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_process_user_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期,分区字段,格式YYYY-MM-DD"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  user_group STRING OPTIONS(description="用户分群标签"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  active_user_cnt INT64 OPTIONS(description="活跃用户数"),
  subscribe_trigger_user_cnt INT64 OPTIONS(description="触发订阅流程的用户数"),
  subscribe_first_order_user_cnt INT64 OPTIONS(description="首次下单的用户数")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);