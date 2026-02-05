# dws_favie_gensmo_video_tryon_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_video_tryon_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-11
**最后更新**: 2025-12-11

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with base_events_data AS (
    SELECT 
      dt,

      event_uuid,
      --user info
      device_id,

      --event info
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_timestamp,
      concat(refer,"@",ap_name) as event_source,

      (select event_item.item_id from unnest(event_items) as event_item 
        where event_item.item_type = 'video_gen_template' limit 1
      ) as video_tryon_mode_type,

      (select event_item.item_id from unnest(event_items) as event_item 
        where event_item.item_type = 'video_gen_task' limit 1
      ) as video_tryon_task_id,

    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
    where 1=1
      and refer_group = 'valid'
      and event_version='1.0.0'
      and dt = dt_param
  ),


  base_events_data_with_first as (
    select 
      dt,
      event_uuid,
      --user info
      device_id,
      --event info
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_timestamp,
      event_source,
      video_tryon_task_id,
      video_tryon_mode_type,
      first_value(if(event_action_type in ('save','unsave'),event_action_type,null)) 
        OVER (PARTITION BY device_id,video_tryon_task_id ORDER BY if(event_action_type in ('save','unsave'),1,0) desc,event_timestamp desc) AS event_save_type,

      first_value(if(event_action_type in ('like','cancel_like','dislike','cancel_dislike'),event_action_type,null)) 
        OVER (PARTITION BY device_id,video_tryon_task_id ORDER BY if(event_action_type in ('like','cancel_like','dislike','cancel_dislike'),1,0) desc,event_timestamp desc) AS event_like_type,
    from base_events_data
  ),

  server_try_on_task_data AS (
    SELECT 
      try_on_task_id as video_tryon_task_id,
      video_try_on_mode as video_tryon_mode_type,
      date(created_time) as video_tryon_task_created_date,
      status as video_tryon_task_status
    FROM `srpproduct-dc37e.favie_dw.dim_try_on_user_task_view`
    WHERE 1=1 
      and tryon_router = 'video' 
      and date(created_time) = dt_param
  ),

  events_data_with_task AS (
    SELECT 
      t1.dt,
      t1.event_uuid,
      --user info
      t1.device_id,
      --event info
      t1.refer,
      t1.ap_name,
      t1.event_name,
      t1.event_method,
      t1.event_action_type,
      t1.event_source,
      t1.video_tryon_task_id,
      coalesce(t2.video_tryon_mode_type, t1.video_tryon_mode_type) as video_tryon_mode_type,
      t1.event_like_type,
      t1.event_save_type,
      --tryon task info
      t2.video_tryon_task_status
    FROM base_events_data_with_first t1
    LEFT JOIN server_try_on_task_data t2
    ON t1.video_tryon_task_id is not null and t1.video_tryon_task_id = t2.video_tryon_task_id
  ),

  base_dws_data AS (
    SELECT 
      dt

      --user info 
      ,device_id

      --event info
      ,refer
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source
      ,video_tryon_mode_type

      --Tryon trigger
      ,coalesce(sum(if(event_action_type = 'video_gen_trigger', 1, 0)), 0) as video_tryon_trigger_cnt
      ,coalesce(count(distinct if(event_action_type = 'video_gen_trigger' and ap_name = 'ap_retry_btn', video_tryon_task_id, null)), 0) as video_tryon_retry_task_cnt
      ,coalesce(count(distinct if(event_action_type = 'video_gen_complete', video_tryon_task_id, NULL)), 0) as video_tryon_complete_task_cnt
      ,coalesce(count(distinct if(event_action_type = 'video_play_complete', video_tryon_task_id, NULL)), 0) as video_tryon_play_complete_task_cnt

      --group by 里面有event_action_type,所以这里只能统计有效的action type
      ,coalesce(count(distinct if(ap_name = 'ap_video_template', video_tryon_task_id, null)), 0) as video_tryon_switch_mode_task_cnt
      ,coalesce(count(distinct CASE WHEN event_save_type = 'save' and event_action_type in ('save','unsave') THEN video_tryon_task_id ELSE null END), 0) as video_tryon_save_task_cnt
      ,coalesce(count(distinct CASE WHEN event_save_type = 'unsave' and event_action_type in ('save','unsave') THEN video_tryon_task_id ELSE null END), 0) as video_tryon_unsave_task_cnt
      ,coalesce(count(distinct CASE WHEN event_like_type = 'like' and event_action_type in ('like','dislike','cancel_like','cancel_dislike') THEN video_tryon_task_id ELSE null END), 0) as video_tryon_like_task_cnt
      ,coalesce(count(distinct CASE WHEN event_like_type = 'dislike' and event_action_type in ('like','dislike','cancel_like','cancel_dislike') THEN video_tryon_task_id ELSE null END), 0) as video_tryon_dislike_task_cnt
      ,coalesce(count(distinct CASE WHEN event_action_type = 'download' THEN video_tryon_task_id ELSE null END), 0) as video_tryon_download_task_cnt
    FROM events_data_with_task
    GROUP BY 
      dt,
      device_id,
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_source,
      video_tryon_mode_type
),

  user_info_with_group as (
    select 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)
  ),

  base_dws_data_with_user as (
    select 
      t1.dt,

      --user info 
      t2.platform,
      t2.app_version,
      t2.country_name,
      t2.user_login_type,
      t2.user_tenure_type,
      t2.user_group,
      t1.device_id,
      t2.device_id as user_device_id,

      --event info
      t1.refer,
      t1.ap_name,
      t1.event_name,
      t1.event_method,
      t1.event_action_type,
      t1.event_source,
      t1.video_tryon_mode_type,

      --Video Tryon metrics
      t1.video_tryon_trigger_cnt,
      t1.video_tryon_retry_task_cnt,
      t1.video_tryon_complete_task_cnt,
      t1.video_tryon_play_complete_task_cnt,
      t1.video_tryon_switch_mode_task_cnt,
      t1.video_tryon_save_task_cnt,
      t1.video_tryon_unsave_task_cnt,
      t1.video_tryon_like_task_cnt,
      t1.video_tryon_dislike_task_cnt,
      t1.video_tryon_download_task_cnt
    from (
      select * from base_dws_data 
      where (
            IFNULL(video_tryon_trigger_cnt, 0)
            + IFNULL(video_tryon_retry_task_cnt, 0)
            + IFNULL(video_tryon_complete_task_cnt, 0)
            + IFNULL(video_tryon_play_complete_task_cnt, 0)
            + IFNULL(video_tryon_switch_mode_task_cnt, 0)
            + IFNULL(video_tryon_save_task_cnt, 0)
            + IFNULL(video_tryon_unsave_task_cnt, 0)
            + IFNULL(video_tryon_like_task_cnt, 0)
            + IFNULL(video_tryon_dislike_task_cnt, 0)
            + IFNULL(video_tryon_download_task_cnt, 0)
        ) > 0
    ) as t1 left outer join user_info_with_group t2
    on t1.device_id = t2.device_id
    where t2.user_group is not null
  ),

  base_dws_data_with_uv as (
    SELECT
      dt,

      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      device_id,

      --event info
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_source,
      video_tryon_mode_type,

      --Video Tryon metrics
      video_tryon_trigger_cnt,
      if(video_tryon_trigger_cnt > 0, user_device_id, NULL) as video_tryon_trigger_device_id,

      video_tryon_retry_task_cnt,
      if(video_tryon_retry_task_cnt > 0, user_device_id, NULL) as video_tryon_retry_device_id,

      video_tryon_complete_task_cnt,
      if(video_tryon_complete_task_cnt > 0, user_device_id, null) as video_tryon_complete_device_id,

      video_tryon_play_complete_task_cnt,
      if(video_tryon_play_complete_task_cnt > 0, user_device_id, null) as video_tryon_play_complete_device_id,

      video_tryon_switch_mode_task_cnt,
      if(video_tryon_switch_mode_task_cnt > 0, user_device_id, null) as video_tryon_switch_mode_device_id,

      video_tryon_save_task_cnt,
      if(video_tryon_save_task_cnt > 0, user_device_id, null) as video_tryon_save_device_id,

      video_tryon_unsave_task_cnt,
      if(video_tryon_unsave_task_cnt > 0, user_device_id, null) as video_tryon_unsave_device_id,

      video_tryon_like_task_cnt,
      if(video_tryon_like_task_cnt > 0, user_device_id, null) as video_tryon_like_device_id,

      video_tryon_dislike_task_cnt,
      if(video_tryon_dislike_task_cnt > 0, user_device_id, null) as video_tryon_dislike_device_id,

      video_tryon_download_task_cnt,
      if(video_tryon_download_task_cnt > 0, user_device_id, null) as video_tryon_download_device_id
    FROM base_dws_data_with_user
    where user_device_id is not null
  )

  SELECT
      dt,

      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      device_id,

      --event info
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_source,
      video_tryon_mode_type,

      --Video Tryon Trigger
      video_tryon_trigger_cnt,
      video_tryon_trigger_device_id,

      --Video Tryon Retry
      video_tryon_retry_task_cnt,
      video_tryon_retry_device_id,

      --Video Tryon Complete
      video_tryon_complete_task_cnt,
      video_tryon_complete_device_id,

      --Video Tryon Play Complete
      video_tryon_play_complete_task_cnt,
      video_tryon_play_complete_device_id,

      --Video Tryon Switch Template
      video_tryon_switch_mode_task_cnt,
      video_tryon_switch_mode_device_id,

      --Video Tryon Interaction
      video_tryon_save_task_cnt,
      video_tryon_save_device_id,
      video_tryon_unsave_task_cnt,
      video_tryon_unsave_device_id,
      video_tryon_like_task_cnt,
      video_tryon_like_device_id,
      video_tryon_dislike_task_cnt,
      video_tryon_dislike_device_id,
      video_tryon_download_task_cnt,
      video_tryon_download_device_id
    FROM base_dws_data_with_uv
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
