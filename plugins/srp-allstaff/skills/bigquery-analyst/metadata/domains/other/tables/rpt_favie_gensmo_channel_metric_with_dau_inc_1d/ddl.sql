CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型，如手机号、微信授权等"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数"),
  channel_user_cnt INT64 OPTIONS(description="channel用户数量"),
  user_channel_cnt INT64 OPTIONS(description="用户channel数量"),
  item_task_gen_user_cnt INT64 OPTIONS(description="channel任务开始用户数"),
  item_task_complete_user_cnt INT64 OPTIONS(description="channel任务完成用户数"),
  item_task_detail_user_cnt INT64 OPTIONS(description="channel任务详情用户数"),
  item_task_save_user_cnt INT64 OPTIONS(description="channel任务收藏用户数"),
  item_task_unsave_user_cnt INT64 OPTIONS(description="channel任务取消收藏用户数"),
  item_task_like_user_cnt INT64 OPTIONS(description="channel任务点赞用户数"),
  item_task_cancel_like_user_cnt INT64 OPTIONS(description="channel任务取消点赞用户数"),
  item_task_share_user_cnt INT64 OPTIONS(description="channel任务分享用户数"),
  item_task_download_user_cnt INT64 OPTIONS(description="channel任务下载用户数"),
  item_task_external_jump_user_cnt INT64 OPTIONS(description="channel任务外跳用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);