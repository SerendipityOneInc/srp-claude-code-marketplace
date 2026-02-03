CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_ha3_rank_inc_1d_view`
AS SELECT
  jsonPayload.trace_id as trace_id,
  jsonPayload.query as qr_query,
  jsonPayload.score AS qr_results,
  `timestamp` as log_timestamp,
  receiveTimestamp as receive_timestamp,
  PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
FROM `logging_favie_rank.stdout_*`;