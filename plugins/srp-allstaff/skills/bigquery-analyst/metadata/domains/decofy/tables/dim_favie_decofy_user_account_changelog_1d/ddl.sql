CREATE TABLE `srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_changelog_1d`
(
  process_date DATE,
  updated_at TIMESTAMP,
  created_at TIMESTAMP,
  user_id STRING,
  first_device_id STRING,
  last_device_id STRING,
  appsflyer_id STRING,
  device_ids ARRAY<STRING>,
  user_name STRING,
  user_email STRING,
  user_type INT64,
  is_internal_user BOOL,
  geo_address STRUCT<geo_continent_name STRING, geo_sub_continent_name STRING, geo_country_name STRING, geo_region_name STRING, geo_metro_name STRING, geo_city_name STRING>,
  app_info STRUCT<platform STRING, app_version STRING>
)
CLUSTER BY user_type;