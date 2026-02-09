WITH user_info_with_group AS (
    SELECT 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)
  )

  SELECT
      dt_param AS dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      device_id,
      'try_on_gen' AS refer,
      'ap_try_on_btn' AS ap_name,
      'select_item' AS event_name,
      'click' AS event_method,
      'try_on' AS event_action_type,
      'try_on_gen@ap_try_on_btn' AS event_source,
      'home' AS cal_pre_refer,
      'ap_screen' AS cal_pre_refer_ap_name,
      'home@ap_screen' AS cal_pre_event_source,
      0 AS tryon_change_scene_browse_cnt
    FROM user_info_with_group