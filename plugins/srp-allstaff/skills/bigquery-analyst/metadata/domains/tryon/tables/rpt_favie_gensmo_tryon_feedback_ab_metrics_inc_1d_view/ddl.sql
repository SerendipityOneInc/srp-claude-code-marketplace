CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_feedback_ab_metrics_inc_1d_view`
AS WITH positive_feed_back AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,

            sum(tryon_complete_succeed_task_cnt) AS tryon_complete_succeed_task_cnt,
            count(distinct tryon_complete_succeed_device_id) AS tryon_complete_succeed_user_cnt,
            sum(tryon_complete_fail_task_cnt) AS tryon_complete_fail_task_cnt,
            count(distinct tryon_complete_fail_device_id) AS tryon_complete_fail_user_cnt,

            sum(tryon_load_fail_task_cnt) AS tryon_load_fail_task_cnt,
            count(distinct tryon_load_fail_device_id) AS tryon_load_fail_user_cnt,
            sum(tryon_load_succeed_task_cnt) AS tryon_load_succeed_task_cnt,
            count(distinct tryon_load_succeed_device_id) AS tryon_load_succeed_user_cnt,

            SUM(tryon_save_task_cnt) AS tryon_save_task_cnt,
            count(distinct tryon_save_device_id) AS tryon_save_user_cnt,
            SUM(tryon_download_task_cnt) AS tryon_download_task_cnt,
            count(distinct tryon_download_device_id) AS tryon_download_user_cnt,
            SUM(tryon_like_task_cnt) AS tryon_like_task_cnt,
            count(distinct tryon_like_device_id) AS tryon_like_user_cnt,
            SUM(tryon_dislike_task_cnt) AS tryon_dislike_task_cnt,
            count(distinct tryon_dislike_device_id) AS tryon_dislike_user_cnt,
            SUM(tryon_share_task_cnt) AS tryon_share_task_cnt,
            count(distinct tryon_share_device_id) AS tryon_share_user_cnt,
            SUM(tryon_post_task_cnt) AS tryon_post_task_cnt,
            count(distinct tryon_post_device_id) AS tryon_post_user_cnt,
            sum(tryon_view_product_task_cnt) AS tryon_view_product_task_cnt,
            count(distinct tryon_view_product_device_id) AS tryon_view_product_user_cnt
        FROM
            `favie_dw.dws_favie_gensmo_tryon_metric_inc_1d`
        WHERE
            dt is not null AND user_group LIKE 'ab%'
        GROUP BY
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ab_project_name,
            ab_router_id,
            ab_router_name      
    )

    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        ab_project_name,
        ab_router_id,
        ab_router_name,

        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_user_cnt,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_user_cnt,
        tryon_load_fail_task_cnt,
        tryon_load_fail_user_cnt,
        tryon_load_succeed_task_cnt,
        tryon_load_succeed_user_cnt,
        tryon_save_task_cnt,
        tryon_save_user_cnt,
        tryon_download_task_cnt,
        tryon_download_user_cnt,
        tryon_like_task_cnt,
        tryon_like_user_cnt,

        tryon_dislike_task_cnt,
        tryon_dislike_user_cnt,
        tryon_share_task_cnt,
        tryon_share_user_cnt,
        tryon_post_task_cnt,
        tryon_post_user_cnt,
        tryon_view_product_task_cnt,
        tryon_view_product_user_cnt
    FROM positive_feed_back;