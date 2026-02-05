CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d_view`
AS select 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      item_task_type,
      item_task_model,

      count(distinct valid_device_id) as channel_user_cnt,
      count(distinct channel_id) as user_channel_cnt,
      --tryon metrics
      sum(if(item_type in ("try_on_task","tryon_task"),item_task_list_pv_cnt,0)) as tryon_task_list_pv_cnt,
      sum(if(item_type in ("try_on_task","tryon_task"),item_task_list_item_cnt,0)) as tryon_task_list_item_cnt,

      sum(if(event_action_type in ("try_on","try_on_no_avatar"),item_task_gen_pv_cnt,0)) as tryon_task_gen_pv_cnt,
      sum(if(event_action_type in ("try_on","try_on_no_avatar"),item_task_gen_item_cnt,0)) as tryon_task_gen_item_cnt,

      sum(if(event_action_type in ("try_on_complete","tryon_complete"),item_task_complete_pv_cnt,0)) as tryon_task_complete_pv_cnt,
      sum(if(event_action_type in ("try_on_complete","tryon_complete"),item_task_complete_item_cnt,0)) as tryon_task_complete_item_cnt,

      sum(if(event_action_type in ("enter_tryon_detail","enter_try_on_detail"),item_task_detail_pv_cnt,0)) as tryon_task_detail_pv_cnt,
      sum(if(event_action_type in ("enter_tryon_detail","enter_try_on_detail"),item_task_detail_item_cnt,0)) as tryon_task_detail_item_cnt,

      -- tryon interaction metrics
      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "save",item_task_save_cnt,0)) as tryon_task_save_cnt,
      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "save",item_task_save_item_cnt,0)) as tryon_task_save_item_cnt,

      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "share",item_task_share_cnt,0)) as tryon_task_share_cnt,
      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "share",item_task_share_item_cnt,0)) as tryon_task_share_item_cnt,

      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "like",item_task_like_cnt,0)) as tryon_task_like_cnt,
      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "like",item_task_like_item_cnt,0)) as tryon_task_like_item_cnt,

      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "download",item_task_download_cnt,0)) as tryon_task_download_cnt,
      sum(if(item_type in ("try_on_task","tryon_task") and event_action_type = "download",item_task_download_item_cnt,0)) as tryon_task_download_item_cnt,

      --tryon scene
      sum(if(event_action_type = 'try_on_scene_gen',item_task_gen_pv_cnt,0)) as tryon_scene_task_gen_pv_cnt,
      sum(if(event_action_type = 'try_on_scene_gen',item_task_gen_item_cnt,0)) as tryon_scene_task_gen_item_cnt,

      --collage metrics
      sum(if(item_type in ("collage_gen_task"),item_task_list_pv_cnt,0)) as collage_task_list_pv_cnt,
      sum(if(item_type in ("collage_gen_task"),item_task_list_item_cnt,0)) as collage_task_list_item_cnt,

      sum(if(event_action_type in ("collage_gen"),item_task_gen_pv_cnt,0)) as collage_task_gen_pv_cnt,
      sum(if(event_action_type in ("collage_gen"),item_task_gen_item_cnt,0)) as collage_task_gen_item_cnt,

      sum(if(event_action_type in ("collage_gen_complete"),item_task_complete_pv_cnt,0)) as collage_task_complete_pv_cnt,
      sum(if(event_action_type in ("collage_gen_complete"),item_task_complete_item_cnt,0)) as collage_task_complete_item_cnt,

      sum(if(event_action_type in ("enter_collage_gen"),item_task_detail_pv_cnt,0)) as collage_task_detail_pv_cnt,
      sum(if(event_action_type in ("enter_collage_gen"),item_task_detail_item_cnt,0)) as collage_task_detail_item_cnt,

      -- collage interaction metrics
      sum(if(item_type in ("collage_gen_task") and event_action_type = "save",item_task_save_cnt,0)) as collage_task_save_cnt,
      sum(if(item_type in ("collage_gen_task") and event_action_type = "save",item_task_save_item_cnt,0)) as collage_task_save_item_cnt,

      sum(if(item_type in ("collage_gen_task") and event_action_type = "share",item_task_share_cnt,0)) as collage_task_share_cnt,
      sum(if(item_type in ("collage_gen_task") and event_action_type = "share",item_task_share_item_cnt,0)) as collage_task_share_item_cnt,

      sum(if(item_type in ("collage_gen_task") and event_action_type = "like",item_task_like_cnt,0)) as collage_task_like_cnt,
      sum(if(item_type in ("collage_gen_task") and event_action_type = "like",item_task_like_item_cnt,0)) as collage_task_like_item_cnt,

      sum(if(item_type in ("collage_gen_task") and event_action_type = "download",item_task_download_cnt,0)) as collage_task_download_cnt,
      sum(if(item_type in ("collage_gen_task") and event_action_type = "download",item_task_download_item_cnt,0)) as collage_task_download_item_cnt,

      --product metrics
      sum(if(item_type in ("product"),item_task_list_pv_cnt,0)) as product_list_pv_cnt,
      sum(if(item_type in ("product"),item_task_list_item_cnt,0)) as product_list_item_cnt,

      sum(if(event_action_type in ("enter_product_detail"),item_task_detail_pv_cnt,0)) as product_detail_pv_cnt,
      sum(if(event_action_type in ("enter_product_detail"),item_task_detail_item_cnt,0)) as product_detail_item_cnt,

      -- product interaction metrics
      sum(if(item_type in ("product") and event_action_type = "save",item_task_save_cnt,0)) as product_save_cnt,
      sum(if(item_type in ("product") and event_action_type = "save",item_task_save_item_cnt,0)) as product_save_item_cnt,

      sum(if(item_type in ("product") and event_action_type = "share",item_task_share_cnt,0)) as product_share_cnt,
      sum(if(item_type in ("product") and event_action_type = "share",item_task_share_item_cnt,0)) as product_share_item_cnt,

      sum(if(item_type in ("product") and event_action_type = "like",item_task_like_cnt,0)) as product_task_like_cnt,
      sum(if(item_type in ("product") and event_action_type = "like",item_task_like_item_cnt,0)) as product_task_like_item_cnt,

      sum(if(item_type in ("product") and event_action_type = "download",item_task_download_cnt,0)) as product_download_cnt,
      sum(if(item_type in ("product") and event_action_type = "download",item_task_download_item_cnt,0)) as product_download_item_cnt,

      sum(if(item_type in ("product") and event_action_type = "product_external_jump",item_task_external_jump_cnt,0)) as product_external_jump_cnt,
      sum(if(item_type in ("product") and event_action_type = "product_external_jump",item_task_external_jump_item_cnt,0)) as product_external_jump_item_cnt


  from srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d
  where dt is not null
  group by
    dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    item_task_type,
    item_task_model;