CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_gensmo_brand_wall_view`
OPTIONS(
  sheet_range="Sheet1",
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1QHO-FophE0MxlwEUgSqWVt4fl2dgqWeHoVVA0nAxiFs"]
);