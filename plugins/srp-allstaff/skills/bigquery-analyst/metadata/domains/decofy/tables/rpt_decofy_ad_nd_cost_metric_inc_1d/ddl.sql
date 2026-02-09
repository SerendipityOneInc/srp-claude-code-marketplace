CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  n_day INT64 OPTIONS(description="N天"),
  ad_cost FLOAT64 OPTIONS(description="广告成本")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);