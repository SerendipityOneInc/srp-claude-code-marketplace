BEGIN
    -- 删除指定日期的数据
    DELETE FROM `favie_rpt.rpt_favie_gensmo_video_tryon_metric_inc_1d`
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO `favie_rpt.rpt_favie_gensmo_video_tryon_metric_inc_1d` (
        dt,
        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        -- app 整体指标
        active_user_d1_cnt,
        -- video tryon 指标
        video_tryon_trigger_cnt,
        video_tryon_trigger_user_cnt,
        video_tryon_complete_task_cnt,
        video_tryon_complete_user_cnt,
        video_tryon_play_complete_task_cnt,
        video_tryon_play_complete_user_cnt,
        video_tryon_retry_task_cnt,
        video_tryon_retry_user_cnt,
        video_tryon_switch_mode_task_cnt,
        video_tryon_switch_mode_user_cnt,
        video_tryon_save_task_cnt,
        video_tryon_save_user_cnt,
        video_tryon_unsave_task_cnt,
        video_tryon_unsave_user_cnt,
        video_tryon_like_task_cnt,
        video_tryon_like_user_cnt,
        video_tryon_dislike_task_cnt,
        video_tryon_dislike_user_cnt,
        video_tryon_download_task_cnt,
        video_tryon_download_user_cnt
    )
    SELECT
        dt,
        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        -- app 整体指标
        active_user_d1_cnt,
        -- video tryon 指标
        video_tryon_trigger_cnt,
        video_tryon_trigger_user_cnt,
        video_tryon_complete_task_cnt,
        video_tryon_complete_user_cnt,
        video_tryon_play_complete_task_cnt,
        video_tryon_play_complete_user_cnt,
        video_tryon_retry_task_cnt,
        video_tryon_retry_user_cnt,
        video_tryon_switch_mode_task_cnt,
        video_tryon_switch_mode_user_cnt,
        video_tryon_save_task_cnt,
        video_tryon_save_user_cnt,
        video_tryon_unsave_task_cnt,
        video_tryon_unsave_user_cnt,
        video_tryon_like_task_cnt,
        video_tryon_like_user_cnt,
        video_tryon_dislike_task_cnt,
        video_tryon_dislike_user_cnt,
        video_tryon_download_task_cnt,
        video_tryon_download_user_cnt
    FROM `favie_rpt.rpt_favie_gensmo_video_tryon_metric_inc_1d_function`(dt_param);
    call favie_dw.record_partition('rpt_favie_gensmo_video_tryon_metric_inc_1d', dt_param,"");
END