CREATE TABLE `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  user_group STRING OPTIONS(description="用户分组分类"),
  device_id STRING OPTIONS(description="设备唯一标识"),
  earn_type STRING OPTIONS(description="积分获取方式，如签到、购买等（process_node_type）"),
  earn_point_type STRING OPTIONS(description="积分类型，如日常积分、永久积分等（含 checkin 为 daily_points，其余为 permanent_points）"),
  hit_limit_group STRING OPTIONS(description="是否撞线获取积分（hit_limit / not_hit_limit）"),
  earn_points_user_cnt INT64 OPTIONS(description="对应积分类型用户标识，用户有上述获取积分行为的记为1，否则为0"),
  earn_ponits_task_cnt INT64 OPTIONS(description="对应积分类型用户获取积分次数，对符合上述维度组合的，对process_node_id计数"),
  earn_ponits_points_amt INT64 OPTIONS(description="对应积分类型用户获取积分数量，对符合上述维度组合的，对process_node_points求和")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);