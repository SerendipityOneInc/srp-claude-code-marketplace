# dim_replica_task_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_replica_task_view`
**层级**: 未分类
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
| _id | STRING | NULLABLE | - |
| cf_ipcountry | STRING | NULLABLE | - |
| completed_timestamp | INTEGER | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| cur_step | INTEGER | NULLABLE | - |
| f_source | STRING | NULLABLE | - |
| f_version | STRING | NULLABLE | - |
| generate_replica_trace_id | STRING | NULLABLE | - |
| id | STRING | NULLABLE | - |
| is_valid | BOOLEAN | NULLABLE | - |
| last_updated | INTEGER | NULLABLE | - |
| more_infos | STRING | NULLABLE | - |
| preference | STRING | NULLABLE | - |
| replica_list | STRING | NULLABLE | - |
| replica_list_size | INTEGER | NULLABLE | - |
| replica_model_url | STRING | NULLABLE | - |
| replica_task_id | STRING | NULLABLE | - |
| skip_face_detection | BOOLEAN | NULLABLE | - |
| source_replica_model_url | STRING | NULLABLE | - |
| source_replica_task_id | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| total_steps | INTEGER | NULLABLE | - |
| type | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| user_image_url | STRING | NULLABLE | - |
| user_prompt_options | STRING | NULLABLE | - |
| user_prompt | STRING | NULLABLE | - |
| valid_message | STRING | NULLABLE | - |
| validate_face_trace_id | STRING | NULLABLE | - |
| workflow_name | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.gem` (gem)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_replica_task_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:34
**扫描工具**: scan_metadata_v2.py
