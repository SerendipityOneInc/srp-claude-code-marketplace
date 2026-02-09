CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_feed_collage_full_view`
AS WITH base AS (
  SELECT
    JSON_VALUE(tag_value, '$.moodboard_id') AS collage_id,
    JSON_QUERY_ARRAY(tag_value, '$.moodboard_tags') AS tags
  FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
),
exploded_tags AS (
  SELECT
    collage_id,
    JSON_VALUE(tag, '$.Category') AS category,
    JSON_QUERY_ARRAY(tag, '$.Candidates') AS candidates
  FROM base,
  UNNEST(tags) AS tag
),
exploded_candidates AS (
  SELECT
    collage_id,
    category,
    JSON_VALUE(candidate, '$.Primary') AS primary,
    JSON_VALUE(candidate, '$.Secondary') AS secondary
  FROM exploded_tags,
  UNNEST(candidates) AS candidate
),
tags_agg AS (
  SELECT
    collage_id,
    ARRAY_AGG(STRUCT(category, primary, secondary)) AS tag_list
  FROM exploded_candidates
  GROUP BY collage_id
),
collage_base AS (
  SELECT 
    c.moodboard_id AS collage_id,
    DATE(c.created_time) AS created_date,
    created_user_id AS created_user_id,
    c.reasoning AS collage_title,
    c.description AS collage_description,
    CASE 
      WHEN c.cover_image_list IS NOT NULL THEN 'with_cover_feed'
      WHEN c.intention = 'similar' AND c.cover_image_list IS NULL THEN 'similar_collage'
      ELSE 'general_collage'
    END AS category,
    c.image AS image_url,
    c.publisher,
    c.is_feed,
    c.is_onboard, 
    c.moderation_status 
  FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view` c

  UNION ALL

  SELECT 
    t.try_on_task_id AS collage_id,
    DATE(t.created_time) AS created_date,
    t.user_id AS created_user_id,
    t.detail_title AS collage_title,
    t.detail_description AS collage_description,
    'try_on' AS category,
    t.try_on_url AS image_url,
    t.publisher,
    t.is_feed,
    false as is_onboarding,
    ''as moderation_status
  FROM `srpproduct-dc37e.favie_dw.dim_try_on_task_view` t
)
SELECT
  cb.*,
  ta.tag_list
FROM collage_base cb
LEFT JOIN tags_agg ta
  ON cb.collage_id = ta.collage_id;