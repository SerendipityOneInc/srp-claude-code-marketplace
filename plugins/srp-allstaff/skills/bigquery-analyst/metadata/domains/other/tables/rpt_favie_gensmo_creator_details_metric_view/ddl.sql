CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_creator_details_metric_view`
AS WITH valid_accounts AS (
  SELECT 
    user_id,
    user_name,
    created_at
  FROM `srpproduct-dc37e.favie_dw.dim_gensmo_user_account_view`
  WHERE is_bot_user is False
),
dim_moodboard as (
    SELECT  
        _id,
        created_user_id,
        created_time,
        update_time,
        moodboard_id,
        moodboard_index,
        task_id,
        status,
        description,
        is_feed,
        is_try_on,
        gender,
        hashtags,
        height,
        width,

        search_product_list,

        image,
        user_image_tag,

        image_url,
        image_description,
        image_height,
        image_width,

        liked_count,
        remix,
        saved_count,
        shared_count,
        score,
        intention,
        moodboards,
        query,
        reasoning,
        publisher,
        cover_image_list
    FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
),
-- 发布行为：try_on + moodboard
publishers AS (
  SELECT created_user_id AS uid FROM `srpproduct-dc37e.favie_dw.dim_try_on_task_view` WHERE is_feed = TRUE
  UNION DISTINCT
  SELECT created_user_id AS uid FROM dim_moodboard WHERE is_feed = TRUE
),

-- 活跃天数
message_metrics AS (
  SELECT 
    user_uid AS uid,
    COUNT(DISTINCT DATE(created_at)) AS active_days,
    COUNTIF(type="search_query") AS search_count,
    COUNTIF(type="tryon_query") AS tryon_count
  FROM `srpproduct-dc37e.favie_dw.dim_chat_session_messages_view`
  GROUP BY uid
),

-- 搜索次数
-- search_counts AS (
--   SELECT 
--     user_uid AS uid,
--     COUNT(1) AS search_count
--   FROM `srpproduct-dc37e.favie_dw.dim_chat_session_messages_view`
--   WHERE JSON_VALUE(data, '$.type') = 'search_query'
--   GROUP BY uid
-- ),

-- try_on 次数
-- tryon_counts AS (
--   SELECT 
--     JSON_VALUE(data, '$.user_uid') AS uid,
--     COUNT(*) AS tryon_count
--   FROM `srpproduct-dc37e.favie_mongodb_integration_airbyte.chat_session_messages`
--   WHERE JSON_VALUE(data, '$.type') = 'tryon_query'
--   GROUP BY uid
-- ),

-- 累计发布（tryon + moodboard）
publish_counts AS (
  SELECT 
    uid, 
    COUNT(1) AS publish_count
  FROM (
    SELECT 
      created_user_id AS uid 
    FROM `srpproduct-dc37e.favie_dw.dim_try_on_task_view`
    WHERE is_feed = TRUE
    UNION ALL
    SELECT 
      created_user_id AS uid 
    FROM dim_moodboard
    WHERE is_feed = TRUE
  )
  GROUP BY uid
),

-- 线上 Posts 数（is_feed=TRUE）
online_post_counts AS (
  SELECT 
    uid, 
    COUNT(1) AS online_post_count
  FROM (
    SELECT 
      created_user_id AS uid 
    FROM `srpproduct-dc37e.favie_dw.dim_try_on_task_view` 
    WHERE is_feed = TRUE
    UNION ALL
    SELECT 
      created_user_id AS uid 
    FROM dim_moodboard 
    WHERE is_feed = TRUE
  )
  GROUP BY uid
),

user_device_map AS (
  SELECT 
    user_id AS user_uid,
    last_device_id
  FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d`
),
user_features AS (
  SELECT DISTINCT
       device_id,
       last_day_feature.platform as platform,
       is_internal_user,
       user_tenure_type,
      last_30_days_feature.geo_country_name as country_name,
     FROM srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d
),
user_avatar AS (
  SELECT 
    user_id,
    _id AS avatar_id,
    model_id,
    model_url,
    created_timestamp
  FROM `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view`
  WHERE deleted_timestamp IS NULL
)

-- 🔚 汇总表
SELECT 
  v.user_id as uid,
  v.user_name as name,
  v.created_at AS register_time,
  udm.last_device_id,

  uf.platform,
  uf.country_name,
  uf.is_internal_user,
  uf.user_tenure_type,

  IFNULL(a.active_days, 0) AS active_days,
  IFNULL(a.search_count, 0) AS search_count,
  IFNULL(a.tryon_count, 0) AS tryon_count,
  IFNULL(p.publish_count, 0) AS publish_count,
  IFNULL(o.online_post_count, 0) AS online_post_count,

  ua.avatar_id,
  ua.model_id,
  ua.model_url,
  ua.created_timestamp AS avatar_created_at
FROM publishers pu
LEFT JOIN valid_accounts v ON pu.uid = v.user_id
LEFT JOIN message_metrics a ON pu.uid = a.uid
-- LEFT JOIN search_counts s ON pu.uid = s.uid
-- LEFT JOIN tryon_counts t ON pu.uid = t.uid
LEFT JOIN publish_counts p ON pu.uid = p.uid
LEFT JOIN online_post_counts o ON pu.uid = o.uid
LEFT JOIN user_device_map udm ON pu.uid = udm.user_uid
LEFT JOIN user_features uf ON udm.last_device_id = uf.device_id
LEFT JOIN user_avatar ua ON v.user_id = ua.user_id
where v.user_id is not null;