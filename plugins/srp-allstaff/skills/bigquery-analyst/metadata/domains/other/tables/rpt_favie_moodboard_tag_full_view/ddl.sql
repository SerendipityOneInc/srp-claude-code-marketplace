CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_moodboard_tag_full_view`
AS WITH base AS (
  SELECT
    JSON_VALUE(tag_value, '$.moodboard_id') AS moodboard_id,
    JSON_QUERY_ARRAY(tag_value, '$.moodboard_tags') AS tags
  FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
),
exploded_tags AS (
  SELECT
    moodboard_id,
    JSON_VALUE(tag, '$.Category') AS category,
    JSON_QUERY_ARRAY(tag, '$.Candidates') AS candidates
  FROM base,
  UNNEST(tags) AS tag
),
exploded_candidates AS (
  SELECT
    moodboard_id,
    category,
    JSON_VALUE(candidate, '$.Primary') AS primary,
    JSON_VALUE(candidate, '$.Secondary') AS secondary,
  FROM exploded_tags,
  UNNEST(candidates) AS candidate
)
SELECT *
FROM exploded_candidates;