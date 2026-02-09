CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_feature_inc_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  user_id STRING OPTIONS(description="用户ID"),
  first_device_id STRING OPTIONS(description="首次登录设备ID"),
  first_appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型，如register、unregister、deregister"),
  user_tenure_type STRING OPTIONS(description="用户生命周期类型，如new、active、expired"),
  created_at TIMESTAMP OPTIONS(description="用户创建时间"),
  last_day_feature STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称"), access_at TIMESTAMP OPTIONS(description="最近访问时间"), login_type STRING OPTIONS(description="最近登录类型"), duration FLOAT64 OPTIONS(description="最近活跃时长（秒）"), platform STRING OPTIONS(description="最近访问平台类型"), app_version STRING OPTIONS(description="最近访问应用版本"), event_actions ARRAY<STRUCT<action_type STRING OPTIONS(description="行为类型"), action_cnt INT64 OPTIONS(description="行为次数")>> OPTIONS(description="最近1天内的行为类型集合"), appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"), device_id STRING OPTIONS(description="设备ID，当前活跃设备")> OPTIONS(description="最近一天用户特征"),
  last_30_days_feature STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称"), event_actions ARRAY<STRUCT<action_type STRING OPTIONS(description="行为类型"), action_cnt INT64 OPTIONS(description="行为次数")>> OPTIONS(description="最近30天内的行为类型集合")> OPTIONS(description="最近30天用户特征")
)
PARTITION BY dt
OPTIONS(
  description="Decofy用户特征宽表，聚合用户近一天与近30天的地理、活跃、行为等特征信息"
);