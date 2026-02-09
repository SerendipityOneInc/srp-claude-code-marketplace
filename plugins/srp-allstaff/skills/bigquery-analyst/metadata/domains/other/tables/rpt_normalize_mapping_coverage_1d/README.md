# rpt_normalize_mapping_coverage_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_normalize_mapping_coverage_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 84 行
**大小**: 0.00 GB
**创建时间**: 2026-01-27
**最后更新**: 2026-01-30

---

## 📊 表说明

Mapping coverage statistics for normalized fields

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| field_name | STRING | NULLABLE | Field name: product_item, pattern, color, shape, material, style |
| data_scope | STRING | NULLABLE | Data scope: inc=incremental, full=full data |
| total_products | INTEGER | NULLABLE | Total products with non-empty field value |
| covered_products | INTEGER | NULLABLE | Products with field value found in mapping table |
| uncovered_products | INTEGER | NULLABLE | Products with field value NOT in mapping table |
| product_coverage_rate | FLOAT | NULLABLE | Product coverage rate: covered_products / total_products * 100 |
| total_distinct_values | INTEGER | NULLABLE | Total distinct original values |
| covered_distinct_values | INTEGER | NULLABLE | Distinct values found in mapping table |
| uncovered_distinct_values | INTEGER | NULLABLE | Distinct values NOT in mapping table |
| value_coverage_rate | FLOAT | NULLABLE | Value coverage rate: covered_distinct_values / total_distinct_values * 100 |
| model_version | STRING | NULLABLE | Model version |
| created_at | TIMESTAMP | NULLABLE | Record creation timestamp |
| dt | DATE | NULLABLE | Partition date |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_normalize_mapping_coverage_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:05
**扫描工具**: scan_metadata_v2.py
