CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_video_tryon_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期，分区字段，格式YYYY-MM-DD"),
  platform STRING OPTIONS(description="用户平台，如 iOS、Android、Web"),
  app_version STRING OPTIONS(description="应用版本号"),
  country_name STRING OPTIONS(description="国家或地区名称"),
  user_login_type STRING OPTIONS(description="用户登录类型，如手机号、微信授权等"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类，如新用户、老用户"),
  user_group STRING OPTIONS(description="用户分群标签"),
  active_user_d1_cnt INT64 OPTIONS(description="日活跃用户数"),
  video_tryon_trigger_cnt INT64 OPTIONS(description="视频试穿触发次数"),
  video_tryon_trigger_user_cnt INT64 OPTIONS(description="视频试穿触发用户数"),
  video_tryon_complete_task_cnt INT64 OPTIONS(description="视频试穿完成任务数"),
  video_tryon_complete_user_cnt INT64 OPTIONS(description="视频试穿完成用户数"),
  video_tryon_play_complete_task_cnt INT64 OPTIONS(description="视频试穿播放完成任务数"),
  video_tryon_play_complete_user_cnt INT64 OPTIONS(description="视频试穿播放完成用户数"),
  video_tryon_retry_task_cnt INT64 OPTIONS(description="视频试穿重试次数"),
  video_tryon_retry_user_cnt INT64 OPTIONS(description="视频试穿重试用户数"),
  video_tryon_switch_mode_task_cnt INT64 OPTIONS(description="视频试穿切换模式任务数"),
  video_tryon_switch_mode_user_cnt INT64 OPTIONS(description="视频试穿切换模式用户数"),
  video_tryon_save_task_cnt INT64 OPTIONS(description="视频试穿保存任务数"),
  video_tryon_save_user_cnt INT64 OPTIONS(description="视频试穿保存用户数"),
  video_tryon_unsave_task_cnt INT64 OPTIONS(description="视频试穿取消保存任务数"),
  video_tryon_unsave_user_cnt INT64 OPTIONS(description="视频试穿取消保存用户数"),
  video_tryon_like_task_cnt INT64 OPTIONS(description="视频试穿点赞任务数"),
  video_tryon_like_user_cnt INT64 OPTIONS(description="视频试穿点赞用户数"),
  video_tryon_dislike_task_cnt INT64 OPTIONS(description="视频试穿点踩任务数"),
  video_tryon_dislike_user_cnt INT64 OPTIONS(description="视频试穿点踩用户数"),
  video_tryon_download_task_cnt INT64 OPTIONS(description="视频试穿下载任务数"),
  video_tryon_download_user_cnt INT64 OPTIONS(description="视频试穿下载用户数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);