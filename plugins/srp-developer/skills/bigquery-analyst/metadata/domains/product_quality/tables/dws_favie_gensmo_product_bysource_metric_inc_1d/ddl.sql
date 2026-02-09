CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_product_bysource_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  user_group STRING OPTIONS(description="用户分组分类"),
  device_id STRING OPTIONS(description="设备唯一标识"),
  refer STRING OPTIONS(description="页面名称"),
  cal_pre_refer STRING OPTIONS(description="前一跳来源页面"),
  ap_name STRING OPTIONS(description="交互点名称"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件触发方式（点击、浏览等）"),
  product_external_jump_click_cnt INT64 OPTIONS(description="商品外部跳转点击次数"),
  product_external_jump_click_device_id STRING OPTIONS(description="商品外部跳转事件设备ID"),
  product_detail_pv_cnt INT64 OPTIONS(description="商品详情卡片浏览次数"),
  product_detail_pv_device_id STRING OPTIONS(description="商品详情卡片浏览设备ID")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);