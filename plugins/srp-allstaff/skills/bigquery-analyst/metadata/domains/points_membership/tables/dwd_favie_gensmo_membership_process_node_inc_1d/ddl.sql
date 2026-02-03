CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_membership_process_node_inc_1d`
(
  dt DATE OPTIONS(description="数据日期，事件发生的日期"),
  user_id STRING OPTIONS(description="用户ID，已登录用户的唯一标识"),
  device_id STRING OPTIONS(description="设备ID，设备的唯一标识符"),
  process_node_id STRING OPTIONS(description="会员流程节点ID，唯一标识每个流程节点"),
  process_node_name STRING OPTIONS(description="会员流程节点，如注册、赚取积分、消耗积分等"),
  process_node_type STRING OPTIONS(description="节点类型，赚取积分类型，消耗积分类型等"),
  process_node_status STRING OPTIONS(description="节点状态，如成功、失败等"),
  process_node_time TIMESTAMP OPTIONS(description="节点发生时间"),
  process_node_points INT64 OPTIONS(description="节点涉及的积分数值"),
  process_node_point_type STRING OPTIONS(description="积分类型，如Daily积分、永久积分"),
  earn_seq INT64 OPTIONS(description="赚取积分节点序列号/顺序"),
  earn_group STRING OPTIONS(description="赚取积分分组标识")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);