CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_webpage_comment_metric_full_1w`
(
  domain STRING,
  total_webpage_comment_num INT64,
  weekly_new_webpage_comment_num INT64,
  weekly_update_webpage_comment_num INT64,
  dt DATE
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true,
  description="网页指标全量周表"
);