CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_item_view`
AS (
select
  intention as feed_type,
  task_id,
  moodboard_id,
  `image` as moodboard_image_url,
  intention,
  query,
  reasoning,
  cast(null as string) as title,
  `description`,
  gender,
  hashtags as tags,
  score,
  is_feed,
  moderation_status,
  JSON_EXTRACT_ARRAY(moodboards, '$.products') AS products,
  created_time,
  update_time,
  publish_time
from `srpproduct-dc37e.favie_dw.dim_moodboard_view`
where is_feed
)
union all 
select
  "try_on" as feed_type,
  try_on_task_id as task_id,
  try_on_task_id as moodboard_id,
  try_on_cover_image as moodboard_image_url,
  'try_on' as intention,
  cast(null as string) as query,
  reasoning,
  detail_title as title,
  detail_description as `description`,
  gender,
  detail_tag as tags,
  score,
  is_feed,
  moderation_status,
  safe_cast(null as array<string>) as products,
  created_time,
  created_time as update_time,
  publish_time as publish_time
from srpproduct-dc37e.favie_dw.dim_try_on_task_view
where is_feed;