CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_gem_appsflyer_history_inc_1d`
OPTIONS(
  skip_leading_rows=1,
  format="CSV",
  uris=["gs://srp_datalake-production/ods/appsflyer/af_installs_2025-04-30_2025-06-10_America_Los_Angeles_bigquery_ready.csv"]
);