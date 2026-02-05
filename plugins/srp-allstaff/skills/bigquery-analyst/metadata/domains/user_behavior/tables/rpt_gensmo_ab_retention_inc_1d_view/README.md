# rpt_gensmo_ab_retention_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_retention_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-04
**最后更新**: 2025-07-04

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| ab_project_name | STRING | NULLABLE | - |
| ab_router_id | STRING | NULLABLE | - |
| ab_router_name | STRING | NULLABLE | - |
| retention_user_d1_cnt | INTEGER | NULLABLE | - |
| active_user_cnt | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d` (rpt_gensmo_user_retention_metrics_inc_1d)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_retention_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:24
**扫描工具**: scan_metadata_v2.py
