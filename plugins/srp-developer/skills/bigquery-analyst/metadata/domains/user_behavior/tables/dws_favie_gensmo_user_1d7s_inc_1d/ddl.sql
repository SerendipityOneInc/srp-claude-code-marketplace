CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_1d7s_inc_1d`
(
  base_dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  user_login_type STRING OPTIONS(description="用户登录类型（登陆、未登陆）"),
  platform STRING,
  app_version STRING,
  function_type STRING OPTIONS(description="用户回访深度行为类型"),
  active_user_cnt INT64 OPTIONS(description="基准日活跃数"),
  revisit_user_cnt INT64 OPTIONS(description="至少 1 次回访数")
)
PARTITION BY base_dt
OPTIONS(
  require_partition_filter=true
);