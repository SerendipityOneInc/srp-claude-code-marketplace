CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_favie_user_google_sheet_config_mut_view`
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1HGgZJro3jFhRfrrWNS4DYd17ZeZkJIAFNAx6s0HMpug/edit?gid=0#gid=0"]
);