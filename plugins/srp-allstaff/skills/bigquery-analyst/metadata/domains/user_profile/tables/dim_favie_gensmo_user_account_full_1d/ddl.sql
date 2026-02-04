CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_full_1d`
(
  dt DATE,
  user_id STRING,
  user_name STRING,
  user_email STRING,
  user_phone STRING,
  user_type INT64,
  last_device_id STRING,
  device_ids ARRAY<STRING>,
  first_device_id STRING,
  updated_at TIMESTAMP,
  created_at TIMESTAMP,
  is_internal_user BOOL,
  is_bot_user BOOL
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=3.0
);