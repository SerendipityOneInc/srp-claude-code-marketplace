CREATE EXTERNAL TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_product_review_metric_inc_1h`
WITH PARTITION COLUMNS (
  dt STRING,
  hour STRING
)
OPTIONS(
  description="所属业务库: 商品详情库  \n所属数仓层级: RPT层(分析层)\n分区字段: dt,hour（字段格式 yyyy-MM-dd）\n更新策略: 每日更新\n模型主键: site\n负责人:\n- 庞宝辉\n- 付继文\n- 马汝钊  \n生命周期（分区TTL）: 永久\n用途: >\n  此表是对于每小时评论表的以站点维度进行分析的小时分析表",
  format="PARQUET",
  hive_partition_uri_prefix="gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_product_review_metric_inc_1h/",
  require_hive_partition_filter=true,
  uris=["gs://srp-warehouse-favie_rpt-production/favie_rpt.db/rpt_favie_product_review_metric_inc_1h/dt=*"]
);