# dws_gem_product_category_rule_health_inc_1d_function

**函数类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**完整路径**: `srpproduct-dc37e.favie_dw.dws_gem_product_category_rule_health_inc_1d_function`

---

## 📊 函数说明

该函数用于生成对应表的数据

---

## 📋 参数定义

| 参数名 | 类型 | 说明 |
|--------|------|------|
| dt_param | DATE | |


---

## 💡 函数逻辑

该函数实现了数据的提取、转换和聚合逻辑。

**主要步骤**:

**数据来源**:
- `srpproduct-dc37e.favie_algo.dwd_gem_product_collage_category_full_1d`
- `srpproduct-dc37e.favie_algo.dwd_gem_product_structured_normalized_full_1d`
- `favie_dw.dwd_favie_product_detail_full_1d`

---

## 🔍 使用示例

```sql
-- 调用函数生成数据
SELECT *
FROM `srpproduct-dc37e.favie_dw.dws_gem_product_category_rule_health_inc_1d_function`(CURRENT_DATE())
LIMIT 100;
```

---

## 📝 SQL 定义

<details>
<summary>点击查看完整 SQL 定义</summary>

```sql
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
```

</details>

---

**创建时间**: 2026-01-25T09:36:36.190000+00:00
**最后修改**: 2026-01-25T09:36:36.190000+00:00
