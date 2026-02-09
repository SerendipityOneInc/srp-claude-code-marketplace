CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d`
(
  user_id STRING,
  device_id STRING,
  appsflyer_id STRING,
  dt DATE
)
PARTITION BY dt;