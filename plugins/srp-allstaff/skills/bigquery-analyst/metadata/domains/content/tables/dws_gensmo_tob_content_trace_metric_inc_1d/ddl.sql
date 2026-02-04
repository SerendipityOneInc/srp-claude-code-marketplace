CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  site STRING OPTIONS(description="站点"),
  country STRING OPTIONS(description="国家"),
  vibe_id STRING OPTIONS(description="Vibe ID"),
  product_id STRING OPTIONS(description="商品ID"),
  vibe_image_url STRING OPTIONS(description="Vibe图片链接"),
  try_on_image_url STRING OPTIONS(description="试穿图片链接"),
  product_url STRING OPTIONS(description="商品链接"),
  product_image_url STRING OPTIONS(description="商品图片链接"),
  show_cnt INT64 OPTIONS(description="展示次数"),
  click_cnt INT64 OPTIONS(description="点击次数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);