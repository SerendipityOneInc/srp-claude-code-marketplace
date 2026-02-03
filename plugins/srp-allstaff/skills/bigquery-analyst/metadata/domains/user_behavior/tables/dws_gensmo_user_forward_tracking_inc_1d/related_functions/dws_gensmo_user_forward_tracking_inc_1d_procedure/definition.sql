begin
    DECLARE start_dt DATE;
    DECLARE end_dt DATE;    
    DECLARE tracking_seq int64 default 1;

    while tracking_seq <= tracking_period do
        set start_dt = date_sub(dt_param, interval tracking_period - tracking_seq day);
        set end_dt = dt_param;
        DELETE FROM `favie_dw.dws_gensmo_user_forward_tracking_inc_1d`
        WHERE dt is not null and dt = start_dt;

        INSERT INTO `favie_dw.dws_gensmo_user_forward_tracking_inc_1d`(
            dt,
            device_id,
            appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            user_tenure_segment,
            user_login_type,
            user_created_at,
            tracking_period,
            user_duration,
            common_actions_1d,
            common_actions_xd,
            active_dates
        )
        select 
            dt,
            device_id,
            appsflyer_id,
            is_internal_user,
            user_type,
            user_tenure_type,
            user_tenure_segment,
            user_login_type,
            user_created_at,
            tracking_period,
            user_duration,
            common_actions_1d,
            common_actions_xd,
            active_dates
        from favie_dw.dws_gensmo_user_forward_tracking_inc_1d_function(tracking_period, start_dt,end_dt);
        call favie_dw.record_partition('favie_dw.dws_gensmo_user_forward_tracking_inc_1d', start_dt,"");
        set tracking_seq = tracking_seq + 1;
    end while;

end