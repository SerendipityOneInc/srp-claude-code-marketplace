CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_dw.dws_favie_product_detail_sku_metric_full_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  description="所属业务库: 商品详情库  \n所属数仓层级: DWS层\n分区字段: dt（dt字段格式:yyyy-MM-dd）\n更新策略: 每日增量更新\n模型主键: f_sku_id\n负责人:\n- 庞宝辉\n- 付继文\n- 马汝钊  \n生命周期（分区TTL）: 7天\n用途: >\n  此表是商品详情库(通过数据校验的数据)的每天全量明细数据,在商品每日全量明细表(favie_dw.dwd_favie_product_detail_full_1d)新增了分析字段\n保持字段含义一致的表集合:\n - favie_dw.dwd_favie_product_detail_failure_flat_inc_1h\n - favie_dw.dwd_favie_product_detail_full_1d\n - favie_dw.dwd_favie_product_detail_inc_1d\n - favie_dw.dwd_favie_product_detail_flat_inc_1h  \n 以上表的字段含义、字段名称、字段数量保持一致,在查询字段含义时,如果所目标表没有的字段说明,可以查询表集合(以favie_dw.dwd_favie_product_detail_full_1d字段含义为参考)的字段含义",
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_dw-production/favie_dw.db/dws_favie_product_detail_sku_metric_full_1d/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_dw-production/favie_dw.db/dws_favie_product_detail_sku_metric_full_1d/dt=*"]
);