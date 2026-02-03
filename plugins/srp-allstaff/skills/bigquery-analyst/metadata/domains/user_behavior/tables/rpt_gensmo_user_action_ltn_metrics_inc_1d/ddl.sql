CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_action_ltn_metrics_inc_1d`
(
  dt DATE OPTIONS(description="数据日期"),
  action_type STRING OPTIONS(description="功能类型: e.g., try_on_trigger,try_on_complete etc."),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  platform STRING OPTIONS(description="平台类型，如iOS、Android等"),
  app_version STRING OPTIONS(description="应用版本号"),
  user_login_type STRING OPTIONS(description="用户登录类型：login,guest"),
  user_tenure_segment STRING OPTIONS(description="用户周期细分类型: New User(1 Day)/New User(2-7 Days)/New User(8-30 Days)/Old User"),
  user_tenure_type STRING OPTIONS(description="用户周期类型: New User/Old User"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  user_group STRING OPTIONS(description="用户分组分类"),
  lifetime_days INT64 OPTIONS(description="用户生命周期天数"),
  active_days_cnt INT64 OPTIONS(description="用户活跃天数"),
  active_user_cnt INT64 OPTIONS(description="活跃用户数"),
  group_type STRING OPTIONS(description="数据分组类型")
)
PARTITION BY dt
CLUSTER BY group_type, user_group
OPTIONS(
  require_partition_filter=true,
  description="Gensmo用户生命周期（lifetime）相关指标宽表，统计不同生命周期、分组下的活跃天数、活跃用户数等核心指标"
);