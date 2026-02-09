begin
    DELETE FROM favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d (
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

    FROM favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d_function(dt_param);
end