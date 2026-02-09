begin
    DELETE FROM `favie_dw.dws_gensmo_refer_general_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param;
  
    INSERT INTO `favie_dw.dws_gensmo_refer_general_metrics_inc_1d`(
        dt,
        device_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    )
    select 
        dt,
        device_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    from favie_dw.dws_gensmo_refer_general_metrics_inc_1d_function(dt_param);
    call favie_dw.record_partition('favie_dw.dws_gensmo_refer_general_metrics_inc_1d', dt_param,"");
end