CREATE VIEW `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_30d_view`
AS SELECT
  dt,
  device_id,
  first_device_id,
  user_type,
  -- 转换 created_at 为日期格式进行比较
  SAFE_CAST(created_at AS DATE) AS user_created_date,
  SAFE_CAST(created_at AS DATE) >= dt AS is_new_user
FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
WHERE dt BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND CURRENT_DATE();