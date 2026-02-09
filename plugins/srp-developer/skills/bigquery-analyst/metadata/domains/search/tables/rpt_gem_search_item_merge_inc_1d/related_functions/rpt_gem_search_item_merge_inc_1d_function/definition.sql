WITH workflow_all AS (
    SELECT
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.image_url') AS search_image,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.trace_id') AS trace_id,
      TIMESTAMP(JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.created_time')) AS created_time,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.intention') AS intention,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.user_id') AS user_id,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.header_info.device_region_identifier') AS region,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.gem_debug_infos.product_search_engine') AS product_search_engine,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.qr_debug_infos.debug_infos.route') AS route,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.qr_debug_infos.gender') AS gender,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.device_id') AS device_id,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.header_info.f_version') AS f_version,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.header_info.cf_ipcountry') AS cf_ipcountry,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.query') AS query,
      CAST(JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.search_latency') AS FLOAT64) AS search_latency,
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.f_source') AS f_source
    FROM `srpproduct-dc37e.logging_gem_workflow.export_errors_*`
    WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', dt_param)
    UNION ALL
    SELECT
      jsonPayload.image_url AS search_image,
      jsonPayload.trace_id,
      TIMESTAMP(jsonPayload.created_time),
      jsonPayload.intention,
      jsonPayload.user_id,
      jsonPayload.header_info.device_region_identifier,
      jsonPayload.gem_debug_infos.product_search_engine,
      jsonPayload.qr_debug_infos.debug_infos.route,
      jsonPayload.qr_debug_infos.gender,
      jsonPayload.device_id,
      jsonPayload.header_info.f_version,
      jsonPayload.header_info.cf_ipcountry,
      jsonPayload.query,
      jsonPayload.search_latency,
      jsonPayload.f_source
    FROM `srpproduct-dc37e.logging_gem_workflow.stderr_*`
    WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', dt_param)
  ),
  products_all AS (
    SELECT
      jsonPayload.trace_id,
      TIMESTAMP(timestamp) AS created_time,
      product.f_images.main_image AS main_image,
      product.f_images_tags AS f_images_tags_str,
      product.brand AS brand,
      product.platform AS platform,
      REGEXP_EXTRACT(product.link, r'https?://([^/]+)') AS link_domain
    FROM `srpproduct-dc37e.logging_gem_moodboards.stderr_*`
    CROSS JOIN UNNEST(jsonPayload.products) AS product
    WHERE product.f_images.main_image IS NOT NULL
      AND _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', dt_param)
    UNION ALL
    SELECT
      JSON_EXTRACT_SCALAR(logEntry, '$.jsonPayload.trace_id'),
      TIMESTAMP(REGEXP_REPLACE(JSON_EXTRACT_SCALAR(logEntry, '$.timestamp'), r'(\.\d{6})\d+Z', r'\1Z')),
      JSON_EXTRACT_SCALAR(product_json, '$.f_images.main_image'),
      JSON_EXTRACT_SCALAR(product_json, '$.f_images_tags'),
      JSON_EXTRACT_SCALAR(product_json, '$.brand'),
      JSON_EXTRACT_SCALAR(product_json, '$.platform'),
      REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(product_json, '$.link'), r'https?://([^/]+)')
    FROM `srpproduct-dc37e.logging_gem_moodboards.export_errors_*`,
         UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT(logEntry, '$.jsonPayload.products'))) AS product_json
    WHERE JSON_EXTRACT_SCALAR(product_json, '$.f_images.main_image') IS NOT NULL
      AND _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', dt_param)
  ),
  collage_numbering AS (
    SELECT
      jsonPayload.trace_id AS trace_id,
      TIMESTAMP(timestamp) AS created_time,
      ROW_NUMBER() OVER (PARTITION BY jsonPayload.trace_id ORDER BY TIMESTAMP(timestamp)) AS collage_number
    FROM `srpproduct-dc37e.logging_gem_moodboards.stderr_*`
    WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', dt_param)
  ),
  parsed_images AS (
    SELECT
      p.trace_id,
      c.collage_number,
      p.created_time,
      p.main_image AS product_main_image_url,
      REGEXP_EXTRACT(p.main_image, r'^([^?#]+)') AS main_image_path,
      tag.url AS tag_image_url,
      REGEXP_EXTRACT(tag.url, r'^([^?#]+)') AS tag_image_path,
      tag.info AS product_image_info,
      p.brand,
      p.platform,
      p.link_domain
    FROM products_all p
    JOIN collage_numbering c
      ON p.trace_id = c.trace_id AND p.created_time = c.created_time
    LEFT JOIN UNNEST(
      ARRAY(
        SELECT AS STRUCT
          REGEXP_EXTRACT(kv, r'"([^"]+)":') AS url,
          REGEXP_REPLACE(kv, r'^"[^"]+":', '') AS info
        FROM UNNEST(REGEXP_EXTRACT_ALL(p.f_images_tags_str, r'\{[^}]+\}')) AS kv
      )
    ) AS tag
  ),
  matched_images AS (
    SELECT
      trace_id,
      collage_number,
      created_time,
      product_main_image_url,
      brand,
      platform,
      link_domain,
      ARRAY_AGG(product_image_info ORDER BY tag_image_url DESC LIMIT 1)[OFFSET(0)] AS product_image_info
    FROM parsed_images
    WHERE main_image_path = tag_image_path
    GROUP BY trace_id, collage_number, created_time, product_main_image_url, brand, platform, link_domain
  ),
  combined AS (
    SELECT
      w.*,
      COALESCE(m.collage_number, 0) AS collage_number,
      m.product_main_image_url,
      COALESCE(m.product_image_info, '{}') AS product_image_info,
      m.brand,
      m.platform,
      m.link_domain
    FROM workflow_all w
    LEFT JOIN matched_images m
      ON w.trace_id = m.trace_id
  ),
  collage_quality AS (
    SELECT
      trace_id,
      collage_number,
      LOGICAL_AND(
        SAFE_CAST(JSON_EXTRACT_SCALAR(product_image_info, '$.best_view') AS INT64) = 1 AND
        SAFE_CAST(JSON_EXTRACT_SCALAR(product_image_info, '$.has_person') AS INT64) = 0 AND
        SAFE_CAST(JSON_EXTRACT_SCALAR(product_image_info, '$.is_bad') AS INT64) = 0 AND
        SAFE_CAST(JSON_EXTRACT_SCALAR(product_image_info, '$.is_clearBackground') AS INT64) = 1 AND
        SAFE_CAST(JSON_EXTRACT_SCALAR(product_image_info, '$.is_relevant') AS INT64) = 1
      ) AS is_nice_collage
    FROM combined
    WHERE collage_number > 0
    GROUP BY trace_id, collage_number
  )

  SELECT
    c.trace_id,
    c.search_image,
    c.collage_number,
    c.created_time,
    date(c.created_time) As created_date,
    c.product_main_image_url,
    c.product_image_info,
    SAFE_CAST(JSON_EXTRACT_SCALAR(c.product_image_info, '$.best_view') AS INT64) AS best_view,
    SAFE_CAST(JSON_EXTRACT_SCALAR(c.product_image_info, '$.has_person') AS INT64) AS has_person,
    SAFE_CAST(JSON_EXTRACT_SCALAR(c.product_image_info, '$.is_bad') AS INT64) AS is_bad,
    SAFE_CAST(JSON_EXTRACT_SCALAR(c.product_image_info, '$.is_clearBackground') AS INT64) AS is_clear_background,
    SAFE_CAST(JSON_EXTRACT_SCALAR(c.product_image_info, '$.is_relevant') AS INT64) AS is_relevant,
    cq.is_nice_collage,
    c.brand,
    c.platform,
    c.link_domain AS link_host,
    c.intention,
    c.user_id,
    c.region,
    c.product_search_engine,
    c.route,
    c.gender,
    c.device_id,
    c.f_version,
    c.cf_ipcountry,
    c.query,
    c.f_source,
    c.search_latency
  FROM combined c
  LEFT JOIN collage_quality cq
    ON c.trace_id = cq.trace_id AND c.collage_number = cq.collage_number