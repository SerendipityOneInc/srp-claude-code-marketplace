CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_faive_gensmo_membership_points_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  active_user_1d_cnt INT64 OPTIONS(description="当日活跃用户数（DAU）"),
  login_user_1d_cnt INT64 OPTIONS(description="当日登录用户数"),
  earn_points_user_cnt INT64 OPTIONS(description="获取过积分行为的用户数"),
  earn_points_task_cnt INT64 OPTIONS(description="获取积分次数"),
  earn_points_points_amt INT64 OPTIONS(description="获取积分数量"),
  earn_points_not_checkin_user_cnt INT64 OPTIONS(description="通过主动完成任务获取积分行为的用户数（不含被动checkin）"),
  earn_points_not_checkin_task_cnt INT64 OPTIONS(description="通过主动完成任务获取积分次数（不含被动checkin）"),
  earn_points_not_checkin_points_amt INT64 OPTIONS(description="通过主动完成任务获取积分数量（不含被动checkin）"),
  earn_points_transaction_user_cnt INT64 OPTIONS(description="通过充值获取积分行为的用户数"),
  earn_points_transaction_task_cnt INT64 OPTIONS(description="通过充值获取积分次数"),
  earn_points_transaction_points_amt INT64 OPTIONS(description="通过充值获取积分数量"),
  consume_points_user_cnt INT64 OPTIONS(description="消耗过积分行为的用户数"),
  consume_points_task_cnt INT64 OPTIONS(description="消耗积分次数"),
  consume_points_points_amt INT64 OPTIONS(description="消耗积分数量"),
  net_points_change INT64 OPTIONS(description="净积分流=当日获取积分-当日消耗积分"),
  consume_points_ge_task_claimed_user_cnt INT64 OPTIONS(description="用户当日消耗积分大于等于完成daily任务可获取的积分上限（当前固定13分）的用户数"),
  consume_points_ge_checkin_user_cnt INT64 OPTIONS(description="用户当日消耗积分大于等于每日登录可获取积分（当前固定10分）的用户数"),
  hit_limit_user_cnt INT64 OPTIONS(description="撞线用户数"),
  points_expired INT64 OPTIONS(description="当日到期扣除积分（=当日daily积分获取-当日消耗积分）")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);