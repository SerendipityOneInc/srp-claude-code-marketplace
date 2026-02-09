CREATE TABLE `srpproduct-dc37e.favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d`
(
  dt DATE NOT NULL OPTIONS(description="全量日期"),
  app_name STRING OPTIONS(description="应用名称：Gensmo、Decofy"),
  event_name STRING OPTIONS(description="appsflyer触达的事件名称"),
  appsflyer_id STRING OPTIONS(description="appsflyer_id"),
  source STRING OPTIONS(description="所有触达来源"),
  account_id STRING OPTIONS(description="广告账户ID,如果为非广告信息,则为upper(event_name)"),
  campaign_id STRING OPTIONS(description="广告活动ID,如果为非广告信息,则为upper(event_name)"),
  ad_group_id STRING OPTIONS(description="广告组ID,如果为非广告信息,则为upper(event_name)"),
  ad_id STRING OPTIONS(description="广告ID,如果为非广告信息,则为upper(event_name)"),
  event_order_seq INT64 OPTIONS(description="appsflyer触达的事件顺序,按照时间正序排列"),
  event_dt DATE OPTIONS(description="处理更新时间")
)
PARTITION BY dt
CLUSTER BY app_name, source, event_name
OPTIONS(
  description="appsflyer id与触达信息归因,每天包含全量数据"
);