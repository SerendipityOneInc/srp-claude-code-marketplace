begin
    DELETE FROM favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        task_model,
        task_type,

        tryon_server_complete_item_cnt,
        tryon_server_complete_user_cnt,

        tryon_complete_item_cnt,
        tryon_complete_user_cnt,
        tryon_complete_list_item_cnt,
        tryon_complete_list_user_cnt,
        tryon_complete_list_item_cnt_2_0,
        tryon_complete_list_user_cnt_2_0,
        tryon_complete_detail_item_cnt,
        tryon_complete_detail_user_cnt,

        tryon_change_scene_intention_item_cnt,
        tryon_change_scene_intention_user_cnt,
        tryon_change_scene_gen_item_cnt,
        tryon_change_scene_gen_user_cnt,
        tryon_change_scene_browse_item_cnt,
        tryon_change_scene_browse_user_cnt,

        tryon_retry_item_cnt,
        tryon_retry_user_cnt,

        tryon_save_item_cnt,
        tryon_save_user_cnt,
        tryon_unsave_item_cnt,
        tryon_unsave_user_cnt,

        tryon_download_item_cnt,
        tryon_download_user_cnt,

        tryon_like_item_cnt,
        tryon_like_user_cnt,
        tryon_cancel_like_item_cnt,
        tryon_cancel_like_user_cnt,

        tryon_share_item_cnt,
        tryon_share_user_cnt,

        tryon_post_item_cnt,
        tryon_post_user_cnt,

        tryon_dislike_item_cnt,
        tryon_dislike_user_cnt,
        tryon_cancel_dislike_item_cnt,
        tryon_cancel_dislike_user_cnt
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

        task_model,
        task_type,

        tryon_server_complete_item_cnt,
        tryon_server_complete_user_cnt,

        tryon_complete_item_cnt,
        tryon_complete_user_cnt,
        tryon_complete_list_item_cnt,
        tryon_complete_list_user_cnt,
        tryon_complete_list_item_cnt_2_0,
        tryon_complete_list_user_cnt_2_0,
        tryon_complete_detail_item_cnt,
        tryon_complete_detail_user_cnt,

        tryon_change_scene_intention_item_cnt,
        tryon_change_scene_intention_user_cnt,
        tryon_change_scene_gen_item_cnt,
        tryon_change_scene_gen_user_cnt,
        tryon_change_scene_browse_item_cnt,
        tryon_change_scene_browse_user_cnt,

        tryon_retry_item_cnt,
        tryon_retry_user_cnt,

        tryon_save_item_cnt,
        tryon_save_user_cnt,
        tryon_unsave_item_cnt,
        tryon_unsave_user_cnt,

        tryon_download_item_cnt,
        tryon_download_user_cnt,

        tryon_like_item_cnt,
        tryon_like_user_cnt,
        tryon_cancel_like_item_cnt,
        tryon_cancel_like_user_cnt,

        tryon_share_item_cnt,
        tryon_share_user_cnt,

        tryon_post_item_cnt,
        tryon_post_user_cnt,

        tryon_dislike_item_cnt,
        tryon_dislike_user_cnt,
        tryon_cancel_dislike_item_cnt,
        tryon_cancel_dislike_user_cnt
    FROM favie_dw.dws_favie_gensmo_tryon_by_item_metric_inc_1d_function(dt_param);
end