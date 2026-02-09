CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_model_metric_inc_1d`
(
  dt DATE OPTIONS(description="指标数据日期"),
  item_task_model STRING OPTIONS(description="任务模型类型"),
  item_task_list_item_cnt INT64 OPTIONS(description="channel任务列表Item数量"),
  item_task_save_item_cnt INT64 OPTIONS(description="channel任务收藏Item数量"),
  item_task_download_item_cnt INT64 OPTIONS(description="channel任务下载Item数量")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);