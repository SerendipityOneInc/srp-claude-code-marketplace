CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_content_details_metric_view`
AS WITH valid_accounts AS (
  SELECT 
    user_id as uid,
    user_name as name,
    created_at
  FROM `srpproduct-dc37e.favie_dw.dim_gensmo_user_account_view`
  WHERE is_bot_user is False
),
dim_moodboard AS (
  SELECT  
    _id,
    created_user_id,
    created_time,
    moodboard_id,
    description,
    is_feed,
    image as cover_image,
    liked_count,
    remix,
    saved_count,
    shared_count
  FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
),
tryon_task AS (
  SELECT  
    _id,
    created_time,
    detail_title,
    detail_description,
    created_user_id,
    try_on_task_id,
    moodboard_id,
    is_feed,
    try_on_url as cover_image,
    liked_count,
    remix,
    saved_count,
    shared_count
  FROM `srpproduct-dc37e.favie_dw.dim_try_on_task_view`
),
comments AS (
  SELECT
    content AS comment_content,
    created_at AS comment_created_at,
    user_id AS comment_user_id,
    post_id AS post_id,
    parent_comment_id AS parent_comment_id
  FROM `srpproduct-dc37e.favie_dw.dim_gem_comment_view`
),
combined_data AS (
  -- tryon_task + 评论
  SELECT 
    t.created_time,
    t.detail_title AS title,
    t.detail_description AS description,
    t.created_user_id,
    a.name,
    t.liked_count,
    t.remix,
    t.saved_count,
    t.shared_count,
    'tryon' AS source,
    CONCAT('https://gensmo.com/share/', t.moodboard_id) AS moodboard_url,
    t.cover_image AS cover_image,
    c.comment_content,
    c.comment_created_at,
    c.comment_user_id,
    c.parent_comment_id,
    case when c.comment_user_id in (SELECT uid FROM valid_accounts) and c.comment_content is not null then false
    when c.comment_content is null then null
    else true
    end as is_bot
  FROM tryon_task t
  LEFT JOIN valid_accounts a
    ON t.created_user_id = a.uid
  LEFT JOIN comments c
    ON t.try_on_task_id = c.post_id
  WHERE t.created_user_id IN (
    SELECT uid FROM valid_accounts
  )
  AND t.is_feed = TRUE

  UNION ALL

  -- moodboard + 评论
  SELECT 
    t.created_time,
    NULL AS title,
    t.description,
    t.created_user_id,
    a.name,
    t.liked_count,
    t.remix,
    t.saved_count,
    t.shared_count,
    'collage' AS source,
    CONCAT('https://gensmo.com/share/', t.moodboard_id) AS moodboard_url,
    t.cover_image AS cover_image,
    c.comment_content,
    c.comment_created_at,
    c.comment_user_id,
    c.parent_comment_id,
    case when c.comment_user_id in (SELECT uid FROM valid_accounts) and c.comment_content is not null then false
    when c.comment_content is null then null
    else true
    end as is_bot
  FROM dim_moodboard t
  LEFT JOIN valid_accounts a
    ON t.created_user_id = a.uid
  LEFT JOIN comments c
    ON t.moodboard_id = c.post_id
  WHERE t.created_user_id IN (
    SELECT uid FROM valid_accounts
  )
  AND t.is_feed = TRUE
)

-- 最终输出
SELECT *
FROM combined_data;