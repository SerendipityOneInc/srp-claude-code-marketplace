WITH today_event_ab AS (
    SELECT
      user_id,
      trim(ab_id) AS ab_unique_id,
      dt_param AS enter_ab_date
    FROM favie_dw.dwd_favie_decofy_events_inc_1d,
         UNNEST(event_ab_infos) AS ab_id
    WHERE dt = dt_param
      AND user_id IS NOT NULL
      AND ARRAY_LENGTH(event_ab_infos) > 0
    GROUP BY user_id, ab_id
  ),
  yest_ab_active AS (
    SELECT
      user_id,
      ab_unique_id,
      enter_ab_date
    FROM favie_dw.dwd_favie_decofy_ab_active_users_inc_1d
    WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
  ),
  all_ab_union AS (
    SELECT * FROM today_event_ab
    UNION ALL
    SELECT * FROM yest_ab_active
  ),
  ab_active_min_date AS (
    SELECT
      user_id,
      ab_unique_id,
      MIN(enter_ab_date) AS enter_ab_date
    FROM all_ab_union
    GROUP BY user_id, ab_unique_id
  ),
  ab_config AS (
    SELECT
      CAST(unique_id AS STRING) AS ab_unique_id,
      trim(project) AS ab_project,
      trim(router) AS ab_router,
      SAFE_CAST(`start_date` AS DATE) AS ab_start_date,
      COALESCE(SAFE_CAST(`end_date` AS DATE), DATE('2999-12-31')) AS ab_end_date
    FROM favie_dw.dim_decofy_user_ab_config_view
    WHERE enabled = true
  )
  SELECT
    dt_param AS dt,
    a.user_id,
    c.ab_project,
    c.ab_router,
    a.ab_unique_id,
    c.ab_start_date,
    a.enter_ab_date
  FROM ab_active_min_date a
  LEFT JOIN ab_config c
    ON a.ab_unique_id = c.ab_unique_id
  WHERE c.ab_end_date >= dt_param