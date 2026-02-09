CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gem_user_dimension_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  last_platform STRING OPTIONS(description="用户当日使用最多的平台"),
  last_app_version STRING OPTIONS(description="用户当日使用最多的app版本号"),
  country STRING OPTIONS(description="用户30日内最常使用所在国家"),
  last_login_type STRING OPTIONS(description="是否登录用户"),
  user_type STRING OPTIONS(description="是否注册用户"),
  total_user_cnt INT64 OPTIONS(description="总用户数"),
  new_user_cnt INT64 OPTIONS(description="新增用户数"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数"),
  active_user_d7_cnt INT64 OPTIONS(description="周活跃用户数"),
  active_user_d30_cnt INT64 OPTIONS(description="月活跃用户数"),
  retention_users FLOAT64 OPTIONS(description="前一日用户留存数"),
  yesterday_new_users INT64 OPTIONS(description="前一日新增用户数"),
  total_duration FLOAT64 OPTIONS(description="总停留时长"),
  duration_0_05_percentile FLOAT64 OPTIONS(description="停留时长的百分之五分位数"),
  duration_0_25_percentile FLOAT64 OPTIONS(description="停留时长的百分之二十五分位数"),
  duration_0_50_percentile FLOAT64 OPTIONS(description="停留时长的百分之五十分位数"),
  duration_0_75_percentile FLOAT64 OPTIONS(description="停留时长的百分之七十五分位数"),
  duration_0_95_percentile FLOAT64 OPTIONS(description="停留时长的百分之九十五分位数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);