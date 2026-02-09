CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_webpage_sample_1d`
(
  domain STRING OPTIONS(description="域名"),
  url STRING OPTIONS(description="网页链接"),
  title STRING OPTIONS(description="网页标题"),
  keywords STRING OPTIONS(description="网页关键字"),
  description STRING OPTIONS(description="网页描述"),
  content STRING OPTIONS(description="网页正文"),
  dt DATE OPTIONS(description="分区，日期")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);