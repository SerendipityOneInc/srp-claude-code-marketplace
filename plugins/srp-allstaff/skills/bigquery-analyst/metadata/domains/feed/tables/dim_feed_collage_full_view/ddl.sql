CREATE VIEW `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`
AS SELECT 
  c.moodboard_id AS collage_id,
  DATE(c.created_time) AS created_date,
  created_user_id AS created_user_id,
  c.reasoning AS collage_title,
  c.description AS collage_description,
  CASE 
    WHEN c.cover_image_list is not null then 'with_cover_feed'
    WHEN c.intention = 'similar' and c.cover_image_list is null THEN 'similar_collage'
    ELSE 'general_collage'
  END AS category,
  c.image AS image_url,
  c.publisher,
  c.is_feed
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
  t.is_feed
FROM `srpproduct-dc37e.favie_dw.dim_try_on_task_view` t;