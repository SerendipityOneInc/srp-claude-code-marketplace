# dws_favie_gensmo_search_by_event_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-11-10
**最后更新**: 2025-11-10

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
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      concat(
        coalesce(refer,"unknown")
        ,"@",coalesce(ap_name,"unknown")) as event_source,

      event_items,

      (
        select event_item.item_id from unnest(event_items) as event_item
        where event_item.item_type in ('general_collage','collage_gen_task')
        limit 1
      ) as collage_task_id,

      (
  SELECT ei.item_name
  FROM UNNEST(t.event_items) ei
  WHERE ei.item_type = 'model'
  LIMIT 1
) AS model_type,
      CASE 
        WHEN refer = 'collage_gen' THEN CASE 
          WHEN ap_name = 'ap_screen' AND event_method = 'screenshot' AND event_action_type = 'external_share' THEN 'collage_screenshot_share'
          WHEN ap_name = 'ap_share_btn' AND event_method = 'click' THEN 'collage_share_click'
          WHEN ap_name = 'ap_save_btn' AND event_method = 'save' THEN 'collage_save_click'
          WHEN ap_name = 'ap_menu_download_btn' AND event_method = 'click' AND event_action_type = 'download' THEN 'collage_menu_download'
          WHEN ap_name = 'ap_screen' AND event_method = 'page_view' THEN 'collage_page_view'
          WHEN ap_name = 'ap_screen' AND event_method = 'screenshot' AND event_action_type = 'default' THEN 'collage_screenshot'
          WHEN ap_name = 'ap_initialize_post_btn' AND event_method = 'click' AND event_action_type = 'initialize_post' THEN 'collage_post_click'
          WHEN ap_name = 'ap_like_btn' AND event_method = 'click' AND event_action_type = 'feedback_like' THEN 'collage_like_click'
          WHEN ap_name = 'ap_product_list_product' AND event_method = 'click' AND event_action_type = 'product_external_jump' THEN 'collage_product_click_jump'
          WHEN ap_name = 'ap_product_list_product' AND event_method = 'click' AND event_action_type = 'enter_product_detail' THEN 'collage_product_click_detail'
          WHEN ap_name = 'ap_try_on_btn' AND event_method = 'click' AND event_action_type = 'try_on_select' THEN 'collage_try_on'
        END
        WHEN refer = 'channel' THEN CASE
          WHEN ap_name = 'ap_collage_list' AND event_method = 'click' AND event_action_type = 'enter_collage_gen' THEN 'channel_collage_click'
          WHEN ap_name = 'ap_try_on_result_list' AND event_method = 'click' AND event_action_type = 'enter_try_on_detail' THEN 'channel_try_on'
          WHEN ap_name = 'ap_save_btn' AND event_method = 'click' AND event_action_type = 'save' THEN 'channel_save'
          WHEN ap_name = 'ap_product_list_product' AND event_method = 'click' AND event_action_type = 'enter_product_detail' THEN 'channel_product_click'
        END
      END AS search_category,

      --event source
      cal_pre_refer,
      cal_pre_refer_event.ap_name AS cal_pre_refer_ap_name,
      concat(coalesce(cal_pre_refer,"unknown"),"@",coalesce(cal_pre_refer_event.ap_name,"unknown")) as cal_pre_event_source

    FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d t
    where 1=1
      and refer_group = 'valid'
      and event_version='1.0.0' 
      and dt = dt_param
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
      ,model_type

      --event source
      ,cal_pre_refer
      ,cal_pre_refer_ap_name
      ,cal_pre_event_source

      --home
      ,sum(if(refer = 'home' and event_method = 'page_view',1,0)) as home_pv_cnt

      --Collage Intention
      ,sum(if(
            (
              event_name='select_item' 
              and event_method = 'click'
              and 
                ((ap_name  in ('ap_remix_btn','ap_inspo_list_inspo','ap_top_navibar_search_input_box','ap_input_box','ap_edit_your_input_btn','ap_album_btn','ap_switch_camera','ap_remix_bottom_btn','ap_flashlight_btn','ap_switch_mode_STYLE THIS PIECE') and refer!='search_boot')    
                or (ap_name like '%retry%' and event_action_type in ('collage_gen')) 
                or (ap_name like '%shutter%' and event_action_type in ('collage_gen'))
                or ap_name='ap_collage_list')  
            )
            or
            (
              event_name='select_item'  
              and event_method = 'click' 
              and refer = 'collage_gen'
              and event_action_type in ('collage_gen')
            )
            or
            (
              event_name='select_item'  
              and event_method = 'click' 
              and ap_name = 'ap_navibar_style'
              and event_action_type in ('initialize_search')
              and refer!='search_boot'
            )
            -- 暂时忽略shake，shake事件上报偏高
            ,1,0)) as collage_intention_cnt

      --Search Boot Panel
      ,sum(CASE WHEN refer in ('search_boot') and event_method='page_view'and event_name='select_item' THEN 1 ELSE 0 end )as search_boot_panel_pv_cnt
      ,sum(CASE WHEN refer in ('search_boot') and ap_name='ap_generate_btn' and event_method='click' and event_name='select_item' THEN 1 ELSE 0 end) as search_boot_panel_generate_click_cnt
      
      --Collage Gen Action
      ,sum(CASE WHEN event_action_type in ('collage_gen') and ap_name like ("ap_%") and event_method in ('click') and event_name='select_item' THEN 1 ELSE 0 END) as collage_gen_action_cnt
      ,sum(
        if(
            (
                (
                event_name='select_item' 
                and event_method = 'click'
                and 
                ((ap_name  in ('ap_remix_btn','ap_inspo_list_inspo','ap_generate_btn','ap_collage_list_entity_list','ap_collage_list_entity_list_entity') and event_action_type in ('collage_gen'))    
                or (ap_name like '%retry%' and event_action_type in ('collage_gen')) 
                or (ap_name like '%shutter%' and event_action_type in ('collage_gen'))
                or ap_name='ap_collage_list')   
                     
                )
                
              )
              and event_action_type is not null 
              
            or
            (
              refer in ('search_boot')
              and event_action_type in ('collage_gen') 
            ) 
            ,1,0)
      ) as collage_gen_action_cnt_2_0

      --Collage Complete
      ,sum(CASE WHEN
          (event_action_type = 'collage_gen_complete')
         THEN 1 ELSE 0 END) as collage_complete_cnt
      ,sum(CASE WHEN 
          (refer = 'channel' and event_method = 'click')
        THEN 1 ELSE 0 END) as collage_channel_click_cnt
      ,count(distinct CASE WHEN event_action_type in ('enter_collage_detail')  THEN collage_task_id  ELSE null END) as collage_complete_detail_task_cnt
      ,sum(CASE WHEN refer = "collage_gen"  and event_method = 'page_view'  THEN 1 ELSE 0 END) as collage_gen_panel_pv_cnt
      ,sum(CASE WHEN refer = "collage_gen"  and event_method = 'click'  THEN 1 ELSE 0 END) as collage_gen_panel_click_cnt
      
      --search category
      ,SUM(CASE WHEN search_category IN ('channel_product_click', 'collage_product_click_jump', 'collage_product_click_detail') THEN 1 ELSE 0 END) AS search_result_product_click_cnt
      ,sum(case when search_category in ('collage_screenshot_share','collage_share_click','collage_save_click','collage_menu_down_load','collage_screenshot','collage_post_click','collage_like_click','channel_try_on','collage_try_on','channel_save')  then 1 end) as search_result_positive_cnt
      ,SUM(CASE WHEN search_category = 'channel_collage_click' THEN 1 ELSE 0 END) AS channel_collage_click_cnt

      --channel
      ,sum(case when refer='channel' and event_method='page_view' and ap_name='ap_screen' then 1 end) as channel_screen_cnt

    from base_events_data
    group by dt
      ,device_id
      ,refer
      ,ap_name
      ,event_name
      ,event_method
      ,event_action_type
      ,event_source
      ,model_type
      ,cal_pre_refer
      ,cal_pre_refer_ap_name
      ,cal_pre_event_source
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
        FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)

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
      t1.model_type,

      --event source
      t1.cal_pre_refer,
      t1.cal_pre_refer_ap_name,
      t1.cal_pre_event_source,

      --home
      t1.home_pv_cnt,

      --collage Intention
      t1.collage_intention_cnt,

      --collage Select Panel
      t1.search_boot_panel_pv_cnt,
      t1.search_boot_panel_generate_click_cnt,

      --collage Gen Action
      t1.collage_gen_action_cnt,
      t1.collage_gen_action_cnt_2_0,

      --collage Complete
      t1.collage_complete_cnt,
      t1.collage_channel_click_cnt,
      t1.collage_complete_detail_task_cnt,
      t1.collage_gen_panel_pv_cnt,
      t1.collage_gen_panel_click_cnt,

      --search category
      t1.search_result_product_click_cnt,
      t1.search_result_positive_cnt,
      t1.channel_collage_click_cnt,

      --channel
      t1.channel_screen_cnt
    from (
      select * from base_dws_data 
      where (
            IFNULL(home_pv_cnt, 0)
            + IFNULL(collage_intention_cnt, 0)
            + IFNULL(search_boot_panel_pv_cnt, 0)
            + IFNULL(search_boot_panel_generate_click_cnt, 0)
            + IFNULL(collage_gen_action_cnt, 0)
            + IFNULL(collage_gen_action_cnt_2_0, 0)
            + IFNULL(collage_complete_cnt, 0)
            + IFNULL(collage_channel_click_cnt, 0)
            + IFNULL(collage_complete_detail_task_cnt, 0)
            + IFNULL(collage_gen_panel_pv_cnt, 0)
            + IFNULL(collage_gen_panel_click_cnt, 0)
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
      model_type,

      --event source
      cal_pre_refer,
      cal_pre_refer_ap_name,
      cal_pre_event_source,

      --home
      home_pv_cnt,
      if(refer = 'home',user_device_id,NULL) as home_device_id,      

      --collage Intention
      collage_intention_cnt,
      if((
              event_name='select_item' 
              and event_method = 'click'
              and 
                ((ap_name  in ('ap_remix_btn','ap_inspo_list_inspo','ap_top_navibar_search_input_box','ap_input_box','ap_edit_your_input_btn','ap_album_btn','ap_switch_camera','ap_remix_bottom_btn','ap_flashlight_btn','ap_switch_mode_STYLE THIS PIECE') and refer!='search_boot')    
                or (ap_name like '%retry%' and event_action_type in ('collage_gen')) 
                or (ap_name like '%shutter%' and event_action_type in ('collage_gen'))
                or ap_name='ap_collage_list')  
            )
            or
            (
              event_name='select_item'  
              and event_method = 'click' 
              and refer = 'collage_gen'
              and event_action_type in ('collage_gen')
            )
            or
            (
              event_name='select_item'  
              and event_method = 'click' 
              and ap_name = 'ap_navibar_style'
              and event_action_type in ('initialize_search')
              and refer!='search_boot'
            )
            
        ,user_device_id,NULL) as collage_intention_device_id,

      --collage Select Panel
      search_boot_panel_pv_cnt,
      search_boot_panel_generate_click_cnt,
      if(refer = "search_boot",user_device_id,null) as search_boot_panel_device_id,

      --collage Gen Action
      collage_gen_action_cnt,
      collage_gen_action_cnt_2_0,
      if(event_name='select_item' and event_action_type in ('collage_gen'),user_device_id,null) as collage_gen_action_device_id,
      if(
        (
                (
                event_name='select_item' 
                and event_method = 'click'
                and 
                ((ap_name  in ('ap_remix_btn','ap_inspo_list_inspo','ap_generate_btn','ap_collage_list_entity_list','ap_collage_list_entity_list_entity') and event_action_type in ('collage_gen'))    
                or (ap_name like '%retry%' and event_action_type in ('collage_gen')) 
                or (ap_name like '%shutter%' and event_action_type in ('collage_gen'))
                or ap_name='ap_collage_list')   
                     
                )
                
              )
              and event_action_type is not null 
              
            or
            (
              refer in ('search_boot')
              and event_action_type in ('collage_gen') 
            )
      ,user_device_id,null) as collage_gen_action_device_id_2_0,

      --collage Complete
      collage_complete_cnt,
      collage_channel_click_cnt,
      if(event_action_type = 'collage_gen_complete' ,user_device_id,null) as collage_complete_device_id,
      if(collage_channel_click_cnt>0,user_device_id,null) as collage_channel_click_device_id,

      --collage Complete Detail
      collage_complete_detail_task_cnt,
      collage_gen_panel_pv_cnt,
      collage_gen_panel_click_cnt,
      if(event_action_type in ('enter_collage_detail'),user_device_id,null) as collage_complete_detail_device_id,
      if(refer = "collage_gen" ,user_device_id,null) as collage_gen_panel_device_id,

      --search category
      search_result_product_click_cnt,
      search_result_positive_cnt,
      channel_collage_click_cnt,

      --channel
      channel_screen_cnt,
      IF(refer = 'channel' AND ap_name = 'ap_screen', user_device_id, NULL) AS channel_device_id

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
      model_type,

      --event source
      cal_pre_refer,
      cal_pre_refer_ap_name,
      cal_pre_event_source,

      --home
      home_pv_cnt,
      home_device_id,

      --collage Intention
      collage_intention_cnt,
      collage_intention_device_id,

      --collage Select Panel
      search_boot_panel_pv_cnt,
      search_boot_panel_generate_click_cnt,
      search_boot_panel_device_id,

      --collage Gen Action
      collage_gen_action_cnt,
      collage_gen_action_device_id,
      collage_gen_action_cnt_2_0,
      collage_gen_action_device_id_2_0,

      --collage Complete
      collage_complete_cnt,
      collage_complete_device_id,
      collage_channel_click_cnt,
      collage_channel_click_device_id,
      collage_complete_detail_task_cnt,
      collage_complete_detail_device_id,
      collage_gen_panel_pv_cnt,
      collage_gen_panel_click_cnt,
      collage_gen_panel_device_id,

      --search category
      search_result_product_click_cnt,
      search_result_positive_cnt,
      channel_collage_click_cnt,

      --channel
      channel_screen_cnt,
      channel_device_id

    FROM base_dws_data_with_uv
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
