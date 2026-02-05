CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_webpage_quality_source_update_inc_1d`
(
  parser_name STRING OPTIONS(description="爬虫名称"),
  source_type STRING OPTIONS(description="数据源类型"),
  domain STRING OPTIONS(description="站点"),
  dt DATE OPTIONS(description="日期"),
  total_update_times INT64 OPTIONS(description="总更新次数"),
  effective_update_times INT64 OPTIONS(description="有效更新次数"),
  ineffective_update_times INT64 OPTIONS(description="无效更新次数"),
  update_url_cnt INT64 OPTIONS(description="更新URL数"),
  new_added_url_cnt INT64 OPTIONS(description="新增URL数")
)
PARTITION BY dt;