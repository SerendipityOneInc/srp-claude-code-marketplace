# rpt_gensmo_ab_search_metrics_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_search_metrics_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: search
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-15
**最后更新**: 2025-07-15

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
| search_trigger_pv_cnt | INTEGER | NULLABLE | - |
| search_boot_page_view_pv_cnt | INTEGER | NULLABLE | - |
| search_boot_polish_pv_cnt | INTEGER | NULLABLE | - |
| search_boot_focus_pv_cnt | INTEGER | NULLABLE | - |
| search_trigger_user_cnt | INTEGER | NULLABLE | - |
| search_boot_page_view_user_cnt | INTEGER | NULLABLE | - |
| search_boot_polish_user_cnt | INTEGER | NULLABLE | - |
| search_boot_focus_user_cnt | INTEGER | NULLABLE | - |
| DAU | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_search_metrics_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:28
**扫描工具**: scan_metadata_v2.py
