# dws_gem_product_tag_value_dist_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_product_tag_value_dist_inc_1d`
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
| tag | STRING | NULLABLE | 标签类型（枚举：occasion, material） |
| tag_value | STRING | NULLABLE | 标签的具体取值（如 'Casual', 'Cotton' 等，未聚合的原始值） |
| sku_cnt | INTEGER | NULLABLE | 在当前维度（包括人群）下，具有相应标签值的 SKU 去重数量 |
| sku_tag_value_rank | INTEGER | NULLABLE | 在同一 dt×site×collage_category×tag 内，按 sku_cnt 从高到低的排名（ROW_NUMBER） |
| applicable_sku_cnt | INTEGER | NULLABLE | 当前 dt×site×collage_category×tag 下适用的 SKU 总数（分母）。occasion: collage_category NOT IN ('Non-Outfit', NULL); material: 全量 SKU |
| distinct_value_cnt | INTEGER | NULLABLE | 当天该 dt×site×collage_category×tag 下，出现过的不同取值数量（值域规模） |


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

该表由 **TABLE_VALUED_FUNCTION** 生成，函数名: `dws_gem_product_tag_value_dist_inc_1d_function`

**数据来源**:
- `srpproduct-dc37e.favie_algo.dwd_gem_product_collage_category_full_1d`
- `srpproduct-dc37e.favie_algo.dwd_gem_product_structured_normalized_full_1d`
- `favie_dw.dwd_favie_product_detail_full_1d`

**查看完整生成逻辑**:
参考 `metadata/domains/data_enrichment/functions/dws_gem_product_tag_value_dist_inc_1d_function/README.md`

## 🔍 查询示例

```sql
-- 示例 1: 查询最近 7 天数据
SELECT *
FROM `srpproduct-dc37e.favie_dw.dws_gem_product_tag_value_dist_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
LIMIT 100;
```

---

## ⚠️ 注意事项

- ✅ 必须包含 dt 分区过滤
- ✅ 数据更新频率: 每日
- ✅ 时区: UTC

---

**最后更新**: 1770034269132
