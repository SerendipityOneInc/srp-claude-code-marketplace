CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_search_metrics_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区"),
  user_tenure_type STRING OPTIONS(description="用户新老类型"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  country_name STRING OPTIONS(description="国家名"),
  platform STRING OPTIONS(description="平台"),
  app_version STRING OPTIONS(description="app版本"),
  user_group STRING OPTIONS(description="用户分组"),
  search_trigger_pv_cnt INT64 OPTIONS(description="发起collage生成的pv数"),
  search_boot_page_view_pv_cnt INT64 OPTIONS(description="search_boot页曝光pv"),
  search_boot_polish_pv_cnt INT64 OPTIONS(description="search_boot页polish功能点击数"),
  search_boot_focus_pv_cnt INT64 OPTIONS(description="search_boot页InputBox Focus点击数"),
  search_trigger_user_cnt INT64 OPTIONS(description="发起collage生成的用户数"),
  search_boot_page_view_user_cnt INT64 OPTIONS(description="search_boot页曝光用户数"),
  search_boot_polish_user_cnt INT64 OPTIONS(description="search_boot页polish功能点击用户数"),
  search_boot_focus_user_cnt INT64 OPTIONS(description="search_boot页InputBox Focus点击用户数"),
  DAU INT64 OPTIONS(description="日活跃用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);