-- 该表由对应的 TABLE_VALUED_FUNCTION 生成
-- 函数名: data_enrichment_function

-- 数据生成逻辑:
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
      occasion,
      material
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
      s.occasion,
      s.material
    FROM category_base c
    LEFT JOIN structured_tags s
      ON c.dt = s.dt AND c.f_sku_id = s.f_sku_id
    LEFT JOIN product_detail p
      ON c.f_sku_id = p.f_sku_id
  ),

  -- ⑤ 展开 occasion 标签值
  occasion_values AS (
    SELECT
      dt,
      site,
      collage_category,
      f_sku_id,
      'occasion' AS tag,
      TRIM(occasion_value) AS tag_value
    FROM joined,
    UNNEST(SPLIT(TRIM(occasion, '[]"'), ',')) AS occasion_value
    WHERE occasion IS NOT NULL
      AND occasion != ''
      AND collage_category NOT IN ('Non-Outfit', 'null')
      AND collage_category IS NOT NULL
      AND TRIM(occasion_value) != ''
  ),

  -- ⑥ 展开 material 标签值
  material_values AS (
    SELECT
      dt,
      site,
      collage_category,
      f_sku_id,
      'material' AS tag,
      TRIM(material_value) AS tag_value
    FROM joined,
    UNNEST(SPLIT(TRIM(material, '[]"'), ',')) AS material_value
    WHERE material IS NOT NULL
      AND material != ''
      AND collage_category IS NOT NULL
      AND collage_category != 'null'
      AND TRIM(material_value) != ''
  ),

  -- ⑦ UNION ALL 合并两个标签
  all_tag_values AS (
    SELECT * FROM occasion_values
    UNION ALL
    SELECT * FROM material_values
  )

  -- ⑧ 最终聚合
  SELECT
    dt,
    site,
    collage_category,
    tag,
    tag_value,
    COUNT(DISTINCT f_sku_id) AS sku_cnt
  FROM all_tag_values
  GROUP BY dt, site, collage_category, tag, tag_value
