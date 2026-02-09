CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_normalize_field_enum_distribution_1d`
(
  field_name STRING OPTIONS(description="字段名称"),
  enum_value STRING OPTIONS(description="归一化后的枚举值"),
  is_array_field BOOL OPTIONS(description="是否为数组字段（逗号分隔多值）"),
  product_count INT64 OPTIONS(description="商品数量（包含该枚举值的商品数）"),
  product_ratio FLOAT64 OPTIONS(description="商品占比 (0-1)，分母为总商品数"),
  mention_count INT64 OPTIONS(description="提及次数（数组字段拆分后的行数）"),
  mention_ratio FLOAT64 OPTIONS(description="提及占比 (0-1)，分母为该字段总提及次数"),
  value_rank INT64 OPTIONS(description="排名（按商品数从大到小）"),
  cumulative_product_ratio FLOAT64 OPTIONS(description="商品累计占比"),
  cumulative_mention_ratio FLOAT64 OPTIONS(description="提及累计占比"),
  created_at TIMESTAMP OPTIONS(description="记录创建时间"),
  dt DATE OPTIONS(description="统计日期")
)
PARTITION BY dt
OPTIONS(
  description="归一化后字段枚举值分布统计表，按日期分区。v2版本新增 mention_ratio 支持数组字段正确的累计覆盖率计算",
  labels=[("team", "data"), ("domain", "product")]
);