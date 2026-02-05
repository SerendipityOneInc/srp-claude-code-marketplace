# dim_gem_task_response_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_task_response_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-16
**最后更新**: 2025-12-16

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| analysis_image_latency | FLOAT | NULLABLE | - |
| call_moodboard_latency | FLOAT | NULLABLE | - |
| call_rag_latency | FLOAT | NULLABLE | - |
| call_spider_product_latency | FLOAT | NULLABLE | - |
| call_steps | STRING | REPEATED | - |
| debug_infos | STRING | NULLABLE | - |
| gem_debug_infos | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| generate_collage_context_input | STRING | NULLABLE | - |
| generate_collage_context_latency | FLOAT | NULLABLE | - |
| generic_llm | STRING | NULLABLE | - |
| ha3_moodboards | STRING | REPEATED | - |
| ha3_plain_svg_text | STRING | NULLABLE | - |
| image_description | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| include_image_file | BOOLEAN | NULLABLE | - |
| intention | STRING | NULLABLE | - |
| last_updated | INTEGER | NULLABLE | - |
| log_dict | STRING | NULLABLE | - |
| moodboard_debug_infos | STRING | NULLABLE | - |
| moodboard_more_response | STRING | NULLABLE | - |
| moodboard_size | INTEGER | NULLABLE | - |
| moodboards | STRING | REPEATED | - |
| more_infos | STRING | NULLABLE | - |
| plain_svg_text | STRING | NULLABLE | - |
| qr_result | STRING | NULLABLE | - |
| query | STRING | NULLABLE | - |
| rag_query | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| recording_task_latencys | STRING | REPEATED | - |
| save_file_latency | FLOAT | NULLABLE | - |
| search | STRING | NULLABLE | - |
| search_latency | FLOAT | NULLABLE | - |
| search_product | STRING | NULLABLE | - |
| search_product_list | STRING | NULLABLE | - |
| spider_product_origin_url | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| f_version | STRING | NULLABLE | - |
| f_source | STRING | NULLABLE | - |
| error_message | STRING | NULLABLE | - |
| traceparent | STRING | NULLABLE | - |
| workflow | STRING | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.copilot_gem_task_response` (copilot_gem_task_response)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_task_response_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:07
**扫描工具**: scan_metadata_v2.py
