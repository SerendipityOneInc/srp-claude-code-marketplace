SELECT
        
        dt_param AS period_end_date,
        
        DATE_SUB(dt_param, INTERVAL 6 DAY) AS period_start_date,
        platform,
        app_version,
        country_name,
        user_tenure_type,
        user_login_type,
        user_group,
        
        -- 用户数聚合 (7天汇总)
        SUM(create_replica_intention_user_cnt) AS create_replica_intention_user_cnt_7d_sum,
        SUM(create_replica_action_user_cnt) AS create_replica_action_user_cnt_7d_sum,
        SUM(use_default_avatar_btn_user_cnt) AS use_default_avatar_btn_user_cnt_7d_sum,
        SUM(set_face_btn_click_user_cnt) AS set_face_btn_click_user_cnt_7d_sum,
        SUM(set_body_btn_click_user_cnt) AS set_body_btn_click_user_cnt_7d_sum,
        SUM(set_model_user_cnt) AS set_model_user_cnt_7d_sum,
        SUM(default_upload_by_camera_user_cnt) AS default_upload_by_camera_user_cnt_7d_sum,
        SUM(default_upload_by_album_user_cnt) AS default_upload_by_album_user_cnt_7d_sum,
        SUM(confirm_default_avatar_user_cnt) AS confirm_default_avatar_user_cnt_7d_sum,
        SUM(upload_selfie_btn_user_cnt) AS upload_selfie_btn_user_cnt_7d_sum,
        SUM(selfie_upload_by_album_user_cnt) AS selfie_upload_by_album_user_cnt_7d_sum,
        SUM(selfie_upload_by_camera_user_cnt) AS selfie_upload_by_camera_user_cnt_7d_sum,
        SUM(avatar_selfie_check_pass_user_cnt) AS avatar_selfie_check_pass_user_cnt_7d_sum,
        SUM(avatar_selfie_check_fail_user_cnt) AS avatar_selfie_check_fail_user_cnt_7d_sum,
        SUM(avatar_generate_btn_click_user_cnt) AS avatar_generate_btn_click_user_cnt_7d_sum,
        SUM(avatar_gen_click_user_cnt) AS avatar_gen_click_user_cnt_7d_sum,
        
        -- PV数聚合 (7天汇总)
        SUM(create_replica_intention_pv_cnt) AS create_replica_intention_pv_cnt_7d_sum,
        SUM(create_replica_action_pv_cnt) AS create_replica_action_pv_cnt_7d_sum,
        SUM(use_default_avatar_btn_click_cnt) AS use_default_avatar_btn_click_cnt_7d_sum,
        SUM(set_face_btn_click_cnt) AS set_face_btn_click_cnt_7d_sum,
        SUM(set_body_btn_click_cnt) AS set_body_btn_click_cnt_7d_sum,
        SUM(set_model_click_cnt) AS set_model_click_cnt_7d_sum,
        SUM(default_upload_by_camera_cnt) AS default_upload_by_camera_cnt_7d_sum,
        SUM(default_upload_by_album_cnt) AS default_upload_by_album_cnt_7d_sum,
        SUM(confirm_default_avatar_click_cnt) AS confirm_default_avatar_click_cnt_7d_sum,
        SUM(upload_selfie_btn_click_cnt) AS upload_selfie_btn_click_cnt_7d_sum,
        SUM(selfie_upload_by_album_click_cnt) AS selfie_upload_by_album_click_cnt_7d_sum,
        SUM(selfie_upload_by_camera_click_cnt) AS selfie_upload_by_camera_click_cnt_7d_sum,
        SUM(avatar_selfie_check_pass_cnt) AS avatar_selfie_check_pass_cnt_7d_sum,
        SUM(avatar_selfie_check_fail_cnt) AS avatar_selfie_check_fail_cnt_7d_sum,
        SUM(avatar_generate_btn_click_cnt) AS avatar_generate_btn_click_cnt_7d_sum,
        SUM(avatar_gen_click_cnt) AS avatar_gen_click_cnt_7d_sum,
        
        -- 其他指标 (7天汇总)
        SUM(DAU) AS DAU_7d_sum,
        SUM(bd_avatar_validated_cnt) AS bd_avatar_validated_cnt_7d_sum,
        SUM(bd_avatar_validated_user_cnt) AS bd_avatar_validated_user_cnt_7d_sum,
        SUM(bd_avatar_failed_cnt) AS bd_avatar_failed_cnt_7d_sum,
        SUM(bd_avatar_failed_user_cnt) AS bd_avatar_failed_user_cnt_7d_sum,
        SUM(bd_avatar_discarded_cnt) AS bd_avatar_discarded_cnt_7d_sum,
        SUM(bd_avatar_discarded_user_cnt) AS bd_avatar_discarded_user_cnt_7d_sum,
        SUM(bd_avatar_refined_cnt) AS bd_avatar_refined_cnt_7d_sum,
        SUM(bd_avatar_refined_user_cnt) AS bd_avatar_refined_user_cnt_7d_sum,
        SUM(bd_avatar_selected_cnt) AS bd_avatar_selected_cnt_7d_sum,
        SUM(bd_avatar_selected_user_cnt) AS bd_avatar_selected_user_cnt_7d_sum
        
    FROM favie_rpt.rpt_gensmo_avatar_full_penetration_funnel_inc_1d 
    WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 6 DAY) AND dt_param
      AND dt IS NOT NULL  -- 数据有效性检查
    GROUP BY
        platform,
        app_version,
        country_name,
        user_tenure_type,
        user_login_type,
        user_group