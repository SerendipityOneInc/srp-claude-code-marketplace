CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_new`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（login、guest等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数"),
  home_pv_cnt INT64 OPTIONS(description="主页页面浏览量"),
  home_user_cnt INT64 OPTIONS(description="主页访问用户数"),
  collage_intention_cnt INT64 OPTIONS(description="搜索页面浏览量"),
  collage_intention_user_cnt INT64 OPTIONS(description="搜索页面访问用户数"),
  search_boot_panel_pv_cnt INT64 OPTIONS(description="搜索选择面板页面浏览量"),
  search_boot_panel_generate_click_cnt INT64 OPTIONS(description="搜索选择面板确认按钮点击次数"),
  search_boot_panel_user_cnt INT64 OPTIONS(description="搜索选择面板访问用户数"),
  collage_gen_action_cnt INT64 OPTIONS(description="发起搜索操作次数"),
  collage_gen_action_user_cnt INT64 OPTIONS(description="发起搜索操作用户数"),
  collage_gen_action_cnt_2_0 INT64 OPTIONS(description="发起搜索操作次数2.0"),
  collage_gen_action_user_cnt_2_0 INT64 OPTIONS(description="发起搜索操作用户数2.0"),
  collage_server_complete_task_cnt INT64 OPTIONS(description="搜索服务端完成Item数"),
  collage_server_complete_user_cnt INT64 OPTIONS(description="搜索服务端完成访问用户数"),
  collage_complete_cnt INT64 OPTIONS(description="搜索完成次数"),
  collage_complete_user_cnt INT64 OPTIONS(description="搜索完成用户数"),
  collage_channel_click_cnt INT64 OPTIONS(description="搜索完成渠道页点击次数"),
  collage_channel_click_user_cnt INT64 OPTIONS(description="搜索完成渠道页点击用户数"),
  collage_complete_detail_task_cnt INT64 OPTIONS(description="搜索完成详情任务次数"),
  collage_complete_detail_user_cnt INT64 OPTIONS(description="搜索完成详情用户数"),
  collage_gen_panel_pv_cnt INT64 OPTIONS(description="搜索生成面板浏览量"),
  collage_gen_panel_click_cnt INT64 OPTIONS(description="搜索生成面板点击次数"),
  collage_gen_panel_user_cnt INT64 OPTIONS(description="搜索生成面板用户数"),
  search_result_product_click_cnt INT64 OPTIONS(description="搜索结果商品点击次数"),
  search_result_positive_cnt INT64 OPTIONS(description="搜索结果正反馈次数"),
  channel_collage_click_cnt INT64 OPTIONS(description="频道拼贴点击次数"),
  channel_screen_cnt INT64 OPTIONS(description="频道页面浏览次数"),
  channel_user_cnt INT64 OPTIONS(description="频道设备用户数")
)
PARTITION BY dt
CLUSTER BY user_group
OPTIONS(
  require_partition_filter=true
);