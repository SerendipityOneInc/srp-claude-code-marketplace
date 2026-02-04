# rpt_normalize_uncovered_values_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_normalize_uncovered_values_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 26,110,526 行
**大小**: 2.31 GB
**创建时间**: 2026-01-27
**最后更新**: 2026-01-30

---

## 📊 表说明

Uncovered values tracking for normalized fields

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| field_name | STRING | NULLABLE | Field name: product_item, pattern, color, shape, material, style |
| original_value | STRING | NULLABLE | Original value not found in mapping table |
| product_count | INTEGER | NULLABLE | Number of products with this value |
| cumulative_product_count | INTEGER | NULLABLE | Cumulative product count ordered by product_count DESC |
| value_rank | INTEGER | NULLABLE | Rank by product_count DESC |
| first_seen_dt | DATE | NULLABLE | First date this uncovered value was seen |
| last_seen_dt | DATE | NULLABLE | Most recent date this uncovered value was seen |
| days_uncovered | INTEGER | NULLABLE | Number of days value has been uncovered: DATE_DIFF(last_seen_dt, first_seen_dt, DAY) + 1 |
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
FROM `srpproduct-dc37e.favie_rpt.rpt_normalize_uncovered_values_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:09
**扫描工具**: scan_metadata_v2.py
