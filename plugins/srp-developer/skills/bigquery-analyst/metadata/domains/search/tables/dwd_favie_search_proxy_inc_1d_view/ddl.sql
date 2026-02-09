CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_search_proxy_inc_1d_view`
AS SELECT 
  jsonPayload.trace_id as trace_id,
  json_value(jsonPayload.response,"$.result.query_understanding.query") as qp_query,
  `timestamp` as log_timestamp,
  receiveTimestamp as receive_timestamp,
  PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
FROM `logging_favie_search_proxy_qp.stdout_*`;