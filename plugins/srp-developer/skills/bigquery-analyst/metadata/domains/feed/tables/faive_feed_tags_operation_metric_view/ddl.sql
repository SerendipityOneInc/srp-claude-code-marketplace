CREATE VIEW `srpproduct-dc37e.favie_rpt.faive_feed_tags_operation_metric_view`
AS WITH calendar AS (
  SELECT DATE_ADD(DATE '2025-06-14', INTERVAL x DAY) AS dt
  FROM UNNEST(GENERATE_ARRAY(0, DATE_DIFF(CURRENT_DATE(), DATE '2025-06-14', DAY))) AS x
),

all_production AS (
  SELECT collage_id, date(created_date) as created_date
  FROM `srpproduct-dc37e.favie_rpt.rpt_favie_collage_info_view`
  WHERE is_feed = TRUE
),

-- 1. 标签记录去重（保留每个 ID 的最新记录）
tagged AS (
  SELECT * EXCEPT(rn)
  FROM (
    SELECT *,
      ROW_NUMBER() OVER (PARTITION BY moodboard_id ORDER BY dt DESC, process_time DESC) AS rn
    FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_moodboard_tag_inc_1hour_view`
  )
  WHERE rn = 1
),

-- 2. 是否打全标签判断
tagged_with_flags AS (
  SELECT
    moodboard_id,
    date(dt) as dt,
    style, occasion, color, weather, temperature, age, gender, body_size, body_shape, height,
    IF(
      style IS NOT NULL AND occasion IS NOT NULL AND color IS NOT NULL AND weather IS NOT NULL AND
      temperature IS NOT NULL AND age IS NOT NULL AND gender IS NOT NULL AND body_size IS NOT NULL AND
      body_shape IS NOT NULL AND height IS NOT NULL,
      TRUE,
      FALSE
    ) AS is_complete
  FROM tagged
),

-- 3. 每天在标签表中打了标签的 moodboard 数量（不限制是否当天生产）
tagged_today_count AS (
  SELECT
    date(dt) as dt,
    COUNT(DISTINCT moodboard_id) AS total_tagged_today
  FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_moodboard_tag_inc_1hour_view`
  GROUP BY dt
),

-- 4. 每日基于生产数据的指标
daily_stats AS (
  SELECT
    c.dt,
    COUNT(DISTINCT p.collage_id) AS total_created,

    -- 今日生产但未打标签
    COUNT(DISTINCT p.collage_id) - COUNT(DISTINCT IF(t.dt = c.dt AND p.collage_id = t.moodboard_id, p.collage_id, NULL)) AS not_tagged_today,

    -- 今日生产但未打全（包括没打或打不完整）
    COUNT(DISTINCT IF(
      t.dt = c.dt AND p.collage_id = t.moodboard_id AND (t.is_complete = FALSE OR t.moodboard_id IS NULL),
      p.collage_id, NULL
    )) AS incomplete_today
  FROM calendar c
  LEFT JOIN all_production p ON p.created_date = c.dt
  LEFT JOIN tagged_with_flags t ON p.collage_id = t.moodboard_id
  GROUP BY c.dt
)

-- 5. 最终输出
SELECT
  d.dt,
  d.total_created,
  COALESCE(t.total_tagged_today, 0) AS total_tagged_today,
  d.not_tagged_today,
  d.incomplete_today
FROM daily_stats d
LEFT JOIN tagged_today_count t ON d.dt = t.dt
ORDER BY d.dt;