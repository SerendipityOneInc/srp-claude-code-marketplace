CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_favie_product_sample_1d`
(
  domain STRING OPTIONS(description="域名"),
  product_link STRING OPTIONS(description="商品链接"),
  product_title STRING OPTIONS(description="商品标题"),
  product_image STRING OPTIONS(description="商品图片"),
  product_data STRING OPTIONS(description="商品数据"),
  dt DATE OPTIONS(description="分区，日期")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true,
  description="所属业务库: 商品详情库  \n所属数仓层级: RPT层(分析层)\n分区字段: dt（字段格式 yyyy-MM-dd）\n更新策略: 每日更新\n模型主键: domain\n负责人:\n- 庞宝辉\n- 付继文\n- 马汝钊  \n生命周期（分区TTL）: 永久\n用途: >\n  此表是针对于每日商品详情全量表的抽检,以更好更直观的观测数据的质量"
);