CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  user_group STRING OPTIONS(description="用户分组分类"),
  device_id STRING OPTIONS(description="设备唯一标识"),
  refer STRING OPTIONS(description="页面名称"),
  ap_name STRING OPTIONS(description="交互点名称"),
  event_name STRING OPTIONS(description="事件名称（select_item、view_item_list 等）"),
  event_method STRING OPTIONS(description="事件触发方式（点击、浏览、摇一摇等）"),
  event_action_type STRING OPTIONS(description="事件行为类型（视频试穿、无头像视频试穿等）"),
  event_source STRING OPTIONS(description="refer 与 ap_name 组合的事件来源"),
  video_tryon_mode_type STRING OPTIONS(description="视频试穿模板类型（视频视频试穿等）"),
  video_tryon_trigger_cnt INT64 OPTIONS(description="触发视频试穿次数"),
  video_tryon_trigger_device_id STRING OPTIONS(description="触发视频试穿事件设备ID"),
  video_tryon_complete_task_cnt INT64 OPTIONS(description="视频试穿成功任务数"),
  video_tryon_complete_device_id STRING OPTIONS(description="视频试穿成功用户设备ID"),
  video_tryon_play_complete_task_cnt INT64 OPTIONS(description="视频试穿播放完成任务数"),
  video_tryon_play_complete_device_id STRING OPTIONS(description="视频试穿播放完成用户设备ID"),
  video_tryon_retry_task_cnt INT64 OPTIONS(description="视频试穿重试次数"),
  video_tryon_retry_device_id STRING OPTIONS(description="视频试穿重试用户设备ID"),
  video_tryon_switch_mode_task_cnt INT64 OPTIONS(description="视频试穿切换模式任务数"),
  video_tryon_switch_mode_device_id STRING OPTIONS(description="视频试穿切换模式用户设备ID"),
  video_tryon_save_task_cnt INT64 OPTIONS(description="视频试穿保存任务数"),
  video_tryon_save_device_id STRING OPTIONS(description="视频试穿保存用户设备ID"),
  video_tryon_unsave_task_cnt INT64 OPTIONS(description="视频试穿取消保存任务数"),
  video_tryon_unsave_device_id STRING OPTIONS(description="视频试穿取消保存用户设备ID"),
  video_tryon_like_task_cnt INT64 OPTIONS(description="视频试穿点赞任务数"),
  video_tryon_like_device_id STRING OPTIONS(description="视频试穿点赞用户设备ID"),
  video_tryon_dislike_task_cnt INT64 OPTIONS(description="视频试穿点踩任务数"),
  video_tryon_dislike_device_id STRING OPTIONS(description="视频试穿点踩用户设备ID"),
  video_tryon_download_task_cnt INT64 OPTIONS(description="视频试穿下载任务数"),
  video_tryon_download_device_id STRING OPTIONS(description="视频试穿下载用户设备ID")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);