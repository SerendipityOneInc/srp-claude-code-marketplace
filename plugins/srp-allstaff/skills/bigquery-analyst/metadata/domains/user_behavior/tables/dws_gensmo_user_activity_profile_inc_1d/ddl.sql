CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_user_activity_profile_inc_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  device_id STRING OPTIONS(description="设备ID，当前活跃设备"),
  appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"),
  user_ids ARRAY<STRING> OPTIONS(description="用户ID列表，包含当天登录的所有用户ID"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型"),
  user_tenure_type STRING OPTIONS(description="用户在职时长类型"),
  user_tenure_segment STRING OPTIONS(description="用户在职时长细分"),
  user_login_type STRING OPTIONS(description="用户登录类型，login表示当天有登录，guest表示当天未登录"),
  user_created_at TIMESTAMP OPTIONS(description="用户创建时间"),
  first_event_timestamp TIMESTAMP OPTIONS(description="首次访问时间"),
  last_event_timestamp TIMESTAMP OPTIONS(description="最近访问时间"),
  geo_address STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称")> OPTIONS(description="地理位置信息"),
  app_info STRUCT<platform STRING OPTIONS(description="平台类型，如iOS、Android、Web等"), app_version STRING OPTIONS(description="应用版本号")> OPTIONS(description="应用信息"),
  user_duration FLOAT64 OPTIONS(description="当天用户总停留时长，单位秒"),
  common_actions ARRAY<STRUCT<action_type STRING OPTIONS(description="行为类型"), action_cnt INT64 OPTIONS(description="行为类型计数")>> OPTIONS(description="当天内的行为类型及计数"),
  key_functions ARRAY<STRUCT<function_type STRING OPTIONS(description="功能类型"), function_cnt INT64 OPTIONS(description="功能类型计数")>> OPTIONS(description="当天内的key功能类型及计数")
)
PARTITION BY dt
OPTIONS(
  description="Gensmo用户活跃行为宽表，聚合用户当天行为类型及关键功能使用情况"
);