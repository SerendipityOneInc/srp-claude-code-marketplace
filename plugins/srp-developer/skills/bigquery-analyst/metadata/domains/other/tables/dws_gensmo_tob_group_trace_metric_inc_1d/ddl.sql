CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d`
(
  dt DATE OPTIONS(description="分区，日期"),
  site STRING OPTIONS(description="站点"),
  country STRING OPTIONS(description="国家"),
  impid STRING OPTIONS(description="曝光ID"),
  exp_id STRING OPTIONS(description="实验ID"),
  vibe_list ARRAY<STRUCT<vibe_id STRING, business_product_id STRING, vibe_image_url STRING, try_on_image_url STRING>> OPTIONS(description="Vibe ID"),
  product_id STRING OPTIONS(description="商品ID"),
  product_url STRING OPTIONS(description="商品链接"),
  product_image_url STRING OPTIONS(description="商品图片链接"),
  show_cnt INT64 OPTIONS(description="展示次数"),
  click_cnt INT64 OPTIONS(description="点击次数"),
  unique_click_cnt INT64 OPTIONS(description="去重点击次数"),
  unique_click_product_cnt INT64 OPTIONS(description="去重点击商品次数")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true
);