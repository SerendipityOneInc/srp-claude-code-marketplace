CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_recap_inc_1d`
(
  user_id STRING,
  dt DATE,
  event_type STRING,
  event_timestamp TIMESTAMP,
  session_id STRING,
  item_name ARRAY<STRING>,
  item_id ARRAY<STRING>,
  item_type ARRAY<STRING>,
  item_index ARRAY<INT64>,
  image_url ARRAY<STRING>,
  moodboard_content ARRAY<STRING>
)
PARTITION BY dt
CLUSTER BY user_id;