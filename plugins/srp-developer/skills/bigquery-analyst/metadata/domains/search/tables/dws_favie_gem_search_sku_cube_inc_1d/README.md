# dws_favie_gem_search_sku_cube_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_search_sku_cube_inc_1d`
**层级**: DWS (汇总层)
**业务域**: search
**表类型**: TABLE
**行数**: 43,915 行
**大小**: 0.01 GB
**创建时间**: 2025-10-08
**最后更新**: 2025-10-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_site | STRING | NULLABLE | - |
| product_shop_site | STRING | NULLABLE | - |
| site_domain | STRING | NULLABLE | - |
| site_top_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| site_categories | STRING | NULLABLE | - |
| site_parser_type | STRING | NULLABLE | - |
| site_country_region | STRING | NULLABLE | - |
| gem_sku_raw_query_cnt | INTEGER | NULLABLE | - |
| gem_sku_raw_query_uniq_cnt | INTEGER | NULLABLE | - |
| gem_sku_qp_query_cnt | INTEGER | NULLABLE | - |
| gem_sku_qp_query_uniq_cnt | INTEGER | NULLABLE | - |
| gem_search_return_sku_cnt | INTEGER | NULLABLE | - |
| gem_search_return_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_search_return_1d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_search_return_1d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_search_return_7d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_search_return_7d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_search_return_28d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_search_return_28d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_1d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_1d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_7d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_7d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_28d_update_sku_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_28d_update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| gem_moodboard_p5_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p25_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p50_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p75_sku_seconds_amt | INTEGER | NULLABLE | - |
| gem_moodboard_p95_sku_seconds_amt | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gem_search_sku_cube_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:44
**扫描工具**: scan_metadata_v2.py
