WITH msg_base AS (
      SELECT
        dt,
        message_id,
        chat_session_id,
        created_at,
        updated_at,
        message_sent_at,
        user_role,
        message_type,
        user_id,
        message_visibility,
        CASE
          WHEN message_type = 'search_query' AND (JSON_VALUE(message_value,'$.search_query.intention') = 'others' OR JSON_VALUE(message_value,'$.search_query.intention') IS NULL) THEN 'styling'
          WHEN message_type = 'search_query' THEN JSON_VALUE(message_value,'$.search_query.intention')
          ELSE 'unknown'
      END
        AS search_query_intention,
        CASE
          WHEN TRIM(STRING(JSON_QUERY(message_value, '$.search_query.image_url'))) != '' AND STRING(JSON_QUERY(message_value, '$.search_query.query')) != '' THEN 'hybrid'
          WHEN TRIM(STRING(JSON_QUERY(message_value, '$.search_query.image_url'))) = ''
        AND STRING(JSON_QUERY(message_value, '$.search_query.query')) != '' THEN 'text'
          WHEN TRIM(STRING(JSON_QUERY(message_value, '$.search_query.image_url'))) != '' AND STRING(JSON_QUERY(message_value, '$.search_query.query')) = '' THEN 'image'
          ELSE 'unknown'
      END
        AS search_query_type
      FROM
        favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d
      WHERE
        dt = dt_param
    ),
    
    msg_with_device AS (
      SELECT
        t1.dt,
        t1.message_id,
        t1.chat_session_id,
        t1.created_at,
        t1.updated_at,
        t1.message_sent_at,
        t1.user_role,
        t1.message_type,
        t1.search_query_intention,
        t1.search_query_type,
        t1.user_id,
        t1.message_visibility,
        COALESCE(t2.device_id, 'unknown') AS device_id
      FROM msg_base t1
      LEFT JOIN `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function`(dt_param) t2
      ON t1.user_id = t2.user_id
    ),

    user_group_info AS (
      SELECT
        user_group,
        device_id,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_type,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id
      FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param) 
    ),
    msg_with_device_group AS (
      SELECT
        t1.dt,
        t1.chat_session_id,
        t1.message_type,
        t1.search_query_intention,
        t1.search_query_type,
        t1.message_visibility,
        t1.message_id,
        t1.user_id,
        t1.device_id,
        t1.user_role,
        t2.user_group,
        t2.country_name,
        t2.platform,
        t2.app_version,
        t2.user_login_type,
        t2.user_tenure_type,
        t2.ad_source,
        t2.ad_id,
        t2.ad_group_id,
        t2.ad_campaign_id,
      FROM msg_with_device t1
      LEFT JOIN user_group_info t2
      ON t1.device_id = t2.device_id 
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
    COUNT(DISTINCT message_id) AS msg_cnt,
    search_query_intention,
    search_query_type
  FROM msg_with_device_group
  GROUP BY
    dt,
    chat_session_id,
    message_type,
    search_query_intention,
    search_query_type,
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
    ad_campaign_id