WITH category_base AS (
    SELECT
      PARSE_DATE('%Y-%m-%d', dt) AS dt,
      f_sku_id,
      collage_category
    FROM `srpproduct-dc37e.favie_algo.dwd_gem_product_collage_category_full_1d`
    WHERE dt = CAST(dt_param AS STRING)
  ),

  -- ② 结构化标签表
  structured_tags AS (
    SELECT
      dt,
      f_sku_id,
      season,
      occasion,
      material,
      style,
      features,
      function
    FROM `srpproduct-dc37e.favie_algo.dwd_gem_product_structured_normalized_full_1d`
    WHERE dt = dt_param
  ),

  -- ③ 商品库表（获取site）
  product_detail AS (
    SELECT
      f_sku_id,
      site
    FROM `favie_dw.dwd_favie_product_detail_full_1d`
    WHERE dt = CAST(dt_param AS STRING)
  ),

  -- ④ JOIN 三张表
  joined AS (
    SELECT
      c.dt,
      p.site,
      c.collage_category,
      c.f_sku_id,
      s.season,
      s.occasion,
      s.material,
      s.style,
      s.features,
      s.function
    FROM category_base c
    LEFT JOIN structured_tags s
      ON c.dt = s.dt AND c.f_sku_id = s.f_sku_id
    LEFT JOIN product_detail p
      ON c.f_sku_id = p.f_sku_id
  ),

  -- ⑤ 计算每个多值字段的标签数量并分桶
  tag_counts AS (
    SELECT
      dt,
      site,
      collage_category,
      f_sku_id,

      -- season 标签数量（假设格式为逗号分隔的字符串或 JSON 数组）
      CASE
        WHEN season IS NULL OR season = '' THEN 0
        ELSE ARRAY_LENGTH(SPLIT(TRIM(season, '[]"'), ','))
      END AS season_cnt,

      -- occasion 标签数量
      CASE
        WHEN occasion IS NULL OR occasion = '' THEN 0
        ELSE ARRAY_LENGTH(SPLIT(TRIM(occasion, '[]"'), ','))
      END AS occasion_cnt,

      -- material 标签数量
      CASE
        WHEN material IS NULL OR material = '' THEN 0
        ELSE ARRAY_LENGTH(SPLIT(TRIM(material, '[]"'), ','))
      END AS material_cnt,

      -- style 标签数量
      CASE
        WHEN style IS NULL OR style = '' THEN 0
        ELSE ARRAY_LENGTH(SPLIT(TRIM(style, '[]"'), ','))
      END AS style_cnt,

      -- features 标签数量
      CASE
        WHEN features IS NULL OR features = '' THEN 0
        ELSE ARRAY_LENGTH(SPLIT(TRIM(features, '[]"'), ','))
      END AS features_cnt,

      -- function 标签数量
      CASE
        WHEN function IS NULL OR function = '' THEN 0
        ELSE ARRAY_LENGTH(SPLIT(TRIM(function, '[]"'), ','))
      END AS function_cnt

    FROM joined
  ),

  -- ⑥ 转换为桶
  tag_buckets AS (
    SELECT
      dt,
      site,
      collage_category,
      f_sku_id,

      -- season 分桶
      CASE
        WHEN season_cnt = 0 THEN '0'
        WHEN season_cnt = 1 THEN '1'
        WHEN season_cnt = 2 THEN '2'
        WHEN season_cnt = 3 THEN '3'
        WHEN season_cnt = 4 THEN '4'
        ELSE '5+'
      END AS season_bucket,

      -- occasion 分桶
      CASE
        WHEN occasion_cnt = 0 THEN '0'
        WHEN occasion_cnt = 1 THEN '1'
        WHEN occasion_cnt = 2 THEN '2'
        WHEN occasion_cnt = 3 THEN '3'
        WHEN occasion_cnt = 4 THEN '4'
        ELSE '5+'
      END AS occasion_bucket,

      -- material 分桶
      CASE
        WHEN material_cnt = 0 THEN '0'
        WHEN material_cnt = 1 THEN '1'
        WHEN material_cnt = 2 THEN '2'
        WHEN material_cnt = 3 THEN '3'
        WHEN material_cnt = 4 THEN '4'
        ELSE '5+'
      END AS material_bucket,

      -- style 分桶
      CASE
        WHEN style_cnt = 0 THEN '0'
        WHEN style_cnt = 1 THEN '1'
        WHEN style_cnt = 2 THEN '2'
        WHEN style_cnt = 3 THEN '3'
        WHEN style_cnt = 4 THEN '4'
        ELSE '5+'
      END AS style_bucket,

      -- features 分桶
      CASE
        WHEN features_cnt = 0 THEN '0'
        WHEN features_cnt = 1 THEN '1'
        WHEN features_cnt = 2 THEN '2'
        WHEN features_cnt = 3 THEN '3'
        WHEN features_cnt = 4 THEN '4'
        ELSE '5+'
      END AS features_bucket,

      -- function 分桶
      CASE
        WHEN function_cnt = 0 THEN '0'
        WHEN function_cnt = 1 THEN '1'
        WHEN function_cnt = 2 THEN '2'
        WHEN function_cnt = 3 THEN '3'
        WHEN function_cnt = 4 THEN '4'
        ELSE '5+'
      END AS function_bucket

    FROM tag_counts
  ),

  -- ⑦ UNION ALL：展开为长表
  multitag_scale AS (
    -- season
    SELECT
      dt, site, collage_category,
      'season' AS tag,
      season_bucket AS tag_cnt_bucket,
      COUNT(DISTINCT f_sku_id) AS sku_cnt
    FROM tag_buckets
    WHERE collage_category IS NOT NULL AND collage_category != 'null'
    GROUP BY dt, site, collage_category, season_bucket

    UNION ALL

    -- occasion
    SELECT
      dt, site, collage_category,
      'occasion' AS tag,
      occasion_bucket AS tag_cnt_bucket,
      COUNT(DISTINCT f_sku_id) AS sku_cnt
    FROM tag_buckets
    WHERE collage_category NOT IN ('Non-Outfit', 'null') AND collage_category IS NOT NULL
    GROUP BY dt, site, collage_category, occasion_bucket

    UNION ALL

    -- material
    SELECT
      dt, site, collage_category,
      'material' AS tag,
      material_bucket AS tag_cnt_bucket,
      COUNT(DISTINCT f_sku_id) AS sku_cnt
    FROM tag_buckets
    WHERE collage_category IS NOT NULL AND collage_category != 'null'
    GROUP BY dt, site, collage_category, material_bucket

    UNION ALL

    -- style
    SELECT
      dt, site, collage_category,
      'style' AS tag,
      style_bucket AS tag_cnt_bucket,
      COUNT(DISTINCT f_sku_id) AS sku_cnt
    FROM tag_buckets
    WHERE collage_category IS NOT NULL AND collage_category != 'null'
    GROUP BY dt, site, collage_category, style_bucket

    UNION ALL

    -- features
    SELECT
      dt, site, collage_category,
      'features' AS tag,
      features_bucket AS tag_cnt_bucket,
      COUNT(DISTINCT f_sku_id) AS sku_cnt
    FROM tag_buckets
    WHERE collage_category IS NOT NULL AND collage_category != 'null'
    GROUP BY dt, site, collage_category, features_bucket

    UNION ALL

    -- function
    SELECT
      dt, site, collage_category,
      'function' AS tag,
      function_bucket AS tag_cnt_bucket,
      COUNT(DISTINCT f_sku_id) AS sku_cnt
    FROM tag_buckets
    WHERE collage_category IN ('Top', 'Bottom', 'One-Piece', 'Outerwear', 'Shoes', 'Underwear', 'Bag', 'Watch', 'Glasses')
    GROUP BY dt, site, collage_category, function_bucket
  )

  SELECT
    dt,
    site,
    collage_category,
    tag,
    tag_cnt_bucket,
    sku_cnt
  FROM multitag_scale