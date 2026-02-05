# rpt_gensmo_analysis_search_country_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_country_1d_view`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-05-26
**最后更新**: 2025-05-26

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| device_id | STRING | NULLABLE | - |
| raw_query | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |
| trace_id | STRING | NULLABLE | - |
| last_country | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_view` (dwd_favie_gem_workflow_inc_1d_view)
- `srpproduct-dc37e.favie_dw.dim_gem_user_view` (dim_gem_user_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_analysis_search_country_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:44
**扫描工具**: scan_metadata_v2.py
