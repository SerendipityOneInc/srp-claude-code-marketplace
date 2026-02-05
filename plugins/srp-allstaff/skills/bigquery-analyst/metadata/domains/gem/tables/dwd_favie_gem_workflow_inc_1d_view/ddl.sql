CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_view`
AS SELECT 
  REGEXP_EXTRACT(jsonPayload.traceparent, r'.*?-(.*?)-') AS trace_id,
  jsonPayload.traceparent,
  jsonPayload.task_id as task_id,
  jsonPayload.query AS raw_query, 
  jsonPayload.qr_result.queries AS rewrite_queries,
  jsonPayload.image_url AS image_url,
  jsonPayload.image_description as image_description,
  jsonPayload.image_height as image_height,
  jsonPayload.image_width as image_width,
  jsonPayload.user_image_tag as user_image_tag,
  jsonPayload.collage_title as collage_title,
  jsonPayload.intention as intention,
  jsonPayload.reasoning as reasoning,
  jsonPayload.f_version as app_version,
  jsonPayload.f_source as query_source,
  jsonPayload.device_id as device_id,
  jsonPayload.user_id as user_id,
  jsonPayload.status as status,
  `timestamp` as log_timestamp,
  receiveTimestamp as receive_timestamp,
  PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
FROM `srpproduct-dc37e.logging_gem_workflow.stderr_*`
union all
SELECT 
  JSON_VALUE(logEntry, '$.jsonPayload.trace_id') AS trace_id,
  JSON_VALUE(logEntry, '$.jsonPayload.traceparent') AS traceparent,
  JSON_VALUE(logEntry, '$.jsonPayload.task_id') AS task_id,
  JSON_VALUE(logEntry, '$.jsonPayload.query') AS raw_query, 
  ARRAY(
    SELECT REGEXP_REPLACE(elem, r'^"(.*)"$', r'\1')
    FROM UNNEST(JSON_EXTRACT_ARRAY(logEntry, '$.jsonPayload.qr_result.queries')) AS elem
  ) AS rewrite_queries,
  JSON_VALUE(logEntry, '$.jsonPayload.image_url') AS image_url,
  JSON_VALUE(logEntry, '$.jsonPayload.image_description') AS image_description,
  SAFE_CAST(JSON_VALUE(logEntry, '$.jsonPayload.image_height') AS FLOAT64) AS image_height,
  SAFE_CAST(JSON_VALUE(logEntry, '$.jsonPayload.image_width') AS FLOAT64) AS image_width,
  JSON_VALUE(logEntry, '$.jsonPayload.user_image_tag') AS user_image_tag,
  JSON_VALUE(logEntry, '$.jsonPayload.collage_title') AS collage_title,
  JSON_VALUE(logEntry, '$.jsonPayload.intention') AS intention,
  JSON_VALUE(logEntry, '$.jsonPayload.reasoning') AS reasoning,
  JSON_VALUE(logEntry, '$.jsonPayload.f_version') AS app_version,
  JSON_VALUE(logEntry, '$.jsonPayload.f_source') AS query_source,
  JSON_VALUE(logEntry, '$.jsonPayload.device_id') AS device_id,
  JSON_VALUE(logEntry, '$.jsonPayload.user_id') AS user_id,
  JSON_VALUE(logEntry, '$.jsonPayload.status') AS status,
  `timestamp` as log_timestamp,
  receiveTimestamp as receive_timestamp,
  PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
from `srpproduct-dc37e.logging_gem_workflow.export_errors_*`;