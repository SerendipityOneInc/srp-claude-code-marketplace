CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d`
(
  dt DATE NOT NULL,
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="应用版本"),
  geo_country_name STRING OPTIONS(description="国家"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件触发方式"),
  invalid_user_cnt INT64 OPTIONS(description="无效用户数")
)
PARTITION BY dt;