CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_quality_source_update_inc_1d`
(
  parser_name STRING OPTIONS(description="爬虫名称"),
  source_type STRING OPTIONS(description="数据源类型"),
  site STRING OPTIONS(description="站点"),
  shop_site STRING OPTIONS(description="店铺站点"),
  dt DATE OPTIONS(description="日期"),
  total_update_times INT64 OPTIONS(description="总更新次数"),
  effective_update_times INT64 OPTIONS(description="有效更新次数"),
  ineffective_update_times INT64 OPTIONS(description="无效更新次数"),
  update_sku_cnt INT64 OPTIONS(description="更新SKU数"),
  new_added_sku_cnt INT64 OPTIONS(description="新增SKU数")
)
PARTITION BY dt
OPTIONS(
  description="所属业务库: 商品详情库  \n所属数仓层级: RPT层(分析层)\n分区字段: dt（字段格式 yyyy-MM-dd）\n主题域:数据质量\n更新策略: 每日更新\n模型主键: parser_name,source_type,site,shop_site\n负责人:\n- 庞宝辉\n- 付继文\n- 马汝钊  \n生命周期（分区TTL）: 永久\n用途: >\n  此表是针对于每日商品成功变更增量表和每日商品增量失败变更增量表分析每一个爬虫产生数据的质量以及对全量商品详情库的数据质量的影响"
);