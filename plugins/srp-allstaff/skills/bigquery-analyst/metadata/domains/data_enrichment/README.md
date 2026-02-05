# data_enrichment - 数据增强域

## 📊 业务概览

数据增强域包含产品标签、分类规则健康度等数据质量和增强相关的表。

---

## 📋 核心表

- `dws_gem_product_category_rule_health_inc_1d` - 待补充描述
- `dws_gem_product_tag_coverage_multitag_scale_inc_1d` - 待补充描述
- `dws_gem_product_tag_value_dist_inc_1d` - 待补充描述

---

## 🔍 常见查询场景

### 场景 1: 查询产品标签覆盖情况

```sql
SELECT *
FROM `srpproduct-dc37e.favie_dw.dws_gem_product_tag_coverage_multitag_scale_inc_1d`
WHERE dt = CURRENT_DATE() - 1
LIMIT 100;
```

---

## ⚠️ 注意事项

- 所有表均为 DWS 层汇总表
- 数据更新频率: 每日
- 必须包含 dt 分区过滤

---

**最后更新**: 2026-02-03
