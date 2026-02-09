CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_user_last_access_full_1d`
(
  last_access_date DATE OPTIONS(description="用户最后访问日期"),
  device_id STRING OPTIONS(description="设备ID，当前活跃设备"),
  first_device_id STRING OPTIONS(description="首次登录设备ID"),
  appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型，如register、unregister、deregister"),
  user_tenure_type STRING OPTIONS(description="用户生命周期类型，如new、old"),
  created_at TIMESTAMP OPTIONS(description="用户创建时间"),
  last_day_feature STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称"), appsflyer_id STRING OPTIONS(description="当天最新的Appsflyer追踪ID"), access_at TIMESTAMP OPTIONS(description="最近访问时间"), login_type STRING OPTIONS(description="最近登录类型"), duration FLOAT64 OPTIONS(description="最近活跃时长（秒）"), platform STRING OPTIONS(description="最近访问平台类型"), app_version STRING OPTIONS(description="最近访问应用版本"), action_types ARRAY<STRING> OPTIONS(description="最近一天内的行为类型集合"), action_types_with_count ARRAY<STRUCT<event_action_type STRING OPTIONS(description="行为类型"), event_action_type_count INT64 OPTIONS(description="行为类型计数")>> OPTIONS(description="最近一天内的行为类型及计数")> OPTIONS(description="最后一次访问当天的用户特征"),
  last_30_days_feature STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称"), action_types ARRAY<STRING> OPTIONS(description="最近30天内的行为类型集合"), action_types_with_count ARRAY<STRUCT<event_action_type STRING OPTIONS(description="行为类型"), event_action_type_count INT64 OPTIONS(description="行为类型计数")>> OPTIONS(description="最近30天内的行为类型及计数")> OPTIONS(description="最后一次访问时的30天用户特征"),
  updated_at TIMESTAMP OPTIONS(description="记录更新时间")
)
CLUSTER BY device_id
OPTIONS(
  description="Gensmo用户最后访问信息表，记录每个用户最后一次访问的日期及当时的完整用户特征，用于用户活跃度分析、流失用户识别和用户画像分析"
);