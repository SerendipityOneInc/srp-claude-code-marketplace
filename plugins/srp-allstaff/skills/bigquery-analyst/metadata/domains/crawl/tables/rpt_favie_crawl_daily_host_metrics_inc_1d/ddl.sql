CREATE TABLE `srpproduct-dc37e.favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d`
(
  dt DATE,
  host STRING,
  success_cnt INT64,
  failed_cnt INT64,
  duplicate_cnt INT64,
  not_found_cnt INT64,
  delisted_cnt INT64,
  parse_failed_cnt INT64,
  total_cnt INT64
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);