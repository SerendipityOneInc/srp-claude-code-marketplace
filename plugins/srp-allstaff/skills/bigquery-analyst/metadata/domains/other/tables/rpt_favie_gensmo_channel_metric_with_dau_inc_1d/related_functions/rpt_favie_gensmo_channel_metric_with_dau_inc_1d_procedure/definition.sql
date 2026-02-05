begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_channel_metric_with_dau_inc_1d (
        dt,

        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,

        -- app 应用整体指标
        active_user_d1_cnt,
        channel_user_cnt,
        user_channel_cnt,
        

        -- 用户数指标
        item_task_gen_user_cnt,
        item_task_complete_user_cnt,
        item_task_detail_user_cnt,
        item_task_save_user_cnt,
        item_task_unsave_user_cnt,
        item_task_like_user_cnt,
        item_task_cancel_like_user_cnt,
        item_task_share_user_cnt,
        item_task_download_user_cnt,
        item_task_external_jump_user_cnt
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

        -- app 应用整体指标
        active_user_d1_cnt,
        channel_user_cnt,
        user_channel_cnt,

        -- 用户数指标
        item_task_gen_user_cnt,
        item_task_complete_user_cnt,
        item_task_detail_user_cnt,
        item_task_save_user_cnt,
        item_task_unsave_user_cnt,
        item_task_like_user_cnt,
        item_task_cancel_like_user_cnt,
        item_task_share_user_cnt,
        item_task_download_user_cnt,
        item_task_external_jump_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_channel_with_dau_metric_inc_1d_function(dt_param);
end