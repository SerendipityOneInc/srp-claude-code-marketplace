CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_earn_points_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  earn_type STRING OPTIONS(description="积分获取方式，如签到、购买等"),
  earn_point_type STRING OPTIONS(description="积分类型，如日常积分、永久积分等"),
  hit_limit_group STRING OPTIONS(description="是否撞线获取积分"),
  earn_points_user_cnt INT64 OPTIONS(description="对应积分类型用户数"),
  earn_ponits_task_cnt INT64 OPTIONS(description="对应积分类型用户获取积分次数"),
  earn_ponits_points_amt INT64 OPTIONS(description="对应积分类型用户获取积分数量")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);