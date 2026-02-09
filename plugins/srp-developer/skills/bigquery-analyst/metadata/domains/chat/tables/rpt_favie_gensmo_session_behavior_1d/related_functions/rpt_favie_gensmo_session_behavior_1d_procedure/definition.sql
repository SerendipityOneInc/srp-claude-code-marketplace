begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_session_behavior_1d
    WHERE dt = dt_param;
    INSERT INTO favie_rpt.rpt_favie_gensmo_session_behavior_1d (
    session_id,
    user_uid,
    dt,
    last_device_id,
    message_type,
    total_message_count,
    search_query_count,
    search_res_count,
    tryon_query_count,
    tryon_res_count,
    tryon_changebg_query_count,
    tryon_changebg_res_count,
    session_start_count,
    unexpect_error_count,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group
    )
    select
    session_id,
    user_uid,
    dt,
    last_device_id,
    message_type,
    total_message_count,
    search_query_count,
    search_res_count,
    tryon_query_count,
    tryon_res_count,
    tryon_changebg_query_count,
    tryon_changebg_res_count,
    session_start_count,
    unexpect_error_count,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group
    from favie_rpt.rpt_favie_gensmo_session_behavior_1d_function( dt_param);
end