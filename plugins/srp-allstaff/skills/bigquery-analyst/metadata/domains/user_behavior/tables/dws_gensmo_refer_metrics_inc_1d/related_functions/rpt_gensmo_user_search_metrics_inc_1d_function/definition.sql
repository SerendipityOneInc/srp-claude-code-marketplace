WITH user_refer_events_info AS (
        SELECT
            dt,
            
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            
            user_group,

            device_id,
            ap_name,
            refer,
            event_name,
            event_method,
            event_action_type,

            refer_ap_click_cnt,
            refer_pv_cnt,
            refer_leave_directly_cnt,
            refer_duration_amount,
            refer_click_device_id,
            refer_directly_leave_device_id
        FROM
            `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d`
        WHERE
            dt = dt_param
            AND device_id IS NOT NULL
            AND refer IS NOT NULL
    ),

    user_search_events AS (
        SELECT
            dt,
            
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,

            SUM(CASE WHEN event_action_type = 'collage_gen' THEN refer_ap_click_cnt ELSE 0 END) AS search_trigger_pv_cnt,
            COUNT(DISTINCT CASE WHEN event_action_type = 'collage_gen' THEN refer_click_device_id END) AS search_trigger_user_cnt,

            SUM(CASE WHEN refer = 'search_boot' AND event_name = 'select_item' AND event_method = 'page_view' THEN refer_pv_cnt ELSE 0 END) AS search_boot_page_view_pv_cnt,
            COUNT(DISTINCT CASE WHEN refer = 'search_boot' AND event_name = 'select_item' AND event_method = 'page_view' THEN device_id END) AS search_boot_page_view_user_cnt,

            SUM(CASE WHEN refer = 'search_boot' AND event_name = 'select_item' AND event_method = 'click' AND ap_name = 'ap_polish_btn' THEN refer_ap_click_cnt ELSE 0 END) AS search_boot_polish_pv_cnt,
            COUNT(DISTINCT CASE WHEN refer = 'search_boot' AND event_name = 'select_item' AND event_method = 'click' AND ap_name = 'ap_polish_btn' THEN refer_click_device_id END) AS search_boot_polish_user_cnt,
            
            SUM(CASE WHEN refer = 'search_boot' AND event_name = 'select_item' AND event_method = 'click' AND ap_name = 'ap_input_field' THEN refer_ap_click_cnt ELSE 0 END) AS search_boot_focus_pv_cnt,
            COUNT(DISTINCT CASE WHEN refer = 'search_boot' AND event_name = 'select_item' AND event_method = 'click' AND ap_name = 'ap_input_field' THEN refer_click_device_id END) AS search_boot_focus_user_cnt
        FROM
            user_refer_events_info
        GROUP BY
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group
    ),

    events_with_dau AS (
        SELECT
            a.dt,
            a.user_tenure_type,
            a.user_login_type,
            a.country_name,
            a.platform,
            a.app_version,
            a.user_group,
            a.search_trigger_pv_cnt,
            a.search_boot_page_view_pv_cnt,
            a.search_boot_polish_pv_cnt,
            a.search_boot_focus_pv_cnt,
            a.search_trigger_user_cnt,
            a.search_boot_page_view_user_cnt,
            a.search_boot_polish_user_cnt,
            a.search_boot_focus_user_cnt,
            b.active_user_d1_cnt AS DAU
        FROM
            user_search_events a
        LEFT JOIN (
            SELECT
                dt,
                country_name,
                platform,
                app_version,
                user_group,
                user_login_type,
                user_tenure_type,
                SUM(active_user_d1_cnt) AS active_user_d1_cnt
            FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d`
            GROUP BY 
                dt,
                country_name,
                platform,
                app_version,
                user_group,
                user_login_type,
                user_tenure_type
        ) b
        ON
            a.dt = b.dt
            AND a.user_tenure_type = b.user_tenure_type
            AND a.user_login_type = b.user_login_type
            AND a.country_name = b.country_name
            AND a.platform = b.platform
            AND a.app_version = b.app_version
            AND a.user_group = b.user_group
    )

    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
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
        events_with_dau