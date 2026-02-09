CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_size_distribution_full_1d`
AS SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  'Less than 10KB' AS size_category,
  image_size_lt_10k AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"

UNION ALL

SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  '10KB to 100KB' AS size_category,
  image_size_10k_to_100k AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"

UNION ALL

SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  '100KB to 500KB' AS size_category,
  image_size_100k_to_500k AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"

UNION ALL

SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  '500KB to 1MB' AS size_category,
  image_size_500k_to_1m AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"

UNION ALL

SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  '1MB to 5MB' AS size_category,
  image_size_1m_to_5m AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"

UNION ALL

SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  '5MB to 20MB' AS size_category,
  image_size_5m_to_20m AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"

UNION ALL

SELECT
  dt,
  CASE 
    WHEN source_type = 1 THEN 'product_image'
    WHEN source_type = 2 THEN 'review_image'
    WHEN source_type = 3 THEN 'webpage_image'
  END AS image_source,
  site,
  'Greater than 20MB' AS size_category,
  image_size_gt_20m AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10";