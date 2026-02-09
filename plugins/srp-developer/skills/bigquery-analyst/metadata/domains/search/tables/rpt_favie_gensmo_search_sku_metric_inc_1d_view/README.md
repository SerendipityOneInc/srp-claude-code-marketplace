# rpt_favie_gensmo_search_sku_metric_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_sku_metric_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-15
**最后更新**: 2025-12-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| product_site | STRING | NULLABLE | - |
| product_shop_site | STRING | NULLABLE | - |
| site_domain | STRING | NULLABLE | - |
| site_top_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| site_rank | STRING | NULLABLE | - |
| site_estimated_sku_num | INTEGER | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| site_categories | STRING | NULLABLE | - |
| site_parser_type | STRING | NULLABLE | - |
| site_country_region | STRING | NULLABLE | - |
| gem_sku_raw_query_uniq_cnt | INTEGER | NULLABLE | - |
| gem_sku_qp_query_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_1d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_1d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_3d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_3d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_7d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_7d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_28d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_28d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_p5_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p25_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p50_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p75_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p95_sku_seconds_amt | INTEGER | NULLABLE | - |
| inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d7_update_and_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d28_update_and_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| sku_uniq_cnt | INTEGER | NULLABLE | - |
| d7_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d28_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d3_update_and_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d3_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| including_preferred_image_sku_rate | FLOAT | NULLABLE | - |
| including_preferred_image_product_uniq_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.gensmo_rpt.rpt_gem_all_product_site_metric_full_1d` (rpt_gem_all_product_site_metric_full_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_sku_metric_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:27
**扫描工具**: scan_metadata_v2.py
