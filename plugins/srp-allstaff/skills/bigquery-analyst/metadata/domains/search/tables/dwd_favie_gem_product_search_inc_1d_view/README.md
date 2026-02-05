# dwd_favie_gem_product_search_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_product_search_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: search
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-08
**最后更新**: 2025-10-08

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| trace_id | STRING | NULLABLE | - |
| raw_query | STRING | NULLABLE | - |
| qr_query | STRING | NULLABLE | - |
| qp_query | STRING | NULLABLE | - |
| query_modality | STRING | NULLABLE | - |
| product_sku_id | STRING | NULLABLE | - |
| product_site | STRING | NULLABLE | - |
| product_shop_site | STRING | NULLABLE | - |
| recall_date | DATE | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| moodboard_at | INTEGER | NULLABLE | - |
| product_updates_date | DATE | NULLABLE | - |
| product_updates_at | INTEGER | NULLABLE | - |
| product_creates_at | INTEGER | NULLABLE | - |
| gem_return_at | INTEGER | NULLABLE | - |
| moodboard_time_gap_seconds | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |
| site_domain | STRING | NULLABLE | - |
| site_top_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| site_rank | STRING | NULLABLE | - |
| site_categories | STRING | NULLABLE | - |
| site_parser_type | STRING | NULLABLE | - |
| site_country_region | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gem_product_search_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:38
**扫描工具**: scan_metadata_v2.py
