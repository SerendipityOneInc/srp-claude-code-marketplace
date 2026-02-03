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
      neckline,
      sleeve_length,
      sleeve_style,
      length,
      fit_type,
      shape,
      closure
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
      s.neckline,
      s.sleeve_length,
      s.sleeve_style,
      s.length,
      s.fit_type,
      s.shape,
      s.closure
    FROM category_base c
    LEFT JOIN structured_tags s
      ON c.dt = s.dt AND c.f_sku_id = s.f_sku_id
    LEFT JOIN product_detail p
      ON c.f_sku_id = p.f_sku_id
  )

  -- ⑤ 最终聚合
  SELECT
    dt,
    site,
    collage_category,

    -- 基础规模
    COUNT(DISTINCT f_sku_id) AS total_sku_cnt,

    -- 上衣属性健康度
    COUNT(DISTINCT IF(
      neckline IS NOT NULL OR sleeve_length IS NOT NULL OR sleeve_style IS NOT NULL,
      f_sku_id, NULL
    )) AS topwear_attr_present_sku_cnt,

    COUNT(DISTINCT IF(
      (neckline IS NOT NULL OR sleeve_length IS NOT NULL OR sleeve_style IS NOT NULL)
      AND collage_category NOT IN ('Top', 'One-Piece', 'Outerwear'),
      f_sku_id, NULL
    )) AS topwear_attr_invalid_sku_cnt,

    -- 服装结构属性健康度
    COUNT(DISTINCT IF(
      length IS NOT NULL OR fit_type IS NOT NULL OR shape IS NOT NULL OR closure IS NOT NULL,
      f_sku_id, NULL
    )) AS apparel_structure_present_sku_cnt,

    COUNT(DISTINCT IF(
      (length IS NOT NULL OR fit_type IS NOT NULL OR shape IS NOT NULL OR closure IS NOT NULL)
      AND collage_category NOT IN ('Top', 'Bottom', 'One-Piece', 'Outerwear'),
      f_sku_id, NULL
    )) AS apparel_structure_invalid_sku_cnt

  FROM joined
  GROUP BY dt, site, collage_category