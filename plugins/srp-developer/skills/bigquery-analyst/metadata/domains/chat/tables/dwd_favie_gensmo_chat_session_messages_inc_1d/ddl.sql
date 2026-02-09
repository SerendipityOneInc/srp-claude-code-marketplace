CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d`
(
  dt DATE OPTIONS(description="被创建的日期"),
  chat_session_id STRING OPTIONS(description="会话id"),
  message_id STRING OPTIONS(description="id"),
  message_type STRING OPTIONS(description="信息类型"),
  message_visibility STRING OPTIONS(description="是否是用户可见的"),
  message_value JSON OPTIONS(description="信息的具体内容"),
  message_sent_at TIMESTAMP OPTIONS(description="信息发出的时间"),
  user_id STRING OPTIONS(description="发起会话的用户id"),
  user_role STRING OPTIONS(description="发送信息的角色"),
  created_at TIMESTAMP OPTIONS(description="被创建的时间"),
  updated_at TIMESTAMP OPTIONS(description="最后一次被更新的时间")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);