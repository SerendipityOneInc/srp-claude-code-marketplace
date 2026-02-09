SELECT
    DATE(created_at) AS dt,
    session_id AS chat_session_id,
    message_id AS message_id,
    type AS message_type,
    cast(visible as string) AS message_visibility,
    PARSE_JSON(value) AS message_value,
    message_order AS message_sent_at,
    user_uid AS user_id,
    role AS user_role,
    created_at,
    last_updated_at AS updated_at
  FROM `favie_dw.dim_chat_session_messages_view`
  WHERE DATE(created_at) = dt_param