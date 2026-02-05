CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dwd_favie_product_review_full_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  description="所属业务库: 商品详情库  \n所属数仓层级: DWD层\n分区字段: dt（字段格式 yyyy-MM-dd）\n更新策略: 每日全量更新\n模型主键: f_review_id\n负责人:\n- 庞宝辉\n- 付继文\n- 马汝钊  \n生命周期（分区TTL）: 7天\n用途: >\n  此表是评价库的全量明细数据,每天更新全量数据, 使用dt= {yesterday} 即可查询昨日全量快照,除非有特定需求否则不要选取多天\n\n保持字段含义一致的表集合:\n - favie_dw.dwd_favie_product_review_flat_inc_1h \n - favie_dw.dwd_favie_product_review_full_1d\n\n 以上表的字段含义、字段名称、字段数量保持一致,在查询字段含义时,如果所目标表没有的字段说明,可以查询表集合的字段含义",
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_product_review_full_1d/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dwd_favie_product_review_full_1d/dt=*"]
);