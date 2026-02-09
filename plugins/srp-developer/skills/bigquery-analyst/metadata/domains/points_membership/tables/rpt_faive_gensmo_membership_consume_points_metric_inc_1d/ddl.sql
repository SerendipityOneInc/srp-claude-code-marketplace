CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_consume_points_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  consume_type STRING OPTIONS(description="积分消耗类型，Tryon、video等"),
  consume_points_user_cnt INT64 OPTIONS(description="对应积分类型用户数"),
  consume_ponits_task_cnt INT64 OPTIONS(description="对应积分类型用户消耗积分次数"),
  consume_ponits_points_amt INT64 OPTIONS(description="对应积分类型用户消耗积分数量")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);