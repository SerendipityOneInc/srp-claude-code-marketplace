CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_image_pixel_distribution_review_full_1d`
AS SELECT
  dt,
  case 
    when source_type = 1 then 'product_image'
    when source_type = 2 then 'review_image'
    when source_type = 3 then 'webpage_image'
  end as image_source,
  site,
  'Tiny (< 320x240)' AS pixel_category, image_pixel_tiny AS count
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
  'Small (320x240 - 640x480)' AS pixel_category, image_pixel_small AS count
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
  'Medium (640x480 - 1024x768)' AS pixel_category, image_pixel_medium AS count
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
  'Large (1024x768 - 1920x1080)' AS pixel_category, image_pixel_large AS count
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
  '2K (1920x1080 - 2560x1440)' AS pixel_category, image_pixel_2k AS count
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
  '4K (2560x1440 - 3840x2160)' AS pixel_category, image_pixel_4k AS count
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
  '8K+ (> 3840x2160)' AS pixel_category, image_pixel_gt_8k AS count
FROM `favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= "2024-11-10";