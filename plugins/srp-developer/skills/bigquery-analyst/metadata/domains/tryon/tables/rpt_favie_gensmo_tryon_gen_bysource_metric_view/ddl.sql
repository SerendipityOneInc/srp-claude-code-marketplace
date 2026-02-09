CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_gen_bysource_metric_view`
AS select 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      sum(tryon_gen_action_cnt) as tryon_gen_action_cnt,
      sum(tryon_gen_panel_pv_cnt) as tryon_gen_panel_pv_cnt,
      sum(tryon_gen_panel_click_cnt) as tryon_gen_panel_click_cnt,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and event_action_type= "go_back" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_back_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_try_on_result_entity_list_entity" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_try_on_result_entity_list_entity,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_menu_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_menu_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_retry_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_retry_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_menu_download_look_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_menu_download_look_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_comment_list_search_advice_bubble" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_comment_list_search_advice_bubble,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_like_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_like_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_scenario_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_scenario_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_remix_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_remix_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_menu_ai_closet_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_menu_ai_closet_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_share_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_share_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name= "ap_dislike_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) as ap_dislike_btn,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name ="ap_screen" and event_name='select_item' and event_method='screenshot' THEN 1 ELSE 0 END) AS screenshot,
      sum(CASE WHEN refer = 'try_on_gen' and cal_pre_refer not in ("ai_wardrobe","avatar_manage")and ap_name ="ap_save_btn" and event_name='select_item' and event_method='click' THEN 1 ELSE 0 END) AS ap_save_btn
       
  from srpproduct-dc37e.favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d 
  group by 
    dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group;