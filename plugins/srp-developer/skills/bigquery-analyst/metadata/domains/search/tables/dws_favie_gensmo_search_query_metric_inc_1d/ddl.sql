CREATE TABLE `srpproduct-dc37e.favie_dw.dws_favie_gensmo_search_query_metric_inc_1d`
(
  raw_query STRING,
  qp_query STRING,
  query_modality STRING,
  raw_query_word_amt INT64,
  qp_query_word_amt INT64,
  query_cnt INT64,
  dt DATE
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);