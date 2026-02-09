# dim_decofy_creation_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_decofy_creation_view`
**层级**: 未分类
**业务域**: decofy
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
| color_palette | STRING | NULLABLE | - |
| created_at | TIMESTAMP | NULLABLE | - |
| creation_id | STRING | NULLABLE | - |
| creation_plan | STRING | NULLABLE | - |
| creation_products | STRING | REPEATED | - |
| creation_url | STRING | NULLABLE | - |
| deleted_at | TIMESTAMP | NULLABLE | - |
| design_style | STRING | NULLABLE | - |
| feed_id | STRING | NULLABLE | - |
| feed_product_id | STRING | NULLABLE | - |
| generation_time_taken | NUMERIC | NULLABLE | - |
| plan_time_taken | NUMERIC | NULLABLE | - |
| primary_entry_id | STRING | NULLABLE | - |
| product_images | STRING | NULLABLE | - |
| project_id | STRING | NULLABLE | - |
| prompt | STRING | NULLABLE | - |
| quality | STRING | NULLABLE | - |
| query | STRING | NULLABLE | - |
| query_image_sizes | STRING | NULLABLE | - |
| query_images | STRING | REPEATED | - |
| remix_id | STRING | NULLABLE | - |
| room_type | STRING | NULLABLE | - |
| search_country | STRING | NULLABLE | - |
| search_time_taken | NUMERIC | NULLABLE | - |
| searched_products | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| style_images | STRING | NULLABLE | - |
| updated_at | TIMESTAMP | NULLABLE | - |
| user_id | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.decofy_creations` (decofy_creations)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_decofy_creation_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:31
**扫描工具**: scan_metadata_v2.py
