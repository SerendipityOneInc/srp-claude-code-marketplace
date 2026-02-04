CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.tmp_dim_ad_all_source_history_creative_tag_full_view`
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1F1SDqwlwWAGWrNRfAog913Gz9GHYz_DgtZW7KAzCI8Y/edit?gid=1308370088#gid=1308370088"]
);