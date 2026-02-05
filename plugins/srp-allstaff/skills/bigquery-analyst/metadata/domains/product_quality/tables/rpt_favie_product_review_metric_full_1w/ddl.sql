CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1w`
(
  site STRING OPTIONS(description="站点"),
  total_review_num INT64 OPTIONS(description="总评论数"),
  weekly_new_review_num INT64 OPTIONS(description="每周新增评论数"),
  weekly_update_review_num INT64 OPTIONS(description="每周更新评论数"),
  total_spu_num_with_review INT64 OPTIONS(description="有评论的SPU总数"),
  spu_num_with_review_count_ge_10 INT64 OPTIONS(description="评论数>=10的SPU数"),
  dt DATE OPTIONS(description="日期")
)
PARTITION BY dt;