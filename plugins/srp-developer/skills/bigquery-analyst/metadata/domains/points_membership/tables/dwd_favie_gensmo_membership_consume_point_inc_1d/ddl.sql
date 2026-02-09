CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_consume_point_inc_1d`
(
  dt DATE OPTIONS(description="数据日期，表示事件发生的日期"),
  user_id STRING OPTIONS(description="用户ID，已登录用户的唯一标识符"),
  device_id STRING OPTIONS(description="设备ID，设备的唯一标识符"),
  consume_id STRING OPTIONS(description="积分消耗记录ID"),
  consume_type STRING OPTIONS(description="积分消耗类型，Tryon、video等"),
  consume_points INT64 OPTIONS(description="消耗的积分总数"),
  consume_status STRING OPTIONS(description="积分消耗状态，如成功、失败等"),
  consume_time TIMESTAMP OPTIONS(description="积分消耗时间戳")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);