CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d`
(
  dt DATE OPTIONS(description="被创建的日期"),
  chat_session_id STRING OPTIONS(description="会话id"),
  message_type STRING OPTIONS(description="信息类型"),
  message_visibility STRING OPTIONS(description="是否是用户可见的"),
  user_id STRING OPTIONS(description="发起会话的用户id"),
  device_id STRING OPTIONS(description="设备id"),
  user_role STRING OPTIONS(description="发送信息的角色"),
  user_group STRING OPTIONS(description="用户组"),
  country_name STRING OPTIONS(description="所在国家"),
  platform STRING OPTIONS(description="应用平台"),
  app_version STRING OPTIONS(description="应用版本"),
  user_login_type STRING OPTIONS(description="用户登录类型"),
  user_tenure_type STRING OPTIONS(description="用户活跃类型(新/老用户)"),
  ad_source STRING OPTIONS(description="广告来源"),
  ad_id STRING OPTIONS(description="广告id"),
  ad_group_id STRING OPTIONS(description="广告组id"),
  ad_campaign_id STRING OPTIONS(description="广告计划id"),
  msg_cnt INT64 OPTIONS(description="信息条数"),
  search_query_intention STRING OPTIONS(description="搜索查询意图/目的"),
  search_query_type STRING OPTIONS(description="搜索查询类型(图文情况)")
);