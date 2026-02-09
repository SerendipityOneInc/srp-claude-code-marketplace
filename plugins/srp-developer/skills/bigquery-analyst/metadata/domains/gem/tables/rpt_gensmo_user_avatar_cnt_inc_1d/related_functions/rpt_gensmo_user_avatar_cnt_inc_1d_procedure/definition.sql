begin
    DELETE FROM favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d
    WHERE dt is not null and dt = dt_param;
    
    INSERT INTO favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d
    (
        dt,
        
        device_id,
        user_group,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        country_name,
        validated_task_cnt,
        failed_task_cnt,
        discarded_task_cnt,
        refined_task_cnt,
        selected_task_cnt,
        new_avatar_cnt,
        valid_avatar_cnt,
        invalid_avatar_cnt,
        validated_task_device_id,
        failed_task_device_id,
        discarded_task_device_id,
        refined_task_device_id,
        selected_task_device_id,
        new_avatar_device_id,
        valid_avatar_device_id,
        invalid_avatar_device_id
    )
    SELECT
        dt,
        
        device_id,
        user_group,
        user_login_type,
        user_tenure_type,
        platform,
        app_version,
        country_name,
        validated_task_cnt,
        failed_task_cnt,
        discarded_task_cnt,
        refined_task_cnt,
        selected_task_cnt,
        new_avatar_cnt,
        valid_avatar_cnt,
        invalid_avatar_cnt,
        validated_task_device_id,
        failed_task_device_id,
        discarded_task_device_id,
        refined_task_device_id,
        selected_task_device_id,
        new_avatar_device_id,
        valid_avatar_device_id,
        invalid_avatar_device_id
    FROM favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d_function(dt_param) ;

END