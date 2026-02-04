CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_product_review_combined_full_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  f_spu_id STRING OPTIONS(description="商品SPU"),
  combined_title_body STRING OPTIONS(description="商品标题和评论内容拼接")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=14.0,
  require_partition_filter=true
);