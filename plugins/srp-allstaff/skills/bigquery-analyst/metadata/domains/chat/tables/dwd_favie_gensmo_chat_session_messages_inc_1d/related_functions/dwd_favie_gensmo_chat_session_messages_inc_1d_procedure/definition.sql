BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;

  WHILE n_day > 0 DO
    -- delete existing data
    DELETE FROM favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d
    WHERE dt IS NOT NULL AND dt = current_dt;

    -- insert new data
    INSERT INTO favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d (
      dt,
      chat_session_id,
      message_id,
      message_type,
      message_visibility,
      message_value,
      message_sent_at,
      user_id,
      user_role,
      created_at,
      updated_at
    )
    SELECT
      dt,
      chat_session_id,
      message_id,
      message_type,
      message_visibility,
      message_value,
      message_sent_at,
      user_id,
      user_role,
      created_at,
      updated_at
    FROM favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END