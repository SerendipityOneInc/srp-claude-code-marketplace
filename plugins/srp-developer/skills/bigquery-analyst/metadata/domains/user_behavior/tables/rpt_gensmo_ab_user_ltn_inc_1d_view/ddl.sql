CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_user_ltn_inc_1d_view`
AS WITH ab_users AS (
    SELECT
      dt,
      user_tenure_type,
      user_login_type,
      country_name,
      platform,
      app_version,
      SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
      SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
      SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,
      lifetime_days,
      SUM(active_days_cnt) as active_days_cnt,
      SUM(active_user_cnt) as active_user_cnt
    FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_ltn_metrics_inc_1d`
    WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND user_group LIKE 'ab_%'
    GROUP BY
      dt,
      user_tenure_type,
      user_login_type,
      country_name,
      platform,
      app_version,
      ab_project_name,
      ab_router_id,
      ab_router_name,
      lifetime_days
  )
  
  SELECT
    dt,
    user_tenure_type,
    user_login_type,
    country_name,
    platform,
    app_version,
    ab_project_name,
    ab_router_id,
    ab_router_name,
    lifetime_days,
    active_days_cnt,
    active_user_cnt
  FROM ab_users;