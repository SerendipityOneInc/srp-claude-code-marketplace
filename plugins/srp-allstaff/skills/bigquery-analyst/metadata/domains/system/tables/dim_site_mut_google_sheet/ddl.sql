CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_site_mut_google_sheet`
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1SDG-bPX7JgytEYaFKXM9GZzzc3uDa4YMCRiTDEZxS7U/edit?gid=0#gid=0"]
);