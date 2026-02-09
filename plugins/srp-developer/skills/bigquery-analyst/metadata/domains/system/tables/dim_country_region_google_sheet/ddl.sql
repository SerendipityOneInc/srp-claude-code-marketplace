CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_country_region_google_sheet`
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1Y6ND7fTVgx_CwJsyUixXpgRXUJyIK4tksar8MnZjbTY/edit?usp=sharing"]
);