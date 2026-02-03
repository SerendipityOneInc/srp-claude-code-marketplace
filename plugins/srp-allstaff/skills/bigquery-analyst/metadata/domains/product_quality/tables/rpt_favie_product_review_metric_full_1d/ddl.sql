CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_full_1d`
WITH PARTITION COLUMNS (
  dt STRING
)
OPTIONS(
  description="所属业务库: 商品详情库  \n所属数仓层级: RPT层(分析层)\n分区字段: dt（字段格式 yyyy-MM-dd）\n主题域:数据质量\n更新策略: 每日更新\n模型主键: site,shop_site\n负责人:\n- 庞宝辉\n- 付继文\n- 马汝钊  \n生命周期（分区TTL）:永久\n用途: >\n  此表是针对于每日评论全量快照表,以站点维度进行对数据质量分析",
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_product_review_metric_full_1d/",
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_product_review_metric_full_1d/dt=*"]
);