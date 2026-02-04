WITH user_info_with_group AS (
    SELECT 
      device_id,
      user_group,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type
    FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)
  )

  SELECT
    dt_param AS dt,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    0 AS item_task_gen_pv_cnt,
    0 AS item_task_complete_pv_cnt,
    0 AS item_task_complete_item_cnt
  FROM user_info_with_group