CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_normalize_non_mapping_field_stats_1d`
(
  field_name STRING OPTIONS(description="Field name without mapping table"),
  data_scope STRING OPTIONS(description="Data scope: inc=incremental, full=full data"),
  total_products INT64 OPTIONS(description="Total products with non-empty field value"),
  total_distinct_values INT64 OPTIONS(description="Total distinct values"),
  values_for_50pct_coverage INT64 OPTIONS(description="Number of top values needed to cover 50% of products"),
  values_for_60pct_coverage INT64 OPTIONS(description="Number of top values needed to cover 60% of products"),
  values_for_70pct_coverage INT64 OPTIONS(description="Number of top values needed to cover 70% of products"),
  values_for_80pct_coverage INT64 OPTIONS(description="Number of top values needed to cover 80% of products"),
  values_for_90pct_coverage INT64 OPTIONS(description="Number of top values needed to cover 90% of products"),
  values_for_95pct_coverage INT64 OPTIONS(description="Number of top values needed to cover 95% of products"),
  top_values_json STRING OPTIONS(description="JSON array of top 20 values with counts"),
  model_version STRING OPTIONS(description="Model version"),
  created_at TIMESTAMP OPTIONS(description="Record creation timestamp"),
  dt DATE OPTIONS(description="Partition date")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true,
  description="Distribution statistics for fields without mapping tables"
);