CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_search_metrics_inc_1d_view`
AS WITH user_search_metrics AS (
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
            search_trigger_pv_cnt,
            search_boot_page_view_pv_cnt,
            search_boot_polish_pv_cnt,
            search_boot_focus_pv_cnt,
            search_trigger_user_cnt,
            search_boot_page_view_user_cnt,
            search_boot_polish_user_cnt,
            search_boot_focus_user_cnt,
            DAU
        FROM
            `favie_rpt.rpt_gensmo_user_search_metrics_inc_1d`
        WHERE
            dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND user_group LIKE 'ab%'
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
        search_trigger_pv_cnt,
        search_boot_page_view_pv_cnt,
        search_boot_polish_pv_cnt,
        search_boot_focus_pv_cnt,
        search_trigger_user_cnt,
        search_boot_page_view_user_cnt,
        search_boot_polish_user_cnt,
        search_boot_focus_user_cnt,
        DAU
    FROM
        user_search_metrics;