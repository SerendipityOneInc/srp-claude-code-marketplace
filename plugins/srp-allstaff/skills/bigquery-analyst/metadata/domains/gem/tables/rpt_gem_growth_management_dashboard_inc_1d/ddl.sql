CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gem_growth_management_dashboard_inc_1d`
(
  dt DATE OPTIONS(description="分区字段"),
  media_source STRING OPTIONS(description="媒体归一化名称"),
  platform STRING OPTIONS(description="苹果/安卓"),
  app_name STRING OPTIONS(description="应用名称"),
  account_id STRING OPTIONS(description="账户ID"),
  account_name STRING OPTIONS(description="账户名称"),
  campaign_id STRING OPTIONS(description="Campaign ID"),
  campaign_name STRING OPTIONS(description="Campaign名称"),
  ad_group_id STRING OPTIONS(description="Ad Group ID"),
  ad_group_name STRING OPTIONS(description="Ad Group名称"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_name STRING OPTIONS(description="广告名称"),
  country_code STRING OPTIONS(description="国家代码"),
  finest_ad_class_id STRING OPTIONS(description="最细广告分组ID"),
  ad_media_source STRING OPTIONS(description="广告媒体来源"),
  af_media_source STRING OPTIONS(description="归因媒体来源"),
  spend FLOAT64 OPTIONS(description="广告花费"),
  impressions INT64 OPTIONS(description="曝光数"),
  clicks INT64 OPTIONS(description="点击数"),
  ad_conversions FLOAT64 OPTIONS(description="广告转化数"),
  install_cnt INT64 OPTIONS(description="安装数"),
  new_user_cnt INT64 OPTIONS(description="新用户数"),
  d0_active_cnt INT64 OPTIONS(description="D0活跃数"),
  d1_retention_cnt INT64 OPTIONS(description="D1留存数"),
  lt7_cnt INT64 OPTIONS(description="近7天活跃天数")
)
PARTITION BY dt;