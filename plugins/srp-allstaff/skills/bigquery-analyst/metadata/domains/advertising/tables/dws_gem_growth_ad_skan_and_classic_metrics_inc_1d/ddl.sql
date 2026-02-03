CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d`
(
  dt DATE NOT NULL OPTIONS(description="数据日期"),
  source STRING OPTIONS(description="广告来源：Meta Ads、Google Ads、TikTok Ads等"),
  platform STRING OPTIONS(description="平台：IOS、ANDROID"),
  app_name STRING OPTIONS(description="应用名称：Gensmo"),
  account_id STRING OPTIONS(description="广告账户ID"),
  account_name STRING OPTIONS(description="广告账户名称"),
  campaign_id STRING OPTIONS(description="广告活动ID"),
  campaign_name STRING OPTIONS(description="广告活动名称"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_group_name STRING OPTIONS(description="广告组名称"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_name STRING OPTIONS(description="广告名称"),
  ad_category STRING OPTIONS(description="广告类别"),
  country_code STRING OPTIONS(description="国家代码"),
  channel STRING OPTIONS(description="渠道：ON_LINE、SKAN"),
  attribution_method STRING OPTIONS(description="归因方法：SKAN、CLASSIC、BOTH"),
  account_put_type STRING OPTIONS(description="账户投放类型"),
  account_open_agency STRING OPTIONS(description="账户开户代理"),
  impression FLOAT64 OPTIONS(description="曝光数"),
  click FLOAT64 OPTIONS(description="点击数"),
  conversion FLOAT64 OPTIONS(description="转化数"),
  cost FLOAT64 OPTIONS(description="花费"),
  install_cnt FLOAT64 OPTIONS(description="安装数"),
  new_user_cnt FLOAT64 OPTIONS(description="新用户数"),
  d0_active_cnt FLOAT64 OPTIONS(description="D0活跃用户数"),
  d1_retention_cnt FLOAT64 OPTIONS(description="D1留存用户数"),
  lt7_cnt FLOAT64 OPTIONS(description="LT7（7天生命周期价值）用户数")
)
PARTITION BY dt
CLUSTER BY source, platform, attribution_method
OPTIONS(
  description="Gensmo广告SKAN和Classic归因指标增量表，包含广告花费、转化、用户行为等指标"
);