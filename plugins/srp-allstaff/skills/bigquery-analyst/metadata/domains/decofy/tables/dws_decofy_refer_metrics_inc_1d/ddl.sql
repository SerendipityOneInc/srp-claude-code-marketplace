CREATE TABLE `srpproduct-dc37e.favie_dw.dws_decofy_refer_metrics_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  user_id STRING OPTIONS(description="用户ID"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_group STRING OPTIONS(description="用户分组分类"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  appsflyer_id STRING OPTIONS(description="Appsflyer ID"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_id STRING OPTIONS(description="广告ID"),
  ap_name STRING OPTIONS(description="交互点名称"),
  refer STRING OPTIONS(description="跳转至当前页面的来源页面或入口"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件触发方式（点击、浏览等）"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  refer_ap_click_cnt INT64 OPTIONS(description="来源页面交互点击次数"),
  refer_pv_cnt INT64 OPTIONS(description="来源页面浏览次数"),
  refer_view_item_list_cnt INT64 OPTIONS(description="来源页面查看Item列表次数"),
  refer_true_view_cnt INT64 OPTIONS(description="商品详情页查看次数"),
  refer_leave_directly_cnt INT64 OPTIONS(description="来源页面直接离开次数"),
  refer_duration_amount FLOAT64 OPTIONS(description="来源页面停留时长"),
  refer_click_user_id STRING OPTIONS(description="来源页面点击用户ID"),
  refer_directly_leave_user_id STRING OPTIONS(description="来源页面直接离开用户ID")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);