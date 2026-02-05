CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_earn_point_inc_1d`
(
  dt DATE OPTIONS(description="数据日期，表示事件发生的日期"),
  user_id STRING OPTIONS(description="用户ID，已登录用户的唯一标识符"),
  device_id STRING OPTIONS(description="设备ID，设备的唯一标识符"),
  earn_id STRING OPTIONS(description="积分获取记录ID"),
  earn_type STRING OPTIONS(description="积分获取方式，如签到、购买等"),
  earn_point_type STRING OPTIONS(description="积分类型，如日常积分、永久积分等"),
  earn_points INT64 OPTIONS(description="获取的积分总数"),
  earn_time TIMESTAMP OPTIONS(description="积分获取时间戳")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);