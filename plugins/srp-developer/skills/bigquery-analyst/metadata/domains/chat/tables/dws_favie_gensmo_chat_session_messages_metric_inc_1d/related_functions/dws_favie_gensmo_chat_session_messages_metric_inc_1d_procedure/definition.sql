BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;

  -- delete existing data
  WHILE n_day > 0 DO
    DELETE FROM favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d
    WHERE dt IS NOT NULL AND dt = current_dt;

    -- insert new data
    INSERT INTO favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d (
      dt,
      chat_session_id,
      message_type,
      message_visibility,
      user_id,
      device_id,
      user_role,
      user_group,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type,
      ad_source,
      ad_id,
      ad_group_id,
      ad_campaign_id,
      msg_cnt,
      search_query_intention,
      search_query_type
    )
    SELECT
      dt,
      chat_session_id,
      message_type,
      message_visibility,
      user_id,
      device_id,
      user_role,
      user_group,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type,
      ad_source,
      ad_id,
      ad_group_id,
      ad_campaign_id,
      msg_cnt,
      search_query_intention,
      search_query_type
    FROM favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END