# dws_gem_product_tag_coverage_multitag_scale_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_product_tag_coverage_multitag_scale_inc_1d`
**层级**: DWS
**业务域**: data_enrichment

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 事件发生日期 |
| site | STRING | NULLABLE | 商品来源网站（如 us.princesspolly.com） |
| collage_category | STRING | NULLABLE | 商品类别（Top/Bottom/One-Piece等13类+null） |
| demographic | STRING | NULLABLE | 人群标签（枚举：'Men', 'Women', 'Boys', 'Girls', 'Baby Boys', 'Baby Girls', 'Unisex', 'Unknown'） |
| tag | STRING | NULLABLE | 标签名称（枚举：enhanced_title, demographic, season, length, closure, fit_type, function, neckline, sleeve_length, sleeve_style, features, occasion, color, color_family, color_tone, color_saturation, shape, pattern, material, style, collage_category） |
| applicable_sku_cnt | INTEGER | NULLABLE | 在当前维度（包括人群）下，理论上'适用该标签'的 SKU 去重数量（覆盖率分母） |
| has_value_sku_cnt | INTEGER | NULLABLE | 在当前维度（包括人群）下，实际获得该标签有效取值的 SKU 去重数量（覆盖率分子） |
| total_value_cnt | INTEGER | NULLABLE | 在当前粒度下，所有'有值 SKU'的该多值标签取值总数。计算公式：SUM(IF(ARRAY_LENGTH(field_array) > 0, ARRAY_LENGTH(field_array), 0)) |
| explode_row_cnt | INTEGER | NULLABLE | 把多值字段 UNNEST 展开后得到的总行数，用于观察 explode 后的数据规模。计算公式：COUNT(*) FROM UNNEST(field_array) |


---

## 🔗 数据血缘

**上游依赖**:
- `srpproduct-dc37e.favie_algo.dwd_gem_product_collage_category_full_1d`
- `srpproduct-dc37e.favie_algo.dwd_gem_product_structured_normalized_full_1d`
- `favie_dw.dwd_favie_product_detail_full_1d`

**下游使用**:
- 待补充

---


---

## 💡 数据生成逻辑

该表由 **TABLE_VALUED_FUNCTION** 生成，函数名: `dws_gem_product_multitag_scale_inc_1d_function`

**数据来源**:
- `srpproduct-dc37e.favie_algo.dwd_gem_product_collage_category_full_1d`
- `srpproduct-dc37e.favie_algo.dwd_gem_product_structured_normalized_full_1d`
- `favie_dw.dwd_favie_product_detail_full_1d`

**查看完整生成逻辑**:
参考 `metadata/domains/data_enrichment/functions/dws_gem_product_multitag_scale_inc_1d_function/README.md`

## 🔍 查询示例

```sql
-- 示例 1: 查询最近 7 天数据
SELECT *
FROM `srpproduct-dc37e.favie_dw.dws_gem_product_tag_coverage_multitag_scale_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
LIMIT 100;
```

---

## ⚠️ 注意事项

- ✅ 必须包含 dt 分区过滤
- ✅ 数据更新频率: 每日
- ✅ 时区: UTC

---

**最后更新**: 1770034314979
