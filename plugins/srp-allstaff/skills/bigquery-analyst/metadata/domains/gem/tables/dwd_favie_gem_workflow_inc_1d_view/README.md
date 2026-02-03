# dwd_favie_gem_workflow_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-05-19
**最后更新**: 2025-05-19

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| trace_id | STRING | NULLABLE | - |
| traceparent | STRING | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| raw_query | STRING | NULLABLE | - |
| rewrite_queries | STRING | REPEATED | - |
| image_url | STRING | NULLABLE | - |
| image_description | STRING | NULLABLE | - |
| image_height | FLOAT | NULLABLE | - |
| image_width | FLOAT | NULLABLE | - |
| user_image_tag | STRING | NULLABLE | - |
| collage_title | STRING | NULLABLE | - |
| intention | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| query_source | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| log_timestamp | TIMESTAMP | NULLABLE | - |
| receive_timestamp | TIMESTAMP | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.logging_gem_workflow.stderr_` (stderr_)
- `srpproduct-dc37e.logging_gem_workflow.export_errors_` (export_errors_)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gem_workflow_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:46
**扫描工具**: scan_metadata_v2.py
