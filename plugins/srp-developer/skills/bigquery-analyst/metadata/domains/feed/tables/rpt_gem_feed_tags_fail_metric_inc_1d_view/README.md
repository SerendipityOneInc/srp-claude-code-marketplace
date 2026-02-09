# rpt_gem_feed_tags_fail_metric_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_feed_tags_fail_metric_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-12
**最后更新**: 2025-06-12

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| style_1_fail | INTEGER | NULLABLE | - |
| style_2_fail | INTEGER | NULLABLE | - |
| occasion_1_fail | INTEGER | NULLABLE | - |
| occasion_2_fail | INTEGER | NULLABLE | - |
| color_fail | INTEGER | NULLABLE | - |
| temperature_fail | INTEGER | NULLABLE | - |
| weather_fail | INTEGER | NULLABLE | - |
| gender_fail | INTEGER | NULLABLE | - |
| age_fail | INTEGER | NULLABLE | - |
| body_size_fail | INTEGER | NULLABLE | - |
| body_shape_fail | INTEGER | NULLABLE | - |
| height_fail | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gem_feed_tags_fail_metric_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:48
**扫描工具**: scan_metadata_v2.py
