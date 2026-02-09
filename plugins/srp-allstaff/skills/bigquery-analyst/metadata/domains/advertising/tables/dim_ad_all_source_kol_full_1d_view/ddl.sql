CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_ad_all_source_kol_full_1d_view`
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1dRafaGi4ZFkw4caEmdn_5jlW2baP4UMrb2ZRQReVBTs/edit?gid=0#gid=0"]
);