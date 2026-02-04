# rpt_gensmo_user_active_metrics_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-20
**最后更新**: 2025-10-20

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_segment | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| active_user_d1_cnt | INTEGER | NULLABLE | - |
| total_duration | FLOAT | NULLABLE | - |
| active_user_1d_cnt | INTEGER | NULLABLE | - |
| active_user_7d_cnt | INTEGER | NULLABLE | - |
| active_user_30d_cnt | INTEGER | NULLABLE | - |
| active_user_1d_duration | FLOAT | NULLABLE | - |
| active_user_7d_duration | FLOAT | NULLABLE | - |
| active_user_30d_duration | FLOAT | NULLABLE | - |
| app_minor_version | INTEGER | NULLABLE | - |
| app_patch_version | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:30
**扫描工具**: scan_metadata_v2.py
