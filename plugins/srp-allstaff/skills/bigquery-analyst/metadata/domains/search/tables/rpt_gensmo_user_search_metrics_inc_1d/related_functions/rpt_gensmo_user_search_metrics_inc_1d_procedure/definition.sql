begin
    delete from favie_rpt.rpt_gensmo_user_search_metrics_inc_1d
    where dt = dt_param;

    INSERT INTO favie_rpt.rpt_gensmo_user_search_metrics_inc_1d
    (
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
    )
    select
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
    from favie_rpt.rpt_gensmo_user_search_metrics_inc_1d_function(dt_param);
end