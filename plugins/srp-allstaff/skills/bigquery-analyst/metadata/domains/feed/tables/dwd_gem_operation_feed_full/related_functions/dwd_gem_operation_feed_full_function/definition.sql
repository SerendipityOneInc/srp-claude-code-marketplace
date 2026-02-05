WITH moodboard_all AS (
    SELECT
      moodboard_id as collage_id,
      DATE(created_time) AS created_date,
      created_time AS created_at,
      created_user_id,
      reasoning as collage_title,
      description        AS collage_description,
      CASE 
        WHEN cover_image_list IS NOT NULL THEN 'with_cover_feed'
        WHEN intention = 'similar' 
             AND cover_image_list IS NULL THEN 'similar_collage'
        ELSE 'general_collage'
      END AS category,
      image              AS image_url,
      publisher          AS publisher,
      is_feed,
      is_onboard,
      moderation_status,
      liked_count,
      saved_count,
      shared_count,
      remix,

      -- ✅ hashtags 标准化解析为 ARRAY<STRING>
      json_extract_array(hashtags) as hashtags,

      task_id,  
      update_time AS updated_at
    FROM `favie_dw.dim_moodboard_view`
    WHERE is_feed = TRUE
),

collage_all AS (
    -- moodboard 全量
    SELECT 
      collage_id,
      created_date,
      created_at,
      created_user_id,
      collage_title,
      collage_description,
      category,
      image_url,
      publisher,
      is_feed,
      is_onboard,
      moderation_status,
      liked_count,
      saved_count,
      shared_count,
      remix,
      hashtags,
      task_id
    FROM moodboard_all

    UNION ALL

    -- try_on 保留全量
    SELECT 
      try_on_task_id     AS collage_id,
      DATE(created_time) AS created_date,
      created_time       AS created_at,
      user_id            AS created_user_id,
      detail_title       AS collage_title,
      detail_description AS collage_description,
      'try_on'                                         AS category,
      try_on_url         AS image_url,
      publisher          AS publisher,
      is_feed AS is_feed,
      FALSE                                            AS is_onboard,
      moderation_status  AS moderation_status,
      liked_count AS liked_count,
      saved_count AS saved_count,
      shared_count AS shared_count,
      remix AS remix,

      -- ✅ try_on hashtags 也标准化解析为 ARRAY<STRING>
      null as hashtags,

      '' AS task_id
    FROM `favie_dw.dim_try_on_task_view`
    WHERE is_feed = TRUE
),

original_templates AS (
    SELECT DISTINCT task_id
    FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
    WHERE is_feed = FALSE
      AND is_onboard = TRUE
      AND task_id IS NOT NULL
),
tags_latest AS (
    SELECT
      moodboard_id,
      SAFE_CAST(dt AS DATE) AS tag_dt,
      style_one_tags,
      style_two_tags,
      occasion_one_tags,
      occasion_two_tags,
      color_tags,
      weather_tags,
      temperature_tags,
      gender_tags,
      age_tags,
      body_size_tags,
      body_shape_tags,
      height_tags
    FROM (
      SELECT
        s.moodboard_id,
        s.dt,
        s.style_one_tags,
        s.style_two_tags,
        s.occasion_one_tags,
        s.occasion_two_tags,
        s.color_tags,
        s.weather_tags,
        s.temperature_tags,
        s.gender_tags,
        s.age_tags,
        s.body_size_tags,
        s.body_shape_tags,
        s.height_tags,
        ROW_NUMBER() OVER (
          PARTITION BY s.moodboard_id
          ORDER BY SAFE_CAST(s.dt AS DATE) DESC
        ) AS rn
      FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_full_1d_view` s
    )
    WHERE rn = 1
),
collage_with_dupe_flag AS (
    SELECT
      ca.collage_id,
      ca.created_date,
      ca.created_at,
      ca.created_user_id,
      ca.collage_title,
      ca.collage_description,
      ca.category,
      ca.image_url,
      ca.publisher,
      ca.is_feed,
      ca.is_onboard,
      ca.moderation_status,
      ca.liked_count,
      ca.saved_count,
      ca.shared_count,
      ca.remix,
      ca.hashtags,
      ca.task_id,
      CASE 
        WHEN ot.task_id IS NOT NULL THEN TRUE
        ELSE FALSE
      END AS is_duplicate_image
    FROM collage_all ca
    LEFT JOIN original_templates ot
      ON ca.task_id = ot.task_id
)

-- 其他逻辑（original_templates / collage_with_dupe_flag / tags_latest / final SELECT）保持不变
SELECT
  cb.collage_id,
  cb.created_date,
  cb.created_at,
  cb.created_user_id,
  cb.collage_title,
  cb.collage_description,
  cb.category,
  cb.image_url,
  cb.publisher,
  cb.is_feed,
  cb.is_onboard,
  cb.moderation_status,
  cb.liked_count,
  cb.shared_count,
  cb.saved_count,
  cb.remix,
  cb.hashtags,

  tl.tag_dt,
  tl.style_one_tags,
  tl.style_two_tags,
  tl.occasion_one_tags,
  tl.occasion_two_tags,
  tl.color_tags,
  tl.weather_tags,
  tl.temperature_tags,
  tl.gender_tags,
  tl.age_tags,
  tl.body_size_tags,
  tl.body_shape_tags,
  tl.height_tags,

  (LENGTH(IFNULL(cb.created_user_id, '')) > 5) AS is_UGC,
  cb.is_duplicate_image,

  CASE 
    WHEN cb.moderation_status = 'rejected' AND cb.is_duplicate_image = TRUE 
      THEN '用户被动发帖'
    WHEN cb.moderation_status IN ('approved','soft_pass')  
      OR (cb.moderation_status = 'rejected' AND cb.is_duplicate_image = FALSE)
      THEN '用户主动发帖'
    ELSE '内部生产'
  END AS production_type

FROM collage_with_dupe_flag cb
LEFT JOIN tags_latest tl
  ON cb.collage_id = tl.moodboard_id