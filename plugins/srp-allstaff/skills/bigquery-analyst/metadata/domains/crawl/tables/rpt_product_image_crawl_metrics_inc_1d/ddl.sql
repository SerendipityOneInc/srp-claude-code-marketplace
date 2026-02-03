CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_product_image_crawl_metrics_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  site STRING OPTIONS(description="商品站点名称"),
  shop_site STRING OPTIONS(description="商品店铺站点名称"),
  uploader_type STRING OPTIONS(description="图片上传方式"),
  status STRING OPTIONS(description="图片状态"),
  image_category STRING OPTIONS(description="图片分类"),
  download_image_cnt INT64 OPTIONS(description="图片数"),
  download_image_sku_cnt INT64 OPTIONS(description="SKU数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);