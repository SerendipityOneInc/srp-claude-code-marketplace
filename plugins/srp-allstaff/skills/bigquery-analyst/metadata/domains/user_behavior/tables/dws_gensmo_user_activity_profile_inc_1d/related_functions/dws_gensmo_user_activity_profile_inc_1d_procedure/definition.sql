begin
    DELETE FROM `favie_dw.dws_gensmo_user_activity_profile_inc_1d`
    WHERE dt is not null and dt = dt_param;

    INSERT INTO `favie_dw.dws_gensmo_user_activity_profile_inc_1d`(
        dt,
        device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        user_tenure_segment,
        user_login_type,
        user_created_at,
        user_ids,
        first_event_timestamp,
        last_event_timestamp,
        geo_address,
        app_info,
        user_duration,
        common_actions
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
        user_ids,
        first_event_timestamp,
        last_event_timestamp,
        geo_address,
        app_info,
        user_duration,
        common_actions
    from favie_dw.dws_gensmo_user_activity_profile_inc_1d_function(dt_param);

    call favie_dw.record_partition('favie_dw.dws_gensmo_user_activity_profile_inc_1d', dt_param,"");
end