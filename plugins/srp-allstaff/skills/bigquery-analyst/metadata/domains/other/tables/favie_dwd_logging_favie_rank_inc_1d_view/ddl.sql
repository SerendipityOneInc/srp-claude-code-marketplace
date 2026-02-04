CREATE VIEW `srpproduct-dc37e.favie_dw.favie_dwd_logging_favie_rank_inc_1d_view`
AS WITH SplitTable AS (
  SELECT
    jsonPayload.trace_id as trace_id,
    jsonPayload.query as ha3_query,
    SPLIT(jsonPayload.score, ',') AS items,
    `timestamp` as log_timestamp,
    receiveTimestamp as receive_timestamp,
    PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
  FROM `logging_favie_rank.stdout_*`
),

Explode AS (
  SELECT
    trace_id,
    ha3_query,
    item,
    log_timestamp,
    receive_timestamp,
    dt
  FROM SplitTable,UNNEST(items) AS item
)

SELECT
  trace_id,
  ha3_query,
  SPLIT(item, ':')[OFFSET(0)] AS f_sku_id,
  SAFE_CAST(SPLIT(item, ':')[OFFSET(1)] AS FLOAT64) AS score,
  log_timestamp,
  receive_timestamp,
  dt  
FROM Explode;