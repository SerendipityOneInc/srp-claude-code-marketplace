CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_session_behavior_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  session_id STRING OPTIONS(description="会话 ID"),
  user_uid STRING OPTIONS(description="用户 UID"),
  last_device_id STRING OPTIONS(description="最后一次使用的设备 ID"),
  message_type STRING OPTIONS(description="会话消息类型（例如 search、tryon 等）"),
  total_message_count INT64 OPTIONS(description="会话内消息总数"),
  search_query_count INT64 OPTIONS(description="搜索请求消息数"),
  search_res_count INT64 OPTIONS(description="搜索结果返回消息数"),
  tryon_query_count INT64 OPTIONS(description="试穿请求消息数"),
  tryon_res_count INT64 OPTIONS(description="试穿结果返回消息数"),
  tryon_changebg_query_count INT64 OPTIONS(description="换背景请求消息数"),
  tryon_changebg_res_count INT64 OPTIONS(description="换背景结果返回消息数"),
  session_start_count INT64 OPTIONS(description="会话启动消息数"),
  unexpect_error_count INT64 OPTIONS(description="意外错误消息数"),
  platform STRING OPTIONS(description="平台（如 app/web）"),
  app_version STRING OPTIONS(description="App 版本号"),
  country_name STRING OPTIONS(description="用户所在国家"),
  user_login_type STRING OPTIONS(description="用户登录类型（游客/注册用户）"),
  user_tenure_type STRING OPTIONS(description="用户新老类型（新客/老客）"),
  user_group STRING OPTIONS(description="用户分组标记（如实验组/对照组）")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);