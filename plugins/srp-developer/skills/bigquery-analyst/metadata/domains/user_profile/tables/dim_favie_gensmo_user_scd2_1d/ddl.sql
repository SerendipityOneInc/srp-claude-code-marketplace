CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_scd2_1d`
(
  scd2_sk STRING NOT NULL OPTIONS(description="系统主键，唯一标识一条记录"),
  start_date DATE OPTIONS(description="SCD2：本条记录生效的起始日期"),
  end_date DATE OPTIONS(description="SCD2：本条记录失效的截止日期，若为9999-12-31表示当前有效"),
  is_current BOOL OPTIONS(description="SCD2：是否为当前最新记录，true为最新，false为历史"),
  created_at TIMESTAMP OPTIONS(description="创建时间，记录本条变更的创建时间"),
  device_id STRING OPTIONS(description="设备ID"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  user_type STRING OPTIONS(description="用户类型: 未注册-unregistered,注册-registered,注销-deregistered"),
  user_accounts ARRAY<STRUCT<user_id STRING OPTIONS(description="用户ID"), user_type INT64 OPTIONS(description="0:unregistered,1:registered,2:deregistered")>> OPTIONS(description="关联的账号列表"),
  first_access_info STRUCT<appsflyer_id STRING OPTIONS(description="首次访问时的Appsflyer ID"), app_info STRUCT<platform STRING OPTIONS(description="平台类型，如iOS、Android、Web等"), app_version STRING OPTIONS(description="应用版本号")> OPTIONS(description="应用信息")>,
  last_access_info STRUCT<appsflyer_id STRING OPTIONS(description="最近访问时的Appsflyer ID"), access_at TIMESTAMP OPTIONS(description="最近访问时间"), login_at TIMESTAMP OPTIONS(description="最近登录时间"), app_info STRUCT<platform STRING OPTIONS(description="平台类型，如iOS、Android、Web等"), app_version STRING OPTIONS(description="应用版本号")> OPTIONS(description="应用信息")> OPTIONS(description="最近访问和登录信息"),
  first_geo_address STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称")> OPTIONS(description="首次地理位置信息"),
  permanent_geo_address STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称")> OPTIONS(description="常驻地理位置信息"),
  scd2_created_at TIMESTAMP OPTIONS(description="SCD2：记录本条变更的创建时间"),
  scd2_updated_at TIMESTAMP OPTIONS(description="记录本条变更的处理时间")
)
CLUSTER BY start_date, end_date, is_current
OPTIONS(
  description="Gensmo用户变更日志明细表，记录用户的账号信息，地理位置信息，访问信息等的变化，is_current=True 表示当前有效记录。"
);