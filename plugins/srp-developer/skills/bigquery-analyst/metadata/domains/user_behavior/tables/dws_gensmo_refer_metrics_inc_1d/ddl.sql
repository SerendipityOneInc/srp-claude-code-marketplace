CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_group STRING OPTIONS(description="用户分组分类"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  device_id STRING OPTIONS(description="设备唯一标识"),
  ap_name STRING OPTIONS(description="交互点名称"),
  refer STRING OPTIONS(description="跳转至当前页面的来源页面或入口"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件触发方式（点击、浏览等）"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  refer_ap_click_cnt INT64 OPTIONS(description="来源页面交互点击次数,这里的点击是宽泛的概念，包含event_method in ('click','shake','swipe','screenshot')四种事件"),
  refer_pv_cnt INT64 OPTIONS(description="来源页面浏览次数"),
  refer_leave_directly_cnt INT64 OPTIONS(description="来源页面直接离开次数,页面展示后没有任何交互事件（'click','shake','swipe','screenshot'）就离开的次数"),
  refer_duration_amount FLOAT64 OPTIONS(description="来源页面停留时长，单位：毫秒，报表请转化为秒进行展示"),
  refer_click_device_id STRING OPTIONS(description="来源页面点击设备ID，如果refer_ap_click_cnt>0则是device_id,否则为null"),
  refer_directly_leave_device_id STRING OPTIONS(description="来源页面直接离开设备ID，如果refer_directly_leave_device_id>0则是device_id,否则为null"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_group_id STRING OPTIONS(description="广告组ID"),
  ad_campaign_id STRING OPTIONS(description="广告活动ID"),
  ad_id STRING OPTIONS(description="广告ID"),
  refer_backend_cnt INT64 OPTIONS(description="来源页面非交互点击次数,这里的非交互点击是指event_method not in ('click','shake','swipe','screenshot')的其他事件"),
  refer_backend_device_id STRING OPTIONS(description="来源页面非交互点击设备ID，如果refer_backend_cnt>0则是device_id,否则为null")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);