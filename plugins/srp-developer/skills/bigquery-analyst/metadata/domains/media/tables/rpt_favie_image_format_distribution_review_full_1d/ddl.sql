CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_image_format_distribution_review_full_1d`
AS SELECT
  dt,
  case 
    when source_type = 1 then 'product_image'
    when source_type = 2 then 'review_image'
    when source_type = 3 then 'webpage_image'
  end as image_source,
  site,
  'JPEG' AS format, 
  image_format_jpeg AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"
UNION ALL
SELECT
  dt,
  case 
    when source_type = 1 then 'product_image'
    when source_type = 2 then 'review_image'
    when source_type = 3 then 'webpage_image'
  end as image_source,
  site,
  'PNG' AS format, 
  image_format_png AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"
UNION ALL
SELECT
  dt,
  case 
    when source_type = 1 then 'product_image'
    when source_type = 2 then 'review_image'
    when source_type = 3 then 'webpage_image'
  end as image_source,
  site,
  'GIF' AS format, 
  image_format_gif AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"
UNION ALL
SELECT
  dt,
  case 
    when source_type = 1 then 'product_image'
    when source_type = 2 then 'review_image'
    when source_type = 3 then 'webpage_image'
  end as image_source,
  site,
  'WEBP' AS format, 
  image_format_webp AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10"
UNION ALL
SELECT
  dt,
  case 
    when source_type = 1 then 'product_image'
    when source_type = 2 then 'review_image'
    when source_type = 3 then 'webpage_image'
  end as image_source,
  site,
  'Other' AS format, 
  image_format_other AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10";