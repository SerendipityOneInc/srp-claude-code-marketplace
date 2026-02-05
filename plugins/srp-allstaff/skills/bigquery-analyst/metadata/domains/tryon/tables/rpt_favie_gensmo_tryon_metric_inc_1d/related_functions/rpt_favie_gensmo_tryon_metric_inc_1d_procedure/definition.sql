BEGIN
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        tryon_trigger_cnt,
        tryon_trigger_user_cnt,
        tryon_request_cnt,
        tryon_request_user_cnt,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_user_cnt,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_user_cnt,
        tryon_complete_user_cnt,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_user_cnt,
        tryon_load_fail_task_cnt,
        tryon_load_fail_user_cnt,
        tryon_view_detail_task_cnt,
        tryon_view_detail_user_cnt
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        tryon_trigger_cnt,
        tryon_trigger_user_cnt,
        tryon_request_cnt,
        tryon_request_user_cnt,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_user_cnt,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_user_cnt,
        tryon_complete_user_cnt,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_user_cnt,
        tryon_load_fail_task_cnt,
        tryon_load_fail_user_cnt,
        tryon_view_detail_task_cnt,
        tryon_view_detail_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d_function(dt_param);
END