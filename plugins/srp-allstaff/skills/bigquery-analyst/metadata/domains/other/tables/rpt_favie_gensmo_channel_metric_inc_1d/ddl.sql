CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  platform STRING OPTIONS(description="平台类型（iOS、Android 等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="用户所属国家名称"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期分类（新用户、老用户）"),
  user_group STRING OPTIONS(description="用户分组分类"),
  item_task_gen_pv_cnt INT64 OPTIONS(description="channel发起任务数"),
  item_task_complete_pv_cnt INT64 OPTIONS(description="channel完成浏览次数"),
  item_task_complete_item_cnt INT64 OPTIONS(description="channel完成的Item数量"),
  item_task_list_pv_cnt INT64 OPTIONS(description="channel任务列表浏览次数"),
  item_task_list_item_cnt INT64 OPTIONS(description="channel任务列表Item数量"),
  item_task_detail_pv_cnt INT64 OPTIONS(description="channel任务详情浏览次数"),
  item_task_detail_item_cnt INT64 OPTIONS(description="channel任务详情Item数量"),
  item_task_save_cnt INT64 OPTIONS(description="channel任务收藏次数"),
  item_task_save_item_cnt INT64 OPTIONS(description="channel任务收藏Item数量"),
  item_task_unsave_cnt INT64 OPTIONS(description="channel任务取消收藏次数"),
  item_task_unsave_item_cnt INT64 OPTIONS(description="channel任务取消收藏Item数量"),
  item_task_like_cnt INT64 OPTIONS(description="channel任务点赞次数"),
  item_task_like_item_cnt INT64 OPTIONS(description="channel任务点赞Item数量"),
  item_task_cancel_like_cnt INT64 OPTIONS(description="channel任务取消点赞次数"),
  item_task_cancel_like_item_cnt INT64 OPTIONS(description="channel任务取消点赞Item数量"),
  item_task_share_cnt INT64 OPTIONS(description="channel任务分享次数"),
  item_task_share_item_cnt INT64 OPTIONS(description="channel任务分享Item数量"),
  item_task_download_cnt INT64 OPTIONS(description="channel任务下载次数"),
  item_task_download_item_cnt INT64 OPTIONS(description="channel任务下载Item数量"),
  item_task_external_jump_cnt INT64 OPTIONS(description="channel任务外跳次数"),
  item_task_external_jump_item_cnt INT64 OPTIONS(description="channel任务外跳Item数量")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);