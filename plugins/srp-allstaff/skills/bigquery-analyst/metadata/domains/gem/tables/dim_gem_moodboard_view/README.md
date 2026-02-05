# dim_gem_moodboard_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_gem_moodboard_view`
**层级**: 未分类
**业务域**: gem
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-05-13
**最后更新**: 2025-05-13

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| score | FLOAT | NULLABLE | - |
| is_try_on | BOOLEAN | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| image | STRING | NULLABLE | - |
| search_product_list | STRING | NULLABLE | - |
| image_width | FLOAT | NULLABLE | - |
| query | STRING | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| updated_time | TIMESTAMP | NULLABLE | - |
| updated_date | DATE | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| created_date | DATE | NULLABLE | - |
| status | STRING | NULLABLE | - |
| remix | INTEGER | NULLABLE | - |
| created_user_id | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| image_height | FLOAT | NULLABLE | - |
| image_description | STRING | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |
| last_updated | INTEGER | NULLABLE | - |
| intention | STRING | NULLABLE | - |
| moodboards | STRING | NULLABLE | - |
| height | INTEGER | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_mongodb_integration_stitch3_v2.moodboard_feed_serialized` (moodboard_feed_serialized)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_gem_moodboard_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:01
**扫描工具**: scan_metadata_v2.py
