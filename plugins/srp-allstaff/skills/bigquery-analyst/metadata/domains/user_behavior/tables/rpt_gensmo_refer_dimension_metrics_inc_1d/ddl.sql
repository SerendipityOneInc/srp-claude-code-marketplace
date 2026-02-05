CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_refer_dimension_metrics_inc_1d`
(
  refer STRING OPTIONS(description="来源"),
  pre_refer STRING OPTIONS(description="上级来源"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="app版本"),
  native_version STRING OPTIONS(description="native版本"),
  pv INT64 OPTIONS(description="页面浏览数"),
  uv INT64 OPTIONS(description="页面访客数"),
  duration FLOAT64 OPTIONS(description="页面停留时长"),
  dt DATE OPTIONS(description="分区，日期")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);