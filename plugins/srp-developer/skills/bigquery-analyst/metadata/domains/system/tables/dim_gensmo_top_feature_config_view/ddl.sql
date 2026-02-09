CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_gensmo_top_feature_config_view`
OPTIONS(
  sheet_range="Sheet1",
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1czVcZT54smLPLe9is47t4YVqJs2l3gJO6SszhJJikY4/edit?gid=0#gid=0"]
);