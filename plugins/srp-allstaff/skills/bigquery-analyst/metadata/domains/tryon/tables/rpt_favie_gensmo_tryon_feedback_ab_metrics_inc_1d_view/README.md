# rpt_favie_gensmo_tryon_feedback_ab_metrics_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_feedback_ab_metrics_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: tryon
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-15
**最后更新**: 2025-10-15

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
| tryon_complete_succeed_task_cnt | INTEGER | NULLABLE | - |
| tryon_complete_succeed_user_cnt | INTEGER | NULLABLE | - |
| tryon_complete_fail_task_cnt | INTEGER | NULLABLE | - |
| tryon_complete_fail_user_cnt | INTEGER | NULLABLE | - |
| tryon_load_fail_task_cnt | INTEGER | NULLABLE | - |
| tryon_load_fail_user_cnt | INTEGER | NULLABLE | - |
| tryon_load_succeed_task_cnt | INTEGER | NULLABLE | - |
| tryon_load_succeed_user_cnt | INTEGER | NULLABLE | - |
| tryon_save_task_cnt | INTEGER | NULLABLE | - |
| tryon_save_user_cnt | INTEGER | NULLABLE | - |
| tryon_download_task_cnt | INTEGER | NULLABLE | - |
| tryon_download_user_cnt | INTEGER | NULLABLE | - |
| tryon_like_task_cnt | INTEGER | NULLABLE | - |
| tryon_like_user_cnt | INTEGER | NULLABLE | - |
| tryon_dislike_task_cnt | INTEGER | NULLABLE | - |
| tryon_dislike_user_cnt | INTEGER | NULLABLE | - |
| tryon_share_task_cnt | INTEGER | NULLABLE | - |
| tryon_share_user_cnt | INTEGER | NULLABLE | - |
| tryon_post_task_cnt | INTEGER | NULLABLE | - |
| tryon_post_user_cnt | INTEGER | NULLABLE | - |
| tryon_view_product_task_cnt | INTEGER | NULLABLE | - |
| tryon_view_product_user_cnt | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_feedback_ab_metrics_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:34
**扫描工具**: scan_metadata_v2.py
