CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_favie_gem_moodboards_inc_1d_view`
AS WITH logging_gem_moodboards_stderr AS (
  SELECT 
    jsonPayload.trace_id as trace_id,
    jsonPayload.id AS moodboard_id, 
    jsonPayload.products AS products,
    `timestamp` as log_timestamp,
    receiveTimestamp as receive_timestamp,
    PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
  FROM `logging_gem_moodboards.stderr_*`
),

logging_gem_moodboards_unnest_product_of_stderr AS (
  SELECT
    trace_id,
    moodboard_id,
    product,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_moodboards_stderr,UNNEST(products) AS product
),

logging_gem_moodboards_explode_product_of_stderr AS(
  SELECT
    trace_id,
    moodboard_id,
    product.global_id as product_sku_id,
    product.source AS product_site,
    product.brand AS product_brand,
    product.buybox_winner.price.raw AS product_price_raw,
    product.link AS product_link,
    product.query AS product_query,
    product.rating AS product_rating,
    product.ratings_total AS product_ratings_total,
    product.tags.cate_tag AS product_cate_tag,
    product.title AS product_title,
    product.search_engine AS search_engine,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_moodboards_unnest_product_of_stderr
),


-------------------------------------logging_gem_moodboards.export_errors_*------------------------------------------------
logging_gem_moodboards_export_errors AS (
  SELECT 
    JSON_VALUE(logEntry, '$.jsonPayload.trace_id') AS trace_id,
    JSON_VALUE(logEntry, '$.jsonPayload.id') AS moodboard_id,
    JSON_EXTRACT_ARRAY(logEntry, '$.jsonPayload.products') AS products,
    `timestamp` as log_timestamp,
    receiveTimestamp as receive_timestamp,
    PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) as dt
  from `logging_gem_moodboards.export_errors_*`
),

logging_gem_moodboards_unnest_product_of_export_errors AS (
  SELECT
    trace_id,
    moodboard_id,
    product,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_moodboards_export_errors,UNNEST(products) AS product
),

logging_gem_moodboards_explode_product_of_export_errors AS(
  SELECT
    trace_id,
    moodboard_id,
    json_extract_scalar(product,"$.global_id") as product_sku_id,
    json_extract_scalar(product,"$.source") as product_site,
    json_extract_scalar(product,"$.brand") as product_brand,
    json_extract_scalar(product,"$.buybox_winner.price.raw") as product_price_raw,
    json_extract_scalar(product,"$.link") as product_link,
    json_extract_scalar(product,"$.query") as product_query,
    safe_cast(json_extract_scalar(product,"$.rating") as float64) as product_rating,
    safe_cast(json_extract_scalar(product,"$.ratings_total") as int64) as product_ratings_total,
    json_extract_scalar(product,"$.tags.cate_tag") as product_cate_tag,
    json_extract_scalar(product,"$.title") as product_title,
    json_extract_scalar(product,"$.search_engine") as search_engine,
    log_timestamp,
    receive_timestamp,
    dt
  FROM logging_gem_moodboards_unnest_product_of_export_errors
),

logging_gem_moodboards_explode_product as (
  select 
    *
  from  logging_gem_moodboards_explode_product_of_export_errors
  union all
  select 
    *
  from logging_gem_moodboards_explode_product_of_stderr
)

select 
  trace_id,
  moodboard_id,
  product_sku_id,
  product_site,
  product_brand,
  product_price_raw,
  product_link,
  product_query,
  product_rating,
  product_ratings_total,
  product_cate_tag,
  product_title,
  search_engine,
  log_timestamp,
  receive_timestamp,
  dt
from logging_gem_moodboards_explode_product;