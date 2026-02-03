CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_1d`
(
  dt DATE OPTIONS(description="日期"),
  platform STRING OPTIONS(description="用户所使用的平台"),
  app_version STRING OPTIONS(description="应用程序版本"),
  country_name STRING OPTIONS(description="用户所在国家"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户使用期限类型"),
  user_group STRING OPTIONS(description="用户群体类别"),
  device_id STRING OPTIONS(description="设备标识符"),
  query_input_inspo STRING OPTIONS(description="查询输入或点击金刚位"),
  query_input_type STRING OPTIONS(description="查询输入类型"),
  search_type STRING OPTIONS(description="搜索类型"),
  user_count INT64 OPTIONS(description="用户计数"),
  load_finish_count INT64 OPTIONS(description="完成加载计数"),
  agg_load_finish STRING OPTIONS(description="加载完成信息"),
  agg_error_block STRING OPTIONS(description="错误阻塞信息"),
  agg_login_block STRING OPTIONS(description="登录阻塞信息"),
  first_collage_gen_position INT64 OPTIONS(description="第一次 collage_gen 出现的位置"),
  second_collage_gen_position INT64 OPTIONS(description="第二次 collage_gen 出现的位置")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);