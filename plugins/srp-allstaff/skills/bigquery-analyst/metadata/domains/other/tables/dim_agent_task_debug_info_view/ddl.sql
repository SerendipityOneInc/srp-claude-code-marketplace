CREATE VIEW `srpproduct-dc37e.favie_dw.dim_agent_task_debug_info_view`
AS SELECT
 timestamp_millis(safe_cast(json_value(to_json_string(data.created_time), '$."$date"') as int64)) AS created_time,
  Date(timestamp_millis(safe_cast(json_value(to_json_string(data.created_time), '$."$date"') as int64))) as dt,
 JSON_VALUE(to_json_string(data.image_url)) AS image_url,
  JSON_VALUE(to_json_string(data.query)) AS query,
  JSON_VALUE(to_json_string(data.intention)) AS intention,
  JSON_VALUE(to_json_string(data.session_id)) AS session_id,
  JSON_VALUE(to_json_string(data.task_id)) AS task_id,
  JSON_VALUE(to_json_string(data.generation_type)) AS type,
  JSON_VALUE(to_json_string(data.user_id)) AS user_id,
  JSON_VALUE(to_json_string(data.f_source)) AS f_source,
  -- JSON_VALUE(moodboard, '$.id') AS moodboard_id,
  -- JSON_VALUE(moodboard, '$.content') AS moodboard_content
  JSON_EXTRACT_ARRAY(to_json_string(data.result), '$.moodboards') as moodboards
FROM
  `srpproduct-dc37e.mongo_production.copilot_agent_task_debug_info`;