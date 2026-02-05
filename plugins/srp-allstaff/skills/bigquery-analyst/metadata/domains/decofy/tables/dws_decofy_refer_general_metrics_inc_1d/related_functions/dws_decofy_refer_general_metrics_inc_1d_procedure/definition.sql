begin
    declare dt_param_180 date default date_sub(dt_param, interval 180 day);

    DELETE FROM `favie_dw.dws_decofy_refer_general_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param;
  
    INSERT INTO `favie_dw.dws_decofy_refer_general_metrics_inc_1d`(
        dt,
        user_id,
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
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    from favie_dw.dws_decofy_refer_general_metrics_inc_1d_function(dt_param);
end