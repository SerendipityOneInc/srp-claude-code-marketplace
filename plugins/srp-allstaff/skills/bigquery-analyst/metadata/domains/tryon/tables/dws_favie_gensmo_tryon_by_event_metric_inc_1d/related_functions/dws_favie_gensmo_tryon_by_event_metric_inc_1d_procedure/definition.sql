begin
    DELETE FROM favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,

        cal_pre_refer,
        cal_pre_refer_ap_name,
        cal_pre_event_source,

        home_pv_cnt,
        home_device_id,

        tryon_intention_cnt,
        tryon_intention_device_id,

        tryon_select_panel_pv_cnt,
        tryon_select_panel_confirm_click_cnt,
        tryon_select_panel_device_id,

        tryon_gen_action_cnt,
        tryon_gen_action_device_id,
        tryon_gen_action_cnt_2_0,
        tryon_gen_action_device_id_2_0,

        tryon_complete_cnt,
        tryon_complete_device_id,
        tryon_channel_click_cnt,
        tryon_channel_click_device_id,

        tryon_complete_detail_task_cnt,
        tryon_complete_detail_device_id,
        tryon_gen_panel_pv_cnt,
        tryon_gen_panel_click_cnt,
        tryon_gen_panel_device_id,

        tryon_change_scene_intention_cnt,
        tryon_change_scene_intention_device_id,
        tryon_change_scene_gen_cnt,
        tryon_change_scene_gen_device_id,
        tryon_change_scene_browse_cnt,
        tryon_change_scene_browse_device_id,

        tryon_load_fail_cnt,
        tryon_load_fail_device_id
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,

        cal_pre_refer,
        cal_pre_refer_ap_name,
        cal_pre_event_source,

        home_pv_cnt,
        home_device_id,

        tryon_intention_cnt,
        tryon_intention_device_id,

        tryon_select_panel_pv_cnt,
        tryon_select_panel_confirm_click_cnt,
        tryon_select_panel_device_id,

        tryon_gen_action_cnt,
        tryon_gen_action_device_id,
        tryon_gen_action_cnt_2_0,
        tryon_gen_action_device_id_2_0,

        tryon_complete_cnt,
        tryon_complete_device_id,
        tryon_channel_click_cnt,
        tryon_channel_click_device_id,

        tryon_complete_detail_task_cnt,
        tryon_complete_detail_device_id,
        tryon_gen_panel_pv_cnt,
        tryon_gen_panel_click_cnt,
        tryon_gen_panel_device_id,

        tryon_change_scene_intention_cnt,
        tryon_change_scene_intention_device_id,
        tryon_change_scene_gen_cnt,
        tryon_change_scene_gen_device_id,
        tryon_change_scene_browse_cnt,
        tryon_change_scene_browse_device_id,
        tryon_load_fail_cnt,
        tryon_load_fail_device_id
    FROM favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d_function(dt_param);
end