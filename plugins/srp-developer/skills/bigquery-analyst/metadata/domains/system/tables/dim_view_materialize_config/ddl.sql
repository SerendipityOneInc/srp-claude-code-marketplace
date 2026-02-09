CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_view_materialize_config`
(
  dw_name STRING,
  view_name STRING
)
OPTIONS(
  sheet_range="Sheet1!A:B",
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1AfuHW5rkHIbvzMGL-nELCcaHdsdwH4SfCl0Qjia4NSE/edit?usp=sharing"]
);