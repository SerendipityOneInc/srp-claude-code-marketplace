CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_user_forward_tracking_inc_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  device_id STRING OPTIONS(description="设备ID，当前活跃设备"),
  appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型"),
  user_tenure_type STRING OPTIONS(description="用户在职时长类型"),
  user_tenure_segment STRING OPTIONS(description="用户在职时长细分"),
  user_login_type STRING OPTIONS(description="用户登录类型，login表示当天有登录，guest表示当天未登录"),
  user_created_at TIMESTAMP OPTIONS(description="创建时间"),
  tracking_period INT64 OPTIONS(description="追踪期，单位天"),
  user_duration FLOAT64 OPTIONS(description="当天用户总停留时长，单位秒"),
  common_actions_1d ARRAY<STRUCT<action_type STRING OPTIONS(description="行为类型"), action_cnt INT64 OPTIONS(description="行为类型计数")>> OPTIONS(description="当天内的行为类型及计数"),
  common_actions_xd ARRAY<STRUCT<action_type STRING OPTIONS(description="行为类型"), action_cnt INT64 OPTIONS(description="行为类型计数")>> OPTIONS(description="未来X天内的行为类型及计数"),
  active_dates ARRAY<DATE> OPTIONS(description="用户未来观察期内的活跃日期列表")
)
PARTITION BY dt
CLUSTER BY tracking_period
OPTIONS(
  description="Gensmo新增用户行为追踪宽表，聚合用户当天、未来X天行为类型及关键功能使用情况"
);