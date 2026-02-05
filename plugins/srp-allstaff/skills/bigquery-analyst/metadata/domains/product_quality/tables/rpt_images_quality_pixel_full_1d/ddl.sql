CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_full_1d`
(
  product_f_creates_at DATE OPTIONS(description="商品创建时间"),
  site STRING OPTIONS(description="站点"),
  sku_total_cnt INT64 OPTIONS(description="SKU总数"),
  spu_total_cnt INT64 OPTIONS(description="SPU总数"),
  possess_tiny_image_sku_cnt INT64 OPTIONS(description="有tiny image的SKU数"),
  possess_small_image_sku_cnt INT64 OPTIONS(description="有small image的SKU数"),
  possess_medium_image_sku_cnt INT64 OPTIONS(description="有medium image的SKU数"),
  possess_large_image_sku_cnt INT64 OPTIONS(description="有large image的SKU数"),
  possess_tiny_main_image_sku_cnt INT64 OPTIONS(description="主图是tiny image的SKU数"),
  possess_small_main_image_sku_cnt INT64 OPTIONS(description="主图是small image的SKU数"),
  possess_medium_main_image_sku_cnt INT64 OPTIONS(description="主图是medium image的SKU数"),
  possess_large_main_image_sku_cnt INT64 OPTIONS(description="主图是large image的SKU数"),
  possess_tiny_image_spu_cnt INT64 OPTIONS(description="有tiny image的SPU数"),
  possess_small_image_spu_cnt INT64 OPTIONS(description="有small image的SPU数"),
  possess_medium_image_spu_cnt INT64 OPTIONS(description="有medium image的SPU数"),
  possess_large_image_spu_cnt INT64 OPTIONS(description="有large image的SPU数"),
  possess_tiny_main_image_spu_cnt INT64 OPTIONS(description="主图是tiny image的SPU数"),
  possess_small_main_image_spu_cnt INT64 OPTIONS(description="主图是small image的SPU数"),
  possess_medium_main_image_spu_cnt INT64 OPTIONS(description="主图是medium image的SPU数"),
  possess_large_main_image_spu_cnt INT64 OPTIONS(description="主图是large image的SPU数"),
  dt DATE OPTIONS(description="日期")
)
PARTITION BY dt;