CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_scd2_1d`
(
  scd2_sk STRING NOT NULL OPTIONS(description="系统主键，唯一标识一条记录"),
  start_date DATE OPTIONS(description="SCD2：本条记录生效的起始日期"),
  end_date DATE OPTIONS(description="SCD2：本条记录失效的截止日期，若为9999-12-31表示当前有效"),
  is_current BOOL OPTIONS(description="SCD2：是否为当前最新记录，true为最新，false为历史"),
  updated_at TIMESTAMP OPTIONS(description="更新时间，记录本条变更的最后更新时间"),
  created_at TIMESTAMP OPTIONS(description="创建时间，记录本条变更的创建时间"),
  user_id STRING NOT NULL OPTIONS(description="用户ID，唯一标识"),
  device_ids ARRAY<STRING> OPTIONS(description="历史所有设备ID列表"),
  user_name STRING OPTIONS(description="用户名"),
  user_email STRING OPTIONS(description="用户邮箱"),
  user_type INT64 OPTIONS(description="用户类型：0-未注册，1-注册，2-注销"),
  is_internal_user BOOL OPTIONS(description="是否内部用户"),
  first_access_info STRUCT<device_id STRING OPTIONS(description="设备ID"), appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"), app_info STRUCT<platform STRING OPTIONS(description="平台类型，如iOS、Android、Web等"), app_version STRING>> OPTIONS(description="首次访问信息"),
  last_access_info STRUCT<device_id STRING OPTIONS(description="设备ID"), appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"), access_at TIMESTAMP OPTIONS(description="访问时间"), app_info STRUCT<platform STRING OPTIONS(description="平台类型，如iOS、Android、Web等"), app_version STRING OPTIONS(description="应用版本号")>> OPTIONS(description="最近访问信息"),
  first_geo_address STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称")> OPTIONS(description="账号注册时的地理位置信息"),
  permanent_geo_address STRUCT<geo_continent_name STRING OPTIONS(description="大洲名称"), geo_sub_continent_name STRING OPTIONS(description="次大洲名称"), geo_country_name STRING OPTIONS(description="国家名称"), geo_region_name STRING OPTIONS(description="地区名称"), geo_metro_name STRING OPTIONS(description="都市区名称"), geo_city_name STRING OPTIONS(description="城市名称")> OPTIONS(description="常驻地理位置信息")
)
CLUSTER BY start_date, end_date, is_current
OPTIONS(
  description="Decofy用户账号变更日志明细表，记录用户账号的设备、地理、应用等变更信息。end_date=9999-12-31 表示当前有效记录。"
);