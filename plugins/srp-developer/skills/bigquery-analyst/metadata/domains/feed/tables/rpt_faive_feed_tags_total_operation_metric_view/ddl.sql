CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_faive_feed_tags_total_operation_metric_view`
AS WITH all_moodboard AS (
  SELECT collage_id
  FROM `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`
  WHERE is_feed = TRUE
),

tagged_moodboard AS (
  SELECT DISTINCT moodboard_id
  FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
),

matched AS (
  SELECT a.collage_id
  FROM all_moodboard a
  JOIN tagged_moodboard t ON a.collage_id = t.moodboard_id
)

SELECT
  (SELECT COUNT(*) FROM all_moodboard) AS total_moodboard,
  (SELECT COUNT(*) FROM tagged_moodboard) AS tagged_moodboard,
  (SELECT COUNT(*) FROM matched) AS matched_moodboard,
  SAFE_DIVIDE((SELECT COUNT(*) FROM matched), (SELECT COUNT(*) FROM all_moodboard)) AS coverage_rate;