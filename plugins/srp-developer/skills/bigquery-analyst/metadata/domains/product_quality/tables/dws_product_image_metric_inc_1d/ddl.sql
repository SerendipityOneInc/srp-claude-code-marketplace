CREATE TABLE `srpproduct-dc37e.favie_dw.dws_product_image_metric_inc_1d`
(
  dt DATE OPTIONS(description="日期"),
  site STRING OPTIONS(description="站点"),
  site_tier STRING OPTIONS(description="站点等级"),
  site_type STRING OPTIONS(description="站点类型"),
  site_rank STRING OPTIONS(description="站点排名"),
  site_categories STRING OPTIONS(description="站点类别"),
  site_parser_type STRING OPTIONS(description="站点解析类型"),
  site_country_region STRING OPTIONS(description="站点国家或地区"),
  image_size_type STRING OPTIONS(description="图片尺寸类别"),
  image_category STRING OPTIONS(description="图片类别"),
  total_sku_cnt INT64 OPTIONS(description="SKU总数"),
  total_spu_cnt INT64 OPTIONS(description="SPU总数"),
  image_sku_cnt INT64 OPTIONS(description="image的SKU数"),
  image_spu_cnt INT64 OPTIONS(description="image的SPU数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);