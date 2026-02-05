CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_tryon_metrics_inc_1d_view`
AS WITH user_tryon_info AS (
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

            SUM(tryon_trigger_cnt) AS tryon_trigger_cnt,
            SUM(tryon_trigger_user_cnt) AS tryon_trigger_user_cnt,

            SUM(tryon_request_cnt) AS tryon_request_cnt,
            SUM(tryon_request_user_cnt) AS tryon_request_user_cnt,

            SUM(tryon_complete_succeed_task_cnt) AS tryon_complete_succeed_task_cnt,
            SUM(tryon_complete_succeed_user_cnt) AS tryon_complete_succeed_user_cnt,            
            SUM(tryon_complete_fail_task_cnt) AS tryon_complete_fail_task_cnt,
            SUM(tryon_complete_fail_user_cnt) AS tryon_complete_fail_user_cnt,
            SUM(tryon_complete_user_cnt) AS tryon_complete_user_cnt,

            SUM(tryon_load_fail_task_cnt) AS tryon_load_fail_task_cnt,
            SUM(tryon_load_fail_user_cnt) AS tryon_load_fail_user_cnt,

            SUM(tryon_view_detail_task_cnt) AS tryon_view_detail_task_cnt,
            SUM(tryon_view_detail_user_cnt) AS tryon_view_detail_user_cnt,
            SUM(active_user_d1_cnt) AS DAU
        FROM
            `favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d`
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
        tryon_trigger_cnt,
        tryon_trigger_user_cnt,
        tryon_request_cnt,
        tryon_request_user_cnt,
        tryon_complete_succeed_task_cnt,
        tryon_complete_succeed_user_cnt,
        tryon_complete_fail_task_cnt,
        tryon_complete_fail_user_cnt,
        tryon_complete_user_cnt,
        tryon_load_fail_task_cnt,
        tryon_load_fail_user_cnt,
        tryon_view_detail_task_cnt,
        tryon_view_detail_user_cnt,
        DAU
    FROM user_tryon_info;