CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_normalize_mapping_coverage_1d`
(
  field_name STRING OPTIONS(description="Field name: product_item, pattern, color, shape, material, style"),
  data_scope STRING OPTIONS(description="Data scope: inc=incremental, full=full data"),
  total_products INT64 OPTIONS(description="Total products with non-empty field value"),
  covered_products INT64 OPTIONS(description="Products with field value found in mapping table"),
  uncovered_products INT64 OPTIONS(description="Products with field value NOT in mapping table"),
  product_coverage_rate FLOAT64 OPTIONS(description="Product coverage rate: covered_products / total_products * 100"),
  total_distinct_values INT64 OPTIONS(description="Total distinct original values"),
  covered_distinct_values INT64 OPTIONS(description="Distinct values found in mapping table"),
  uncovered_distinct_values INT64 OPTIONS(description="Distinct values NOT in mapping table"),
  value_coverage_rate FLOAT64 OPTIONS(description="Value coverage rate: covered_distinct_values / total_distinct_values * 100"),
  model_version STRING OPTIONS(description="Model version"),
  created_at TIMESTAMP OPTIONS(description="Record creation timestamp"),
  dt DATE OPTIONS(description="Partition date")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true,
  description="Mapping coverage statistics for normalized fields"
);