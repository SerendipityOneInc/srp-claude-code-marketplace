CREATE TABLE `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_ad_info_mapping_full_1d`
(
  dt DATE OPTIONS(description="全量日期"),
  event_name STRING OPTIONS(description="appsflyer触达的事件名称"),
  appsflyer_id STRING OPTIONS(description="appsflyer_id"),
  source STRING OPTIONS(description="触达来源只包括广告触达,此处枚举值为Meta Ads、Google Ads、TikTok Ads等"),
  account_id STRING OPTIONS(description="广告账户ID"),
  campaign_id STRING OPTIONS(description="广告活动ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_id STRING OPTIONS(description="广告ID"),
  event_order_seq INT64 OPTIONS(description="appsflyer触达的事件顺序,按照时间正序排列")
)
PARTITION BY dt
CLUSTER BY source, event_name
OPTIONS(
  description="appsflyer id与广告归属信息,每天包含全量数据"
);