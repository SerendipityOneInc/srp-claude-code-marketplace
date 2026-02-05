CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dim_ad_kol_external_post_id_google_sheet_full_1d_view`
(
  app_name STRING OPTIONS(description="应用名称"),
  post_id STRING OPTIONS(description="帖子ID"),
  brief_type STRING OPTIONS(description="Brief类型"),
  function_tag STRING OPTIONS(description="功能标签"),
  handle STRING OPTIONS(description="账号Handle"),
  campaign STRING OPTIONS(description="Campaign"),
  platform STRING OPTIONS(description="平台"),
  tier STRING OPTIONS(description="层级"),
  post_time STRING OPTIONS(description="发帖时间"),
  post_link STRING OPTIONS(description="帖子链接"),
  cost FLOAT64 OPTIONS(description="合同成本"),
  source STRING OPTIONS(description="数据源")
)
OPTIONS(
  skip_leading_rows=1,
  format="GOOGLE_SHEETS",
  uris=["https://docs.google.com/spreadsheets/d/1dRafaGi4ZFkw4caEmdn_5jlW2baP4UMrb2ZRQReVBTs/edit?gid=0#gid=0"]
);