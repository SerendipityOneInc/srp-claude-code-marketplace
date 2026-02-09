CREATE TABLE `srpproduct-dc37e.favie_dw.dws_gem_product_tag_value_dist_inc_1d`
(
  dt DATE OPTIONS(description="事件发生日期"),
  site STRING OPTIONS(description="商品来源网站（如 us.princesspolly.com）"),
  collage_category STRING OPTIONS(description="商品类别（Top/Bottom/One-Piece等13类+null）"),
  tag STRING OPTIONS(description="标签名称（枚举：occasion, material）"),
  tag_value STRING OPTIONS(description="标签的具体取值（如 'Casual', 'Cotton' 等，未聚合的原始值）"),
  sku_cnt INT64 OPTIONS(description="在当前维度下，具有相应标签值的 SKU 去重数量")
)
PARTITION BY dt;