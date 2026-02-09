CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_gem_search_inc_1d_view`
AS WITH logging_gem_search_product_list_stderr AS (
  SELECT 
    jsonPayload.trace_id as trace_id,
    jsonPayload.product_list AS products,
    `timestamp` as log_timestamp,
    receiveTimestamp as receive_timestamp,
    PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
  FROM `srpproduct-dc37e.logging_gem_search_product_list.stderr_*`
),

logging_gem_search_product_list_unnest_product_of_stderr AS (
  SELECT
    trace_id,
    product,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_search_product_list_stderr,UNNEST(products) AS product
),

logging_gem_search_product_list_explode_product_of_stderr AS(
  SELECT
    trace_id,
    product.global_id as product_sku_id,
    product.source AS product_site,
    product.brand AS product_brand,
    cast(null as STRING) as product_price_currency,
    cast(null as int64) as product_price_value,
    product.buybox_winner.price.raw AS product_price_raw,
    product.link AS product_link,
    product.query AS product_query,
    if(product.f_image_list[SAFE_OFFSET(0)] is not null,product.f_image_list[SAFE_OFFSET(0)].f_link,null) as product_image_link,
    product.rating AS product_rating,
    product.ratings_total AS product_ratings_total,
    product.tags.cate_tag AS product_cate_tag,
    product.title AS product_title,
    product.f_updates_at as product_updates_at,
    product.f_creates_at as product_creates_at,
    product.search_engine AS search_engine,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_search_product_list_unnest_product_of_stderr
),


-------------------------------------srpproduct-dc37e.logging_gem_moodboards.export_errors_*------------------------------------------------
logging_gem_search_product_list_export_errors AS (
  SELECT 
    JSON_VALUE(logEntry, '$.jsonPayload.trace_id') AS trace_id,
    JSON_EXTRACT_ARRAY(logEntry, '$.jsonPayload.product_list') AS products,
    `timestamp` as log_timestamp,
    receiveTimestamp as receive_timestamp,
    PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
  from `srpproduct-dc37e.logging_gem_search_product_list.export_errors_*`
),

logging_gem_search_product_list_unnest_product_of_export_errors AS (
  SELECT
    trace_id,
    product,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_search_product_list_export_errors,UNNEST(products) AS product
),

logging_gem_search_product_list_explode_product_of_export_errors AS(
  SELECT
    trace_id,
    json_extract_scalar(product,"$.global_id") as product_sku_id,
    json_extract_scalar(product,"$.source") as product_site,
    json_extract_scalar(product,"$.brand") as product_brand,
    cast(null as STRING) as product_price_currency,
    cast(null as int64) as product_price_value,
    json_extract_scalar(product,"$.buybox_winner.price.raw") as product_price_raw,
    json_extract_scalar(product,"$.link") as product_link,
    json_extract_scalar(product,"$.query") as product_query,
    json_extract_scalar(json_extract_array(product,"$.f_image_list")[SAFE_OFFSET(0)],"$.f_link") as product_image_link ,
    safe_cast(json_extract_scalar(product,"$.rating") as float64) as product_rating,
    safe_cast(json_extract_scalar(product,"$.ratings_total") as int64) as product_ratings_total,
    json_extract_scalar(product,"$.tags.cate_tag") as product_cate_tag,
    json_extract_scalar(product,"$.title") as product_title,
    json_extract_scalar(product,"$.f_updates_at") as product_updates_at,
    json_extract_scalar(product,"$.f_creates_at") as product_creates_at,
    json_extract_scalar(product,"$.search_engine") as search_engine,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_search_product_list_unnest_product_of_export_errors
),

logging_gem_search_product_list_explode_product as (
  select 
    *
  from  logging_gem_search_product_list_explode_product_of_export_errors
  union all
  select 
    *
  from logging_gem_search_product_list_explode_product_of_stderr
)

select 
  trace_id,
  product_sku_id,
  product_site,
  product_brand,
  product_price_currency,
  product_price_value,
  product_price_raw,
  product_link,
  product_query,
  product_image_link,
  product_rating,
  product_ratings_total,
  product_cate_tag,
  product_title,
  product_updates_at,
  product_creates_at,
  search_engine,
  log_timestamp,
  receive_timestamp,
  dt
from logging_gem_search_product_list_explode_product;