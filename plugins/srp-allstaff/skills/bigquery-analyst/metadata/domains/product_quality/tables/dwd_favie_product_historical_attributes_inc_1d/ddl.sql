CREATE TABLE `srpproduct-dc37e.favie_dw.dwd_favie_product_historical_attributes_inc_1d`
(
  dt DATE OPTIONS(description="分区日期"),
  f_sku_id STRING OPTIONS(description="SKU ID"),
  f_spu_id STRING OPTIONS(description="SPU ID"),
  site STRING OPTIONS(description="站点"),
  price STRING OPTIONS(description="价格，JSON结构"),
  recent_sales STRING OPTIONS(description="近期销量"),
  best_seller_rank STRING OPTIONS(description="畅销榜，JSON数组"),
  review_summary STRING OPTIONS(description="评论摘要，JSON结构"),
  f_updated_at STRING OPTIONS(description="更新时间"),
  f_created_at STRING OPTIONS(description="创建时间"),
  f_meta STRING OPTIONS(description="元信息，JSON结构")
)
PARTITION BY dt
CLUSTER BY f_sku_id
OPTIONS(
  require_partition_filter=true,
  description="产品历史属性增量表（日分区）"
);