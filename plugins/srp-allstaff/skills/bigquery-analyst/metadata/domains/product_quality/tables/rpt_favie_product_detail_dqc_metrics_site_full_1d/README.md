# rpt_favie_product_detail_dqc_metrics_site_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_dqc_metrics_site_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-02-24
**最后更新**: 2025-02-24

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| shop_site | STRING | NULLABLE | - |
| title_length_p25 | FLOAT | NULLABLE | - |
| title_length_p50 | FLOAT | NULLABLE | - |
| title_length_p75 | FLOAT | NULLABLE | - |
| keywords_length_p25 | FLOAT | NULLABLE | - |
| keywords_length_p50 | FLOAT | NULLABLE | - |
| keywords_length_p75 | FLOAT | NULLABLE | - |
| description_length_p25 | FLOAT | NULLABLE | - |
| description_length_p50 | FLOAT | NULLABLE | - |
| description_length_p75 | FLOAT | NULLABLE | - |
| feature_bullets_length_p25 | FLOAT | NULLABLE | - |
| feature_bullets_length_p50 | FLOAT | NULLABLE | - |
| feature_bullets_length_p75 | FLOAT | NULLABLE | - |
| site_total | INTEGER | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_dqc_metrics_site_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:03
**扫描工具**: scan_metadata_v2.py
