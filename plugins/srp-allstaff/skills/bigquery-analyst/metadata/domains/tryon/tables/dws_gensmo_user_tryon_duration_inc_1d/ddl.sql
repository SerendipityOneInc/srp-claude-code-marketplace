CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_user_tryon_duration_inc_1d`
(
  dt DATE OPTIONS(description="日期；分区"),
  device_id STRING OPTIONS(description="设备ID"),
  tryon_complete_interval INT64 OPTIONS(description="试穿完成时间间隔"),
  user_group STRING OPTIONS(description="用户组"),
  user_tenure_type STRING OPTIONS(description="用户任期类型"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  country_name STRING OPTIONS(description="国家名称"),
  app_version STRING OPTIONS(description="应用版本"),
  platform STRING OPTIONS(description="平台")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);