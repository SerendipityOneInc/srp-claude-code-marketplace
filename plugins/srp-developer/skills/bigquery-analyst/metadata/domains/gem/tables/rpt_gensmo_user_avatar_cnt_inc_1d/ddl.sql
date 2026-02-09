CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  device_id STRING OPTIONS(description="设备ID"),
  user_group STRING OPTIONS(description="用户分组"),
  user_login_type STRING OPTIONS(description="用户登录类型（匿名、注册等）"),
  user_tenure_type STRING OPTIONS(description="用户使用周期类型（新/老用户）"),
  platform STRING OPTIONS(description="平台类型（iOS、Android等）"),
  app_version STRING OPTIONS(description="应用版本"),
  country_name STRING OPTIONS(description="国家名称"),
  validated_task_cnt INT64 OPTIONS(description="上传照片但未生成avatar任务数量"),
  failed_task_cnt INT64 OPTIONS(description="avatar生成失败任务数量"),
  discarded_task_cnt INT64 OPTIONS(description="生成成功但用户未选择（refine或close）任务数量"),
  refined_task_cnt INT64 OPTIONS(description="生成成功且用户refine任务数量"),
  selected_task_cnt INT64 OPTIONS(description="生成成功且用户选取任务数量"),
  new_avatar_cnt INT64 OPTIONS(description="新头像数量"),
  valid_avatar_cnt INT64 OPTIONS(description="有效头像数量"),
  invalid_avatar_cnt INT64 OPTIONS(description="无效头像数量"),
  validated_task_device_id STRING OPTIONS(description="上传照片但未生成avatar任务设备ID"),
  failed_task_device_id STRING OPTIONS(description="avatar生成失败任务设备ID"),
  discarded_task_device_id STRING OPTIONS(description="生成成功但用户未选择（refine或close）任务设备ID"),
  refined_task_device_id STRING OPTIONS(description="生成成功且用户refine任务设备ID"),
  selected_task_device_id STRING OPTIONS(description="生成成功且用户选取任务设备ID"),
  new_avatar_device_id STRING OPTIONS(description="新头像设备ID"),
  valid_avatar_device_id STRING OPTIONS(description="有效头像设备ID"),
  invalid_avatar_device_id STRING OPTIONS(description="无效头像设备ID")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);