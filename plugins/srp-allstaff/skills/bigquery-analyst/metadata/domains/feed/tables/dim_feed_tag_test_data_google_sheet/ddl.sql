CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_feed_tag_test_data_google_sheet`
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1cvK4MrV5TcXh_roZK5gTpKDfarkq5I11KQzxB88RTP4/edit?gid=0#gid=0"]
);