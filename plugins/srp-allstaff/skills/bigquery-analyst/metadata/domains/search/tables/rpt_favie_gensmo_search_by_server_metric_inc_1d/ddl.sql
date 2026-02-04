CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（登陆，未登陆）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  collage_server_complete_task_cnt INT64 OPTIONS(description="搜索服务端完成Item数"),
  collage_server_complete_user_cnt INT64 OPTIONS(description="搜索服务端完成访问用户数")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);