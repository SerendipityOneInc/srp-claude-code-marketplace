CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_gem_ha3_exclude_site`
(
  site STRING
)
OPTIONS(
  sheet_range="exclude_site",
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1-wOILVnXhtf7F_SQ8saWLmYKRMXtyF3iZW69-NblD_8"]
);