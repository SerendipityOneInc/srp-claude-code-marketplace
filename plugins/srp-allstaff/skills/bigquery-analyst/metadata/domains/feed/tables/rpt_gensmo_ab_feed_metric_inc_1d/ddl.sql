CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  user_tenure_type STRING OPTIONS(description="用户新老类型"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  country_name STRING OPTIONS(description="国家"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="应用版本"),
  ab_project_name STRING OPTIONS(description="实验名"),
  ab_router_id STRING OPTIONS(description="分组id"),
  ab_router_name STRING OPTIONS(description="分组名称"),
  content_consumption_pv_cnt INT64 OPTIONS(description="内容消费PV数"),
  feed_stay_interval_total_cnt FLOAT64 OPTIONS(description="feed_detail和home停留总时长"),
  feed_true_view_pv_cnt INT64 OPTIONS(description="Feed真实曝光PV数"),
  content_consumption_user_cnt INT64 OPTIONS(description="从首页进入feed详情页的用户数"),
  feed_stay_user_cnt INT64 OPTIONS(description="停留在feed_detail和home页的用户数"),
  feed_true_view_user_cnt INT64 OPTIONS(description="feed真实曝光的用户数"),
  refer STRING OPTIONS(description="来源")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);