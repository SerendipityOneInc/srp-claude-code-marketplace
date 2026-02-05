# rpt_favie_collage_count_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_collage_count_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-10
**最后更新**: 2025-07-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| category | STRING | NULLABLE | - |
| daily_count | INTEGER | NULLABLE | - |
| cumulative_total | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_feed_collage_full_view` (dim_feed_collage_full_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_collage_count_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:48
**扫描工具**: scan_metadata_v2.py
