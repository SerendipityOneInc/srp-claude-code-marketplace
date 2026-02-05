WITH filtered AS (
    SELECT
      dt,
      user_id,
      device_id,
      event_item.item_id AS event_item_item_id
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
    WHERE
      dt = dt_param
      AND event_method = 'click'
      AND event_action_type = 'enter_hashtag_detail'
  ),
  agg AS (
    SELECT
      dt,
      user_id,
      device_id,
      event_item_item_id,
      COUNT(1) AS count_hashtag
    FROM filtered
    GROUP BY dt, user_id, device_id, event_item_item_id
  )
  SELECT
    a.dt,
    a.user_id,
    a.device_id,
    a.event_item_item_id AS event_item_item_id,
    a.count_hashtag,
    ug.user_group,
    ug.country_name,
    ug.platform,
    ug.app_version,
    ug.user_login_type,
    ug.user_tenure_type
  FROM agg a
  LEFT JOIN (select * from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)) ug
    ON a.device_id = ug.device_id
    AND ug.dt = dt_param