CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_bysource_metric_inc_1d`
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
  event_name STRING OPTIONS(description="事件名称（select_item、view_item_list 等）"),
  event_method STRING OPTIONS(description="事件触发方式（点击、浏览、摇一摇等）"),
  event_action_type STRING OPTIONS(description="事件行为类型（试穿、无头像试穿等）"),
  event_source STRING OPTIONS(description="refer 与 ap_name 组合的事件来源"),
  cal_pre_refer STRING OPTIONS(description="前一跳来源"),
  cal_pre_refer_ap_name STRING OPTIONS(description="前一跳应用页面名称"),
  cal_pre_event_source STRING OPTIONS(description="前一跳事件来源组合"),
  task_model STRING OPTIONS(description="任务模型类型，来源于 dim_try_on_task_view.gen_type"),
  task_type STRING OPTIONS(description="任务类型，来源于 dim_try_on_task_view.type"),
  home_pv_cnt INT64 OPTIONS(description="主页浏览次数"),
  home_device_id STRING OPTIONS(description="主页事件设备ID"),
  tryon_pv_cnt INT64 OPTIONS(description="试穿页面浏览次数"),
  tryon_device_id STRING OPTIONS(description="试穿事件设备ID"),
  tryon_select_panel_pv_cnt INT64 OPTIONS(description="试穿选择面板浏览次数"),
  tryon_select_panel_confirm_click_cnt INT64 OPTIONS(description="试穿选择面板确认按钮点击次数"),
  tryon_select_panel_device_id STRING OPTIONS(description="试穿选择面板事件设备ID"),
  tryon_gen_panel_pv_cnt INT64 OPTIONS(description="试穿生成面板浏览次数"),
  tryon_gen_panel_pv_cnt_2_0 INT64 OPTIONS(description="试穿生成面板浏览次数2.0"),
  tryon_gen_action_cnt INT64 OPTIONS(description="试穿生成操作次数"),
  tryon_gen_panel_click_cnt INT64 OPTIONS(description="试穿生成面板点击次数"),
  tryon_gen_panel_click_action_through_rate FLOAT64 OPTIONS(description="试穿生成面板点击到操作转化率"),
  tryon_gen_panel_click_pv_through_rate FLOAT64 OPTIONS(description="试穿生成面板点击占浏览量比例"),
  tryon_gen_device_id STRING OPTIONS(description="试穿生成事件设备ID"),
  tryon_complete_pv_cnt INT64 OPTIONS(description="试穿完成页面浏览次数"),
  tryon_complete_device_id STRING OPTIONS(description="试穿完成事件设备ID")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);