begin
    DELETE FROM `favie_dw.dws_gensmo_refer_event_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param;
  
    INSERT INTO `favie_dw.dws_gensmo_refer_event_metrics_inc_1d`(
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        user_country_name,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        pre_refer,
        pre_refer_ap_name,
        pre_refer_event_name,
        pre_refer_event_method,
        pre_refer_event_action_type,
        next_refer,
        platform,
        app_version,
        web_version,
        event_version,
        event_cnt
    )
    select 
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        user_country_name,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        pre_refer,
        pre_refer_ap_name,
        pre_refer_event_name,
        pre_refer_event_method,
        pre_refer_event_action_type,
        next_refer,
        platform,
        app_version,
        web_version,
        event_version,
        event_cnt
    from favie_dw.dws_gensmo_refer_event_metrics_inc_1d_function(dt_param);
end