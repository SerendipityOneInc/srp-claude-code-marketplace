WITH user_info_with_group AS (
    SELECT 
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
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
    device_id,
    'body' AS task_model,
    'try_on' AS task_type,
    0 AS tryon_server_complete_item_cnt,
    0 AS tryon_server_complete_user_cnt,
    0 AS tryon_complete_item_cnt,
    0 AS tryon_complete_user_cnt,
    0 AS tryon_save_item_cnt,
    0 AS tryon_save_user_cnt,
    0 AS tryon_like_item_cnt,
    0 AS tryon_like_user_cnt,
    0 AS tryon_post_item_cnt,
    0 AS tryon_post_user_cnt
  FROM user_info_with_group