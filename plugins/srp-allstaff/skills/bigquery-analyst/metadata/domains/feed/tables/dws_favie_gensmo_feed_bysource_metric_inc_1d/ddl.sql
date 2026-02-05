CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_feed_bysource_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  user_group STRING OPTIONS(description="用户分组分类"),
  device_id STRING OPTIONS(description="设备唯一标识"),
  refer STRING OPTIONS(description="跳转至当前页面的来源页面或入口"),
  ap_name STRING OPTIONS(description="交互点名称"),
  event_name STRING OPTIONS(description="事件名称"),
  event_method STRING OPTIONS(description="事件触发方式（点击、浏览等）"),
  event_action_type STRING OPTIONS(description="事件行为类型"),
  event_source STRING OPTIONS(description="事件来源组合"),
  item_type STRING OPTIONS(description="内容项类型"),
  item_intention STRING OPTIONS(description="内容项意图"),
  feed_source STRING OPTIONS(description="信息流来源"),
  home_pv_cnt INT64 OPTIONS(description="主页浏览次数"),
  home_device_id STRING OPTIONS(description="主页事件设备ID"),
  feed_item_list_pv_cnt INT64 OPTIONS(description="信息流列表浏览次数"),
  feed_item_list_device_id STRING OPTIONS(description="信息流列表事件设备ID"),
  feed_item_view_pv_cnt INT64 OPTIONS(description="信息流内容浏览次数"),
  feed_item_view_device_id STRING OPTIONS(description="信息流内容浏览事件设备ID"),
  feed_item_click_cnt INT64 OPTIONS(description="信息流内容点击次数"),
  feed_item_click_device_id STRING OPTIONS(description="信息流内容点击事件设备ID"),
  feed_detail_click_cnt INT64 OPTIONS(description="信息流详情点击次数"),
  feed_item_tryon_click_cnt INT64 OPTIONS(description="信息流试穿点击次数"),
  feed_item_remix_click_cnt INT64 OPTIONS(description="信息流重混合点击次数"),
  feed_item_save_share_click_cnt INT64 OPTIONS(description="信息流保存分享点击次数"),
  feed_item_product_click_cnt INT64 OPTIONS(description="信息流商品点击次数"),
  feed_item_detail_pv_cnt INT64 OPTIONS(description="信息流详情浏览次数"),
  feed_item_detail_click_device_id STRING OPTIONS(description="信息流详情点击事件设备ID"),
  feed_product_detail_click_cnt INT64 OPTIONS(description="信息流商品详情点击次数"),
  feed_product_detail_pv_cnt INT64 OPTIONS(description="信息流商品详情浏览次数"),
  feed_product_detail_device_id STRING OPTIONS(description="信息流商品详情事件设备ID")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);