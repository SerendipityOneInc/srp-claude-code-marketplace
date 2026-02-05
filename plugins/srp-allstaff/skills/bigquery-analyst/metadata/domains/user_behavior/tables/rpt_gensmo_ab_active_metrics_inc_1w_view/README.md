# rpt_gensmo_ab_active_metrics_inc_1w_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_active_metrics_inc_1w_view`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-10
**最后更新**: 2025-11-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| week_end_dt | DATE | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| ab_project_name | STRING | NULLABLE | - |
| ab_router_id | STRING | NULLABLE | - |
| ab_router_name | STRING | NULLABLE | - |
| active_user_w1_cnt | INTEGER | NULLABLE | - |
| total_duration | FLOAT | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1w` (rpt_gensmo_user_active_metrics_inc_1w)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_active_metrics_inc_1w_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:17
**扫描工具**: scan_metadata_v2.py
