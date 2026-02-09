# dws_gem_product_category_rule_health_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_product_category_rule_health_inc_1d`
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
| sku_cnt | INTEGER | NULLABLE | 属于当前人群标签的 SKU 去重数量 |
| topwear_attr_present_sku_cnt | INTEGER | NULLABLE | 当前人群中，至少填写了领口、袖长或袖型任意一个上衣属性的 SKU 去重数量（不判断该品类是否适用） |
| topwear_attr_invalid_sku_cnt | INTEGER | NULLABLE | 当前人群中，填写了上衣属性（领口/袖长/袖型），但所属品类不属于上衣相关品类的 SKU 去重数量（异常数据） |
| apparel_structure_present_sku_cnt | INTEGER | NULLABLE | 当前人群中，至少填写了长度、版型、廓形或闭合方式任意一个服装结构属性的 SKU 去重数量（不判断该品类是否适用） |
| apparel_structure_invalid_sku_cnt | INTEGER | NULLABLE | 当前人群中，填写了服装结构属性（长度/版型/廓形/闭合方式），但所属品类不属于服装结构适用品类的 SKU 去重数量（异常数据） |


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

该表由 **TABLE_VALUED_FUNCTION** 生成，函数名: `dws_gem_product_category_rule_health_inc_1d_function`

**数据来源**:
- `srpproduct-dc37e.favie_algo.dwd_gem_product_collage_category_full_1d`
- `srpproduct-dc37e.favie_algo.dwd_gem_product_structured_normalized_full_1d`
- `favie_dw.dwd_favie_product_detail_full_1d`

**查看完整生成逻辑**:
参考 `metadata/domains/data_enrichment/functions/dws_gem_product_category_rule_health_inc_1d_function/README.md`

## 🔍 查询示例

```sql
-- 示例 1: 查询最近 7 天数据
SELECT *
FROM `srpproduct-dc37e.favie_dw.dws_gem_product_category_rule_health_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
LIMIT 100;
```

---

## ⚠️ 注意事项

- ✅ 必须包含 dt 分区过滤
- ✅ 数据更新频率: 每日
- ✅ 时区: UTC

---

**最后更新**: 1770034345248
