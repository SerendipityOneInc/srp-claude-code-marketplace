CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  user_group STRING OPTIONS(description="分组名称"),
  device_id STRING OPTIONS(description="设备ID"),
  appsflyer_id STRING OPTIONS(description="Appsflyer追踪ID"),
  user_activity_type STRING OPTIONS(description="用户活跃类型：active, inactive"),
  country_name STRING OPTIONS(description="国家名称"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="应用版本"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_segment STRING OPTIONS(description="用户周期细分类型: New User(1 Day)/New User(2-7 Days)/New User(8-30 Days)/Old User"),
  user_tenure_type STRING OPTIONS(description="用户周期类型: New User/Old User"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  group_type STRING OPTIONS(description="数据类型：prod_data, temp_data")
)
PARTITION BY dt
CLUSTER BY group_type, user_group
OPTIONS(
  require_partition_filter=true
);