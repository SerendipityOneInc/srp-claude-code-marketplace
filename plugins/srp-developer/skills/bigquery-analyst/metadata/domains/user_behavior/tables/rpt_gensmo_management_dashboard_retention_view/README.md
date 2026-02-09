# rpt_gensmo_management_dashboard_retention_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_view`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-16
**最后更新**: 2025-09-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| event_dt | DATE | NULLABLE | - |
| is_new_user | STRING | NULLABLE | - |
| ad_media_source | STRING | NULLABLE | - |
| user_country | STRING | NULLABLE | - |
| last_platform | STRING | NULLABLE | - |
| last_app_version | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| d0_active | INTEGER | NULLABLE | - |
| d1_retention | INTEGER | NULLABLE | - |
| d2_retention | INTEGER | NULLABLE | - |
| d6_retention | INTEGER | NULLABLE | - |
| d1_7_retention | INTEGER | NULLABLE | - |
| LT_1_to_6 | INTEGER | NULLABLE | - |
| w1_retention | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:05
**扫描工具**: scan_metadata_v2.py
