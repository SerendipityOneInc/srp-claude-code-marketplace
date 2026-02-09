CREATE TABLE `srpproduct-dc37e.favie_dw.ads_favie_product_sample_daily`
(
  domain STRING OPTIONS(description="域名"),
  product_link STRING OPTIONS(description="商品链接"),
  product_data STRING OPTIONS(description="商品数据"),
  dt DATE OPTIONS(description="分区，日期"),
  product_title STRING OPTIONS(description="商品标题"),
  product_image STRING OPTIONS(description="商品图片")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);