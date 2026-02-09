# rpt_favie_gensmo_creator_details_metric_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_creator_details_metric_view`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| uid | STRING | NULLABLE | - |
| name | STRING | NULLABLE | - |
| register_time | TIMESTAMP | NULLABLE | - |
| last_device_id | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| is_internal_user | BOOLEAN | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| active_days | INTEGER | NULLABLE | - |
| search_count | INTEGER | NULLABLE | - |
| tryon_count | INTEGER | NULLABLE | - |
| publish_count | INTEGER | NULLABLE | - |
| online_post_count | INTEGER | NULLABLE | - |
| avatar_id | STRING | NULLABLE | - |
| model_id | STRING | NULLABLE | - |
| model_url | STRING | NULLABLE | - |
| avatar_created_at | TIMESTAMP | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_try_on_task_view` (dim_try_on_task_view)
- `srpproduct-dc37e.favie_mongodb_integration_airbyte.chat_session_messages` (chat_session_messages)
- `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d` (dim_favie_gensmo_user_account_changelog_1d)
- `srpproduct-dc37e.favie_dw.dim_gensmo_user_account_view` (dim_gensmo_user_account_view)
- `srpproduct-dc37e.favie_dw.dim_moodboard_view` (dim_moodboard_view)
- `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` (dws_favie_gensmo_user_feature_inc_1d)
- `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` (dim_gem_user_replica_view)
- `srpproduct-dc37e.favie_dw.dim_chat_session_messages_view` (dim_chat_session_messages_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_creator_details_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:10
**扫描工具**: scan_metadata_v2.py
