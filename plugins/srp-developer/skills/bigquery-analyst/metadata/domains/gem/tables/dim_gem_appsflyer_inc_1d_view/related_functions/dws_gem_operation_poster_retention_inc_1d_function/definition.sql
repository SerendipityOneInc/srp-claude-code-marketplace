WITH
-- 当天活跃用户
cohort_users AS (
  SELECT DISTINCT
    device_id
  FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
  WHERE dt = dt_param
    AND event_method NOT IN ('app_launch','app_foreground','app_background')
),

-- 发帖行为
post_actions AS (
  SELECT DISTINCT
    e.device_id,
    CASE
      WHEN e.refer = 'post_boot' THEN 'active'
      WHEN e.refer = 'open_collage' THEN 'passive'
    END AS post_type
  FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d` e
  WHERE e.dt = dt_param
    AND e.event_action_type = 'post'
    AND e.refer IN ('post_boot','open_collage')
),

-- D1 留存
d1_users AS (
  SELECT DISTINCT device_id
  FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
  WHERE dt = DATE_ADD(dt_param, INTERVAL 1 DAY)
    AND event_method NOT IN ('app_launch','app_foreground','app_background')
),

-- D7 留存
d7_users AS (
  SELECT DISTINCT device_id
  FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
  WHERE dt = DATE_ADD(dt_param, INTERVAL 7 DAY)
    AND event_method NOT IN ('app_launch','app_foreground','app_background')
),

-- LT7 活跃天数
lt7_users AS (
  SELECT
    device_id,
    COUNT(DISTINCT dt) AS user_active_days
  FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d`
  WHERE dt BETWEEN dt_param AND DATE_ADD(dt_param, INTERVAL 7 DAY)
    AND event_method NOT IN ('app_launch','app_foreground','app_background')
  GROUP BY device_id
),

-- 用户特征表
user_features AS (
  SELECT
    device_id,
    dt,
    appsflyer_id,
    is_internal_user,
    user_type,
    user_tenure_type,
    last_day_feature.login_type AS login_type,
    last_day_feature.platform   AS platform,
    last_day_feature.app_version AS app_version
  FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
  WHERE dt = dt_param
),

-- appsflyer_id → user_media_source
install_with_rn AS (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY appsflyer_id
        ORDER BY
          CASE WHEN source = 'ON_LINE' THEN 1
               WHEN source = 'OFF_LINE' THEN 2
               ELSE 3 END,
          CASE WHEN media_source NOT IN ('organic', 'None') THEN 1
               WHEN media_source = 'organic' THEN 2
               ELSE 3 END
      ) AS rn
    FROM `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_inc_1d_view`
),
install AS (
    SELECT * EXCEPT(rn)
    FROM install_with_rn
    WHERE rn = 1
)

SELECT
  dt_param AS dt,
  inst.media_source AS user_media_source,
  uf.is_internal_user,
  uf.user_type,
  uf.user_tenure_type,
  uf.login_type,
  uf.platform,
  uf.app_version,

  COUNT(DISTINCT c.device_id) AS active_users,

  COUNT(DISTINCT IF(d1.device_id IS NOT NULL, c.device_id, NULL)) AS d1_retained_users,
  COUNT(DISTINCT IF(d7.device_id IS NOT NULL, c.device_id, NULL)) AS d7_retained_users,
  SUM(COALESCE(l.user_active_days,0)) AS lt7,

  COUNT(DISTINCT IF(p.post_type='active', c.device_id, NULL)) AS active_post_users,
  COUNT(DISTINCT IF(p.post_type='passive', c.device_id, NULL)) AS passive_post_users,
  COUNT(DISTINCT IF(p.device_id IS NULL, c.device_id, NULL)) AS no_post_users,

  COUNT(DISTINCT IF(p.post_type='active' AND d1.device_id IS NOT NULL, c.device_id, NULL)) AS active_post_d1_retained,
  COUNT(DISTINCT IF(p.post_type='passive' AND d1.device_id IS NOT NULL, c.device_id, NULL)) AS passive_post_d1_retained,
  COUNT(DISTINCT IF(p.device_id IS NULL AND d1.device_id IS NOT NULL, c.device_id, NULL)) AS no_post_d1_retained,

  COUNT(DISTINCT IF(p.post_type='active' AND d7.device_id IS NOT NULL, c.device_id, NULL)) AS active_post_d7_retained,
  COUNT(DISTINCT IF(p.post_type='passive' AND d7.device_id IS NOT NULL, c.device_id, NULL)) AS passive_post_d7_retained,
  COUNT(DISTINCT IF(p.device_id IS NULL AND d7.device_id IS NOT NULL, c.device_id, NULL)) AS no_post_d7_retained,

  COALESCE(SUM(CASE WHEN p.post_type='active' THEN l.user_active_days ELSE 0 END),0) AS active_post_lt7,
  COALESCE(SUM(CASE WHEN p.post_type='passive' THEN l.user_active_days ELSE 0 END),0) AS passive_post_lt7,
  COALESCE(SUM(CASE WHEN p.device_id IS NULL THEN l.user_active_days ELSE 0 END),0) AS no_post_lt7

FROM cohort_users c
LEFT JOIN post_actions p ON c.device_id = p.device_id
LEFT JOIN d1_users d1 ON c.device_id = d1.device_id
LEFT JOIN d7_users d7 ON c.device_id = d7.device_id
LEFT JOIN lt7_users l ON c.device_id = l.device_id
LEFT JOIN user_features uf ON c.device_id = uf.device_id AND uf.dt = dt_param
LEFT JOIN install inst ON uf.appsflyer_id = inst.appsflyer_id

GROUP BY
  dt_param,
  inst.media_source,
  uf.is_internal_user,
  uf.user_type,
  uf.user_tenure_type,
  uf.login_type,
  uf.platform,
  uf.app_version