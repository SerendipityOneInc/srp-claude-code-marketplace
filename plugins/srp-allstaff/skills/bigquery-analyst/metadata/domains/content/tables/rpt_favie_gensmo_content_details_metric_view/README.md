# rpt_favie_gensmo_content_details_metric_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_content_details_metric_view`
**层级**: RPT (报表层)
**业务域**: content
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
| created_time | TIMESTAMP | NULLABLE | - |
| title | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| created_user_id | STRING | NULLABLE | - |
| name | STRING | NULLABLE | - |
| liked_count | INTEGER | NULLABLE | - |
| remix | INTEGER | NULLABLE | - |
| saved_count | INTEGER | NULLABLE | - |
| shared_count | INTEGER | NULLABLE | - |
| source | STRING | NULLABLE | - |
| moodboard_url | STRING | NULLABLE | - |
| cover_image | STRING | NULLABLE | - |
| comment_content | STRING | NULLABLE | - |
| comment_created_at | TIMESTAMP | NULLABLE | - |
| comment_user_id | STRING | NULLABLE | - |
| parent_comment_id | STRING | NULLABLE | - |
| is_bot | BOOLEAN | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_dw.dim_try_on_task_view` (dim_try_on_task_view)
- `srpproduct-dc37e.favie_dw.dim_gem_comment_view` (dim_gem_comment_view)
- `srpproduct-dc37e.favie_dw.dim_gensmo_user_account_view` (dim_gensmo_user_account_view)
- `srpproduct-dc37e.favie_dw.dim_moodboard_view` (dim_moodboard_view)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_content_details_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:08
**扫描工具**: scan_metadata_v2.py
