CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_product_image_crawl_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  site STRING OPTIONS(description="商品站点名称"),
  shop_site STRING OPTIONS(description="商品店铺站点名称"),
  uploader_type STRING OPTIONS(description="图片上传方式"),
  status STRING OPTIONS(description="图片状态"),
  f_sku_id STRING OPTIONS(description="商品SKU"),
  link STRING OPTIONS(description="商品链接"),
  image_link STRING OPTIONS(description="错误图片数"),
  image_category STRING OPTIONS(description="图片分类")
)
PARTITION BY dt
OPTIONS(
  partition_expiration_days=14.0,
  require_partition_filter=true
);