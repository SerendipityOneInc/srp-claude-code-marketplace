CREATE TABLE `srpproduct-dc37e.favie_rpt.rpt_normalize_uncovered_values_1d`
(
  field_name STRING OPTIONS(description="Field name: product_item, pattern, color, shape, material, style"),
  original_value STRING OPTIONS(description="Original value not found in mapping table"),
  product_count INT64 OPTIONS(description="Number of products with this value"),
  cumulative_product_count INT64 OPTIONS(description="Cumulative product count ordered by product_count DESC"),
  value_rank INT64 OPTIONS(description="Rank by product_count DESC"),
  first_seen_dt DATE OPTIONS(description="First date this uncovered value was seen"),
  last_seen_dt DATE OPTIONS(description="Most recent date this uncovered value was seen"),
  days_uncovered INT64 OPTIONS(description="Number of days value has been uncovered: DATE_DIFF(last_seen_dt, first_seen_dt, DAY) + 1"),
  model_version STRING OPTIONS(description="Model version"),
  created_at TIMESTAMP OPTIONS(description="Record creation timestamp"),
  dt DATE OPTIONS(description="Partition date")
)
PARTITION BY dt
OPTIONS(
  require_partition_filter=true,
  description="Uncovered values tracking for normalized fields"
);