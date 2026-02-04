CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_favie_collage_count_view`
AS WITH date_range AS (
  -- 生成从最早日期到当前日期的连续日期序列
  SELECT 
    dt
  FROM UNNEST(GENERATE_DATE_ARRAY(
    (SELECT MIN(created_date) FROM `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`),
    CURRENT_DATE(),
    INTERVAL 1 DAY
  )) AS dt
),
all_categories AS (
  -- 获取所有可能的类别（仅考虑 is_feed=true 的记录）
  SELECT DISTINCT category
  FROM `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`
  WHERE is_feed = TRUE
),
date_category_combos AS (
  -- 生成所有日期和类别的组合
  SELECT 
    dt,
    ac.category
  FROM date_range
  CROSS JOIN all_categories ac
),
daily_counts AS (
  -- 按日期和类别统计每天的数量，仅统计 is_feed=true 的数据
  SELECT 
    created_date,
    category,
    COUNT(*) AS daily_count
  FROM `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view`
  WHERE is_feed = TRUE
  GROUP BY created_date, category
)
-- 组合所有数据并计算累计值
SELECT 
  dcc.dt,
  dcc.category,
  COALESCE(dc.daily_count, 0) AS daily_count,
  SUM(COALESCE(dc.daily_count, 0)) OVER (
    PARTITION BY dcc.category 
    ORDER BY dcc.dt
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_total
FROM date_category_combos dcc
LEFT JOIN daily_counts dc 
  ON dcc.dt = dc.created_date AND dcc.category = dc.category
ORDER BY dcc.category, dcc.dt;