# rpt_normalize_non_mapping_field_stats_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_normalize_non_mapping_field_stats_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 196 行
**大小**: 0.00 GB
**创建时间**: 2026-01-27
**最后更新**: 2026-01-30

---

## 📊 表说明

Distribution statistics for fields without mapping tables

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| field_name | STRING | NULLABLE | Field name without mapping table |
| data_scope | STRING | NULLABLE | Data scope: inc=incremental, full=full data |
| total_products | INTEGER | NULLABLE | Total products with non-empty field value |
| total_distinct_values | INTEGER | NULLABLE | Total distinct values |
| values_for_50pct_coverage | INTEGER | NULLABLE | Number of top values needed to cover 50% of products |
| values_for_60pct_coverage | INTEGER | NULLABLE | Number of top values needed to cover 60% of products |
| values_for_70pct_coverage | INTEGER | NULLABLE | Number of top values needed to cover 70% of products |
| values_for_80pct_coverage | INTEGER | NULLABLE | Number of top values needed to cover 80% of products |
| values_for_90pct_coverage | INTEGER | NULLABLE | Number of top values needed to cover 90% of products |
| values_for_95pct_coverage | INTEGER | NULLABLE | Number of top values needed to cover 95% of products |
| top_values_json | STRING | NULLABLE | JSON array of top 20 values with counts |
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
FROM `srpproduct-dc37e.favie_rpt.rpt_normalize_non_mapping_field_stats_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:07
**扫描工具**: scan_metadata_v2.py
