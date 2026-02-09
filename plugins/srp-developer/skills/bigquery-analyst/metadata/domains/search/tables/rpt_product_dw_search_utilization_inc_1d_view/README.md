# rpt_product_dw_search_utilization_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_product_dw_search_utilization_inc_1d_view`
**层级**: RPT (报表层)
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
| site_domain | STRING | NULLABLE | - |
| site_top_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| site_rank | STRING | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| site_categories | STRING | NULLABLE | - |
| site_parser_type | STRING | NULLABLE | - |
| site_country_region | STRING | NULLABLE | - |
| data_name | STRING | NULLABLE | - |
| data_level_name | STRING | NULLABLE | - |
| data_level_seq | INTEGER | NULLABLE | - |
| data_value | INTEGER | NULLABLE | - |
| is_max_dt | BOOLEAN | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_product_dw_search_utilization_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:16
**扫描工具**: scan_metadata_v2.py
