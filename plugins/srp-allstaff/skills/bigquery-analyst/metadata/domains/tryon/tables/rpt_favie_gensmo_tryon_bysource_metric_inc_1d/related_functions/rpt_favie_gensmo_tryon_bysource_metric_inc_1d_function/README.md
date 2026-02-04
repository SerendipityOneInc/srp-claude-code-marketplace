# rpt_favie_gensmo_tryon_bysource_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_bysource_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-07-11
**最后更新**: 2025-07-11

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

      --user info
      device_id,

      --event info
      CASE WHEN refer = 'try_on_selected_panel' then'try_on_select_panel'  ELSE refer END  AS refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      concat(
        coalesce(CASE WHEN refer = 'try_on_selected_panel' then'try_on_select_panel'  ELSE refer END,"unknown")
        ,"@",coalesce(ap_name,"unknown")) as event_source,
      event_items,

      --event source
      cal_pre_refer,
      cal_pre_refer_event.ap_name AS cal_pre_refer_ap_name,
      concat(coalesce(cal_pre_refer,"unknown"),"@",coalesce(cal_pre_refer_event.ap_name,"unknown")) as cal_pre_event_source,

      --extract try_on_task_id from event_items when event_action_type = "try on"
      (SELECT item_id FROM UNNEST(event_items) AS item 
        WHERE item.item_type IN ("tryon_task","try_on_task") LIMIT 1) AS try_on_task_id

    FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
    where 1=1
      and event_timestamp is not null 
      and refer is not null 
      and platform is not null
      and event_version='1.0.0' 
      and dt = dt_param
  ),

  dim_try_on_task_data AS (
    SELECT 
      try_on_task_id,
      type,
      model_type 
    FROM srpproduct-dc37e.favie_dw.dim_try_on_task_view
    WHERE status = "completed" 
  ),

  base_dws_data as (
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

      --event source
      ,cal_pre_refer
      ,cal_pre_refer_ap_name
      ,cal_pre_event_source

      --task info
      ,COALESCE(dim_task.model_type, "unknown") as task_model
      ,COALESCE(dim_task.type, "unknown") as task_type

      --home
      ,sum(if(refer = 'home',1,0)) as home_pv_cnt

      --Tryon 
      ,sum(if(
            ((
              (ap_name like '%try_on%btn' and ap_name not in ('ap_try_on_history_list_item_delete_btn'))    
              or 
              (ap_name like '%retry%' and event_action_type in ('try_on','try_on_no_avatar'))     
              or ap_name = "ap_more_looks_btn"   
            )
            and event_name='select_item' 
            and event_method = 'click')
            or
            (event_name='select_item'  and event_method = 'shake' and refer = 'feed_detail')
            ,1,0)) as tryon_pv_cnt

      --Tryon Select Panel
      ,sum(CASE WHEN refer in ('try_on_select_panel') and event_method='page_view'and event_name='select_item' THEN 1 ELSE 0 end )as tryon_select_panel_pv_cnt
      ,sum(CASE WHEN refer in ('try_on_select_panel') and ap_name='ap_confirm_btn' and event_method='click' and event_name='select_item' THEN 1 ELSE 0 end) as tryon_select_panel_confirm_click_cnt
      
      --Tryon Gen
      ,sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage","profile_page","library") and event_name='select_item' and event_method='page_view' THEN 1 ELSE 0 END) as tryon_gen_panel_pv_cnt
      ,count( distinct CASE 
        WHEN 
          refer = 'channel' 
          and event_name='select_item' 
          and event_method='click' 
          and event_action_type in ('enter_tryon_detail','enter_try_on_detail')
        THEN (select event_item.item_id from unnest(event_items) as event_item limit 1) ELSE null END) as tryon_gen_panel_pv_cnt_2_0
      ,sum(CASE WHEN event_action_type in ('try_on','try_on_no_avatar') and ap_name like ("ap_%") and event_method in ('click','shake') and event_name='select_item' THEN 1 ELSE 0 END) as tryon_gen_action_cnt
      ,sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage","profile_page","library") and event_name='select_item' and event_method IN('click', 'screenshot') THEN 1 ELSE 0 END) as tryon_gen_panel_click_cnt
      ,SAFE_DIVIDE(sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage","profile_page","library") and event_name='select_item' and event_method IN('click', 'screenshot') THEN 1 ELSE 0 END),sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage","profile_page","library") and event_name='select_item' and event_method='page_view' THEN 1 ELSE 0 END)) as tryon_gen_panel_click_pv_through_rate
      ,SAFE_DIVIDE(sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage","profile_page","library") and event_name='select_item' and event_method IN('click', 'screenshot') THEN 1 ELSE 0 END),sum(CASE WHEN event_action_type = 'try_on' and event_method in ('click','shake') and event_name='select_item' THEN 1 ELSE 0 END)) as tryon_gen_panel_click_action_through_rate

      --Tryon Complete
      -- ,sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage","profile_page","library")and ap_name ="ap_try_on_result_list" and event_name='view_item_list' THEN 1 ELSE 0 END) as tryon_complete_pv_cnt
      ,sum(CASE WHEN event_action_type = 'try_on_complete' THEN 1 ELSE 0 END) as tryon_complete_pv_cnt
    from base_events_data
    left join dim_try_on_task_data dim_task
      on base_events_data.try_on_task_id = dim_task.try_on_task_id
    group by dt
      ,device_id
      ,refer
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source
      ,cal_pre_refer
      ,cal_pre_refer_ap_name
      ,cal_pre_event_source
      ,task_model
      ,task_type
  ),

  -- active_user_info AS (
  --   SELECT 
  --     device_id,
  --     last_day_feature.platform as platform,
  --     last_day_feature.app_version as app_version,
  --     last_30_days_feature.geo_country_name as country_name,
  --     last_day_feature.login_type as user_login_type,
  --     user_tenure_type
  --   FROM srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d
  --   where dt = dt_param
  -- ),

  user_info_with_group as (
    select 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` 
    where dt = dt_param
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

      --event source
      t1.cal_pre_refer,
      t1.cal_pre_refer_ap_name,
      t1.cal_pre_event_source,

      --task info
      t1.task_model,
      t1.task_type,

      --home
      t1.home_pv_cnt,

      --Tryon
      t1.tryon_pv_cnt,

      --Tryon Select Panel
      t1.tryon_select_panel_confirm_click_cnt,
      t1.tryon_select_panel_pv_cnt,

      --Tryon Gen
      t1.tryon_gen_panel_pv_cnt,
      t1.tryon_gen_panel_pv_cnt_2_0,
      t1.tryon_gen_action_cnt,
      t1.tryon_gen_panel_click_cnt,
      t1.tryon_gen_panel_click_pv_through_rate,
      t1.tryon_gen_panel_click_action_through_rate,

      --Tryon Complete
      t1.tryon_complete_pv_cnt


    from (
      select * from base_dws_data 
      where (
            IFNULL(home_pv_cnt, 0)
            + IFNULL(tryon_pv_cnt, 0)
            + IFNULL(tryon_select_panel_pv_cnt, 0)
            + IFNULL(tryon_select_panel_confirm_click_cnt, 0)
            + IFNULL(tryon_gen_panel_pv_cnt, 0)
            + IFNULL(tryon_gen_action_cnt, 0)
            + IFNULL(tryon_gen_panel_click_cnt, 0)
            + IFNULL(tryon_gen_panel_click_action_through_rate, 0)
            + IFNULL(tryon_gen_panel_click_pv_through_rate, 0)
            + IFNULL(tryon_complete_pv_cnt, 0)
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

      --event source
      cal_pre_refer,
      cal_pre_refer_ap_name,
      cal_pre_event_source,

      --task info
      task_model,
      task_type,

      --home
      home_pv_cnt,
      if(refer = 'home',user_device_id,NULL) as home_device_id,      

      --Tryon 
      tryon_pv_cnt,
      if(
        ((
          (refer = 'home' and ap_name like 'ap_dual_column%btn' and ap_name not like 'ap_dual_column%like%')
          or 
          ((ap_name like '%try_on%btn' or ap_name like '%retry%') and ap_name not in ('ap_try_on_history_list_item_delete_btn'))            
        )
        and event_name='select_item' 
        and event_method = 'click')
        or
        (event_name='select_item'  and event_method = 'shake')
        ,user_device_id,NULL) as tryon_device_id,

      --Tryon Select Panel
      tryon_select_panel_pv_cnt,
      tryon_select_panel_confirm_click_cnt,
      if(refer = "try_on_select_panel",user_device_id,null) as tryon_select_panel_device_id,

      --Tryon Gen
      tryon_gen_panel_pv_cnt,
      tryon_gen_panel_pv_cnt_2_0,
      tryon_gen_action_cnt,
      tryon_gen_panel_click_cnt,
      tryon_gen_panel_click_pv_through_rate,
      tryon_gen_panel_click_action_through_rate,
      if(event_name='select_item' and event_action_type in ('try_on','try_on_no_avatar'),user_device_id,null) as tryon_gen_device_id,

      --Tryon Complete
      tryon_complete_pv_cnt,
      if(event_action_type = 'try_on_complete' ,user_device_id,null) as tryon_complete_device_id
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

      --event source
      cal_pre_refer,
      cal_pre_refer_ap_name,
      cal_pre_event_source,

      --task_info
      task_model,
      task_type,

      --home
      home_pv_cnt,
      home_device_id,

      --Tryon 
      tryon_pv_cnt,
      tryon_device_id,

      --Tryon Select Panel
      tryon_select_panel_pv_cnt,
      tryon_select_panel_confirm_click_cnt,
      tryon_select_panel_device_id,

      --Tryon Gen
      tryon_gen_panel_pv_cnt,
      tryon_gen_panel_pv_cnt_2_0,
      tryon_gen_action_cnt,
      tryon_gen_panel_click_cnt,
      tryon_gen_panel_click_action_through_rate,
      tryon_gen_panel_click_pv_through_rate,
      tryon_gen_device_id,

      --Tryon Complete
      tryon_complete_pv_cnt,
      tryon_complete_device_id

    FROM base_dws_data_with_uv
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
