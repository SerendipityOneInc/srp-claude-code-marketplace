CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型，如手机号、微信授权等"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数"),
  tryon_trigger_cnt INT64 OPTIONS(description="试穿触发次数"),
  tryon_trigger_user_cnt INT64 OPTIONS(description="试穿页面访问用户数"),
  tryon_request_cnt INT64 OPTIONS(description="试穿请求次数"),
  tryon_request_user_cnt INT64 OPTIONS(description="试穿请求用户数"),
  tryon_complete_succeed_user_cnt INT64 OPTIONS(description="试穿完成用户数"),
  tryon_complete_fail_user_cnt INT64 OPTIONS(description="试穿失败用户数"),
  tryon_complete_user_cnt INT64 OPTIONS(description="试穿完成用户数"),
  tryon_load_succeed_task_cnt INT64 OPTIONS(description="试穿加载成功任务数"),
  tryon_load_succeed_user_cnt INT64 OPTIONS(description="试穿加载成功用户数"),
  tryon_load_fail_task_cnt INT64 OPTIONS(description="试穿加载失败任务数"),
  tryon_load_fail_user_cnt INT64 OPTIONS(description="试穿加载失败用户数"),
  tryon_view_detail_task_cnt INT64 OPTIONS(description="试穿查看详情次数"),
  tryon_view_detail_user_cnt INT64 OPTIONS(description="试穿查看详情用户数"),
  tryon_complete_succeed_task_cnt INT64 OPTIONS(description="试穿完成任务数"),
  tryon_complete_fail_task_cnt INT64 OPTIONS(description="试穿失败任务数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);