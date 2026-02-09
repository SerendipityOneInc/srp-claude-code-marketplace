CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_user_avatar_duration_inc_1d`
(
  dt DATE OPTIONS(description="日期"),
  device_id STRING OPTIONS(description="用户设备id"),
  avatar_task_interval INT64 OPTIONS(description="用户从登陆到完成avatar创建的时间间隔"),
  user_group STRING OPTIONS(description="用户组"),
  user_tenure_type STRING OPTIONS(description="用户新老类型"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  country_name STRING OPTIONS(description="国家名称"),
  app_version STRING OPTIONS(description="应用版本"),
  platform STRING OPTIONS(description="平台")
);