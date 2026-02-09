CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_inc_1d`
(
  user_id STRING,
  device_id STRING,
  appsflyer_id STRING,
  is_internal_user BOOL,
  last_timestamp TIMESTAMP,
  dt DATE
)
PARTITION BY dt;