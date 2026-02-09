CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_try_on_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  user_tenure_type STRING OPTIONS(description="是否新用户"),
  user_country_name STRING OPTIONS(description="用户30日内最常使用所在国家"),
  platform STRING OPTIONS(description="用户当日使用最多的平台"),
  app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  try_on_complete_d1_cnt INT64 OPTIONS(description="日完成TryOn次数"),
  try_on_complete_user_d1_cnt INT64 OPTIONS(description="日完成TryOn用户数"),
  try_on_d1_cnt INT64 OPTIONS(description="日发起TryOn次数"),
  try_on_user_d1_cnt INT64 OPTIONS(description="日发起TryOn用户数"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);