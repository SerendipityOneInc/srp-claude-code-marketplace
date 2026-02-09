CREATE VIEW `srpproduct-dc37e.favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d_view`
AS WITH
  user_detail AS (
    SELECT DISTINCT
      dt,
      chat_session_id,
      user_group,
      user_tenure_type,
      user_login_type,
      platform,
      app_version,
      country_name,
      ad_campaign_id,
      ad_group_id,
      ad_source,
      ad_id,
      message_visibility,
      user_id,
      device_id,
      user_role
    FROM favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d
    WHERE dt IS NOT NULL AND user_role='user'
  ),
  all_types AS (
    SELECT
      dt,
      ARRAY_AGG(DISTINCT message_type) AS types,
      ARRAY_AGG(DISTINCT CONCAT(search_query_intention,'_',search_query_type)) AS subtypes
    FROM `favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d`
    WHERE dt IS NOT NULL AND user_role='user'
    GROUP BY dt
  ),
  data_exp AS (
    SELECT DISTINCT
      t1.dt,
      t1.chat_session_id,
      t1.user_group,
      t1.user_tenure_type,
      t1.user_login_type,
      t1.platform,
      t1.app_version,
      t1.country_name,
      t1.ad_campaign_id,
      t1.ad_group_id,
      t1.ad_source,
      t1.ad_id,
      t1.message_visibility,
      t1.user_id,
      t1.device_id,
      t1.user_role,
      message_type,
      message_subtype
    FROM user_detail t1
    CROSS JOIN all_types t2
    CROSS JOIN UNNEST(types) AS message_type
    CROSS JOIN UNNEST(subtypes) AS message_subtype
    WHERE t1.dt=t2.dt
  )
  
SELECT
    t1.dt,
    t1.chat_session_id,
    t1.user_group,
    t1.user_tenure_type,
    t1.user_login_type,
    t1.platform,
    t1.app_version,
    t1.country_name,
    t1.ad_campaign_id,
    t1.ad_group_id,
    t1.ad_source,
    t1.ad_id,
    t1.message_type,
    t1.message_subtype,
    t1.message_visibility,
    t1.user_id,
    t1.device_id,
    t1.user_role,
    t2.msg_cnt
  FROM data_exp t1
  LEFT JOIN `favie_dw.dws_favie_gensmo_chat_session_messages_metric_inc_1d` t2
    ON
    t1.dt=t2.dt and
    t1.chat_session_id=t2.chat_session_id and
    t1.user_group=t2.user_group and
    t1.user_tenure_type=t2.user_tenure_type and 
    t1.user_login_type=t2.user_login_type and
    t1.platform=t2.platform and
    t1.app_version=t2.app_version and
    t1.country_name=t2.country_name and
    t1.ad_campaign_id=t2.ad_campaign_id and
    t1.ad_group_id=t2.ad_group_id and 
    t1.ad_source=t2.ad_source and
    t1.ad_id=t2.ad_id and
    t1.message_type=t2.message_type and
    t1.message_visibility=t2.message_visibility and
    t1.user_id=t2.user_id and
    t1.device_id=t2.device_id and
    t1.user_role=t2.user_role and
    t1.message_subtype = CONCAT(t2.search_query_intention,'_',t2.search_query_type);