# rpt_product_dw_search_metric_view

**表全名**: `srpproduct-dc37e.favie_dw.rpt_product_dw_search_metric_view`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-27
**最后更新**: 2025-02-27

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site_domain | STRING | NULLABLE | - |
| site_top_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| site_categories | STRING | NULLABLE | - |
| site_parser_type | STRING | NULLABLE | - |
| site_country_region | STRING | NULLABLE | - |
| valid_sku_uniq_cnt | INTEGER | NULLABLE | - |
| valid_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d7_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d7_inc_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d7_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d7_update_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d28_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d28_inc_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d28_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d28_update_spu_uniq_cnt | INTEGER | NULLABLE | - |
| gem_ha3_recall_sku_cnt | INTEGER | NULLABLE | - |
| gem_ha3_recall_sku_uniq_cnt | INTEGER | NULLABLE | - |
| valid_gem_ha3_recall_sku_cnt | INTEGER | NULLABLE | - |
| valid_gem_ha3_recall_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_search_retrieval_sku_cnt | INTEGER | NULLABLE | - |
| gem_search_retrieval_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_ha3_recall_utilization_rate | FLOAT | NULLABLE | - |
| valid_gem_ha3_recall_utilization_rate | FLOAT | NULLABLE | - |
| d7_valid_gem_ha3_recall_utilization_rate | FLOAT | NULLABLE | - |
| d28_valid_gem_ha3_recall_utilization_rate | FLOAT | NULLABLE | - |
| total_sku_utilization_rate | FLOAT | NULLABLE | - |
| total_sku_retrieval_utilization_rate | FLOAT | NULLABLE | - |
| d7_sku_utilization_rate | FLOAT | NULLABLE | - |
| d28_sku_utilization_rate | FLOAT | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.rpt_product_dw_search_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:19:20
**扫描工具**: scan_metadata_v2.py
