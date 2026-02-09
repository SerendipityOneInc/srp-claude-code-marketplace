CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_feed_metric_byuser_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区"),
  device_id STRING OPTIONS(description="设备id"),
  user_tenure_type STRING OPTIONS(description="用户新老类型"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  country_name STRING OPTIONS(description="国家名"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="app版本"),
  ab_project_name STRING OPTIONS(description="ab实验名称"),
  ab_router_id STRING OPTIONS(description="ab分组id"),
  ab_router_name STRING OPTIONS(description="ab分组名称"),
  user_feed_stay_interval FLOAT64 OPTIONS(description="用户feed_detail和home页停留总时长"),
  user_feed_true_view INT64 OPTIONS(description="用户feed_detail的真实曝光数"),
  user_content_consumption INT64 OPTIONS(description="用户内容消费数"),
  user_ctr FLOAT64 OPTIONS(description="用户点击率"),
  refer STRING OPTIONS(description="来源")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);