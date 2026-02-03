WITH
  base_data AS (
    SELECT
      dt,
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      device_id,
      event_items,
      app_version,
      platform,
      event_uuid
    FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
    WHERE dt = dt_param
      AND refer_group = 'valid'
      AND event_version = '1.0.0'
  ),
  data_ust AS (
    SELECT
      dt,
      refer,
      ap_name,
      event_name,
      event_method,
      event_action_type,
      event_item.item_type AS item_type,
      app_version,
      platform,
      event_uuid
    FROM base_data t1
    LEFT JOIN UNNEST(event_items) AS event_item
  )
  SELECT
    dt,
    refer,
    ap_name,
    event_name,
    event_method,
    event_action_type,
    item_type,
    app_version,
    platform,
    COUNT(DISTINCT event_uuid) AS event_cnt
  FROM data_ust
  GROUP BY
    dt,
    refer,
    ap_name,
    event_name,
    event_method,
    event_action_type,
    item_type,
    app_version,
    platform