# dwd_favie_gem_search_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_search_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: search
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-03-07
**最后更新**: 2025-03-07

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| trace_id | STRING | NULLABLE | - |
| product_sku_id | STRING | NULLABLE | - |
| product_site | STRING | NULLABLE | - |
| product_brand | STRING | NULLABLE | - |
| product_price_currency | STRING | NULLABLE | - |
| product_price_value | INTEGER | NULLABLE | - |
| product_price_raw | STRING | NULLABLE | - |
| product_link | STRING | NULLABLE | - |
| product_query | STRING | NULLABLE | - |
| product_image_link | STRING | NULLABLE | - |
| product_rating | FLOAT | NULLABLE | - |
| product_ratings_total | FLOAT | NULLABLE | - |
| product_cate_tag | STRING | NULLABLE | - |
| product_title | STRING | NULLABLE | - |
| product_updates_at | STRING | NULLABLE | - |
| product_creates_at | STRING | NULLABLE | - |
| search_engine | STRING | NULLABLE | - |
| log_timestamp | TIMESTAMP | NULLABLE | - |
| receive_timestamp | TIMESTAMP | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.logging_gem_search_product_list.export_errors_` (export_errors_)
- `srpproduct-dc37e.logging_gem_search_product_list.stderr_` (stderr_)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gem_search_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:40
**扫描工具**: scan_metadata_v2.py
