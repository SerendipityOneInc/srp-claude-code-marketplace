# dws_favie_gensmo_tryon_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-17
**最后更新**: 2025-11-17

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
      CASE WHEN refer = 'try_on_selected_panel' then 'try_on_select_panel'  ELSE refer END  AS refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_timestamp,
      concat(coalesce(CASE WHEN refer = 'try_on_selected_panel' then 'try_on_select_panel'  ELSE refer END,"unknown"),"@",coalesce(ap_name,"unknown")) as event_source,

      (select IF(event_item.item_id='default',null,event_item.item_id) from unnest(event_items) as event_item 
        where event_item.item_type in ('tryon_task', 'try_on_task','try_on_collage') limit 1
      ) as tryon_task_id,

      (select event_item.item_name from unnest(event_items) as event_item 
        where event_item.item_type = 'try_on_type' limit 1
      ) as tryon_type,

      (select event_item.item_id from unnest(event_items) as event_item 
        where event_item.item_type = 'try_on_type' limit 1
      ) as tryon_type_id,

      (select CASE WHEN event_item.item_id IS NOT NULL AND event_item.item_id != 'default' THEN event_item.item_id ELSE event_item.item_name END from unnest(event_items) as event_item 
        where event_item.item_type = 'try_on_complete_status' limit 1
      ) as tryon_complete_status,

      if(exists (
        select 1
        from unnest(event_items) as event_item_check
        where event_item_check.item_type in ('try_on_scenario_collage')
      ), true, false) as is_tryon_scenario_collage

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
      tryon_task_id,
      tryon_type,
      tryon_complete_status,
      is_tryon_scenario_collage,
      first_value(
        if(event_action_type in ('save','unsave'),event_action_type,null)
      ) OVER (PARTITION BY device_id,tryon_task_id ORDER BY if(event_action_type in ('save','unsave'),1,0) desc,event_timestamp desc) AS event_save_type,

      first_value(
        if(event_action_type in ('like','cancel_like','dislike','cancel_dislike'),event_action_type,null)
      ) OVER (PARTITION BY device_id,tryon_task_id ORDER BY if(event_action_type in ('like','cancel_like','dislike','cancel_dislike'),1,0) desc,event_timestamp desc) AS event_like_type,
    from base_events_data
    WHERE (tryon_type_id IS NULL OR tryon_type_id != '2') -- 排除所有换背景任务 -- 埋点问题
  ),

  server_try_on_task_data AS (
    SELECT 
      try_on_task_id as tryon_task_id,
      model_type as tryon_task_model_type,
      is_vibe as tryon_task_is_vibe,
      date(created_time) as tryon_task_created_date,
      status as tryon_task_status,
      is_clone_task,
      IFNULL(use_default_model,FALSE) as use_default_avatar
    FROM `srpproduct-dc37e.favie_dw.dim_try_on_user_task_view`
    WHERE 1=1
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
      t1.tryon_task_id,
      t1.tryon_type,
      t1.tryon_complete_status,
      t1.is_tryon_scenario_collage,
      t1.event_like_type,
      t1.event_save_type,
      --tryon task info
      t2.tryon_task_model_type,
      t2.tryon_task_is_vibe,
      t2.tryon_task_created_date,
      t2.tryon_task_status,
      t2.is_clone_task,
      t2.use_default_avatar,
      if(tryon_task_created_date is not null and tryon_task_created_date = dt_param 
        and is_clone_task is not null and is_clone_task = False,true ,false) as is_original_today_task
    FROM base_events_data_with_first t1
    LEFT JOIN server_try_on_task_data t2
    ON t1.tryon_task_id = t2.tryon_task_id
    WHERE NOT (t2.tryon_task_id IS NOT NULL AND t2.tryon_task_model_type IS NULL)
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
      ,tryon_task_model_type
      ,use_default_avatar

      --Tryon trigger
      ,COALESCE(sum(case when ((
                (event_action_type in ('try_on', 'try_on_no_avatar', 'try_on_select') 
                        and ap_name like ("ap_%") 
                        and event_method in ('click', 'shake') 
                        and event_name = 'select_item' 
                )
                or event_action_type = 'try_on_trigger'
              ) and refer != 'try_on_select_panel'
      ) then 1 else 0 end), 0) as tryon_trigger_cnt


      --Tryon request
      ,COALESCE(sum(CASE WHEN (event_action_type in ('try_on', 'try_on_no_avatar')
                        and ap_name like ("ap_%")
                        and event_method in ('click', 'shake')
                        and event_name = 'select_item')
      or (event_action_type = 'try_on_request' and tryon_type = 'regular') THEN 1 ELSE 0 END), 0) as tryon_request_cnt



      --Tryon Complete
      ,COALESCE(count(distinct CASE WHEN event_action_type = 'try_on_complete' and tryon_complete_status = 'completed' THEN tryon_task_id ELSE null END), 0) as tryon_complete_succeed_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_action_type = 'try_on_complete' and tryon_complete_status = 'failure' THEN tryon_task_id ELSE null END), 0) as tryon_complete_fail_task_cnt

      --Tryon Load
      ,COALESCE(count(distinct CASE WHEN event_action_type = 'try_on_load_fail' and event_method = 'load_complete' and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_load_fail_task_cnt

      --Tryon Enter Detail
      -- ,COALESCE(count(distinct CASE WHEN event_action_type in ('enter_tryon_detail', 'enter_try_on_detail') and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_view_detail_task_cnt
      ,COALESCE(count(distinct CASE WHEN refer = 'try_on_gen' and event_name = 'view_item_list' and ap_name = 'ap_try_on_result_list'
  THEN tryon_task_id ELSE null END), 0) as tryon_view_detail_task_cnt

      --Tryon Interaction
      ,COALESCE(sum(CASE WHEN ap_name like '%retry%' THEN 1 ELSE 0 END), 0) as tryon_retry_cnt
      --group by 里面有event_action_type,所以这里只能统计有效的action type
      ,COALESCE(count(distinct CASE WHEN event_save_type = 'save' and event_action_type in ('save','unsave') and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_save_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_save_type = 'unsave' and event_action_type in ('save','unsave') and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_unsave_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_like_type = 'like' and event_action_type in ('like','dislike','cancel_like','cancel_dislike') and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_like_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_like_type = 'dislike' and event_action_type in ('like','dislike','cancel_like','cancel_dislike') and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_dislike_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_action_type = 'download' and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_download_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_action_type = 'external_share' and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_share_task_cnt
      ,COALESCE(count(distinct CASE WHEN event_action_type = 'post' and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_post_task_cnt
      ,COALESCE(count(distinct CASE WHEN refer = 'try_on_gen' and ap_name = 'ap_try_on_result_entity_list_entity' and is_original_today_task = True THEN tryon_task_id ELSE null END), 0) as tryon_view_product_task_cnt
    FROM events_data_with_task
    where 1=1
      --trigger 里面也可能携带task_id,如果是retry或者try more
      -- and coalesce(tryon_task_created_date,dt_param) = dt_param --- 任务创建日期等于当前日期，如果没有任务创建日期，则认为是当天的事件
      -- and is_tryon_scenario_collage = False
      -- and (is_clone_task is null or is_clone_task = False)
    GROUP BY 
      dt,
      device_id,
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_source,
      tryon_task_model_type,
      use_default_avatar
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
      t1.tryon_task_model_type,
      t1.use_default_avatar,


      --Tryon Intention
      t1.tryon_trigger_cnt,

      --Tryon Gen Action
      t1.tryon_request_cnt,

      --Tryon Complete
      t1.tryon_complete_succeed_task_cnt,
      t1.tryon_complete_fail_task_cnt,

      --Tryon Load
      t1.tryon_load_fail_task_cnt,
      t1.tryon_complete_succeed_task_cnt - t1.tryon_load_fail_task_cnt as tryon_load_succeed_task_cnt,

      --Tryon Enter Detail
      t1.tryon_view_detail_task_cnt,
      -- t1.tryon_view_detail_task_cnt_v2,

      --Tryon interaction
      t1.tryon_retry_cnt,
      t1.tryon_save_task_cnt,
      t1.tryon_unsave_task_cnt,
      t1.tryon_like_task_cnt,
      t1.tryon_dislike_task_cnt,
      t1.tryon_download_task_cnt,
      t1.tryon_share_task_cnt,
      t1.tryon_post_task_cnt,
      t1.tryon_view_product_task_cnt
    from (
      select * from base_dws_data 
      where (
            IFNULL(tryon_trigger_cnt, 0)
            + IFNULL(tryon_request_cnt, 0)
            + IFNULL(tryon_complete_succeed_task_cnt, 0)
            + IFNULL(tryon_complete_fail_task_cnt, 0)
            + IFNULL(tryon_load_fail_task_cnt, 0)
            + IFNULL(tryon_view_detail_task_cnt, 0)
            + IFNULL(tryon_retry_cnt, 0)
            + IFNULL(tryon_save_task_cnt, 0)
            + IFNULL(tryon_unsave_task_cnt, 0)
            + IFNULL(tryon_like_task_cnt, 0)
            + IFNULL(tryon_dislike_task_cnt, 0)
            + IFNULL(tryon_download_task_cnt, 0)
            + IFNULL(tryon_share_task_cnt, 0)
            + IFNULL(tryon_post_task_cnt, 0)
            + IFNULL(tryon_view_product_task_cnt, 0)
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
      tryon_task_model_type,
      use_default_avatar,

      --Tryon Trigger
      tryon_trigger_cnt,
      if(tryon_trigger_cnt > 0, user_device_id, NULL) as tryon_trigger_device_id,

      --Tryon Request
      tryon_request_cnt,
      if(tryon_request_cnt > 0, user_device_id, NULL) as tryon_request_device_id,

      --Tryon Complete
      tryon_complete_succeed_task_cnt,
      if(tryon_complete_succeed_task_cnt > 0, user_device_id, null) as tryon_complete_succeed_device_id,

      tryon_complete_fail_task_cnt,
      if(tryon_complete_fail_task_cnt > 0, user_device_id, null) as tryon_complete_fail_device_id,

      --Tryon Load
      tryon_load_fail_task_cnt,
      if(tryon_load_fail_task_cnt > 0, user_device_id, null) as tryon_load_fail_device_id,
      tryon_load_succeed_task_cnt,
      if(tryon_load_succeed_task_cnt > 0, user_device_id, null) as tryon_load_succeed_device_id,

      --Tryon Enter Detail
      tryon_view_detail_task_cnt,
      -- tryon_view_detail_task_cnt_v2,
      if(tryon_view_detail_task_cnt > 0, user_device_id, null) as tryon_view_detail_device_id,

      --Tryon Interaction
      tryon_retry_cnt,
      if(tryon_retry_cnt > 0, user_device_id, null) as tryon_retry_device_id,
      tryon_save_task_cnt,
      if(tryon_save_task_cnt > 0, user_device_id, null) as tryon_save_device_id,
      tryon_unsave_task_cnt,
      if(tryon_unsave_task_cnt > 0, user_device_id, null) as tryon_unsave_device_id,
      tryon_like_task_cnt,
      if(tryon_like_task_cnt > 0, user_device_id, null) as tryon_like_device_id,
      tryon_dislike_task_cnt,
      if(tryon_dislike_task_cnt > 0, user_device_id, null) as tryon_dislike_device_id,
      tryon_download_task_cnt,
      if(tryon_download_task_cnt > 0, user_device_id, null) as tryon_download_device_id,
      tryon_share_task_cnt,
      if(tryon_share_task_cnt > 0, user_device_id, null) as tryon_share_device_id,
      tryon_post_task_cnt,
      if(tryon_post_task_cnt > 0, user_device_id, null) as tryon_post_device_id,
      tryon_view_product_task_cnt,
      if(tryon_view_product_task_cnt > 0, user_device_id, null) as tryon_view_product_device_id
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
      tryon_task_model_type,

      --Tryon Trigger
      tryon_trigger_cnt,
      tryon_trigger_device_id,

      --Tryon Request
      tryon_request_cnt,
      tryon_request_device_id,

      --Tryon Complete
      tryon_complete_succeed_task_cnt,
      tryon_complete_succeed_device_id,
      tryon_complete_fail_task_cnt,
      tryon_complete_fail_device_id,

      --Tryon Load
      tryon_load_fail_task_cnt,
      tryon_load_fail_device_id,
      tryon_load_succeed_task_cnt,
      tryon_load_succeed_device_id,

      --Tryon Enter Detail
      tryon_view_detail_task_cnt,
      -- tryon_view_detail_task_cnt_v2,
      tryon_view_detail_device_id,

      --Tryon Interaction
      tryon_retry_cnt,
      tryon_retry_device_id,
      tryon_save_task_cnt,
      tryon_save_device_id,
      tryon_unsave_task_cnt,
      tryon_unsave_device_id,
      tryon_like_task_cnt,
      tryon_like_device_id,
      tryon_dislike_task_cnt,
      tryon_dislike_device_id,
      tryon_download_task_cnt,
      tryon_download_device_id,
      tryon_share_task_cnt,
      tryon_share_device_id,
      tryon_post_task_cnt,
      tryon_post_device_id,
      tryon_view_product_task_cnt,
      tryon_view_product_device_id,

      -- avatar type
      use_default_avatar
    FROM base_dws_data_with_uv
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
