# dim_moodboard_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_moodboard_view`
**层级**: 未分类
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| _id | STRING | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| update_time | TIMESTAMP | NULLABLE | - |
| publish_time | TIMESTAMP | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| moodboard_index | INTEGER | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| status | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |
| is_try_on | BOOLEAN | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| hashtags | STRING | NULLABLE | - |
| height | INTEGER | NULLABLE | - |
| width | INTEGER | NULLABLE | - |
| search_product_list | STRING | REPEATED | - |
| moodboard_products | STRING | REPEATED | - |
| image | STRING | NULLABLE | - |
| user_image_tag | STRING | NULLABLE | - |
| image_url | STRING | NULLABLE | - |
| image_description | STRING | NULLABLE | - |
| image_height | INTEGER | NULLABLE | - |
| image_width | INTEGER | NULLABLE | - |
| liked_count | INTEGER | NULLABLE | - |
| remix | INTEGER | NULLABLE | - |
| saved_count | INTEGER | NULLABLE | - |
| shared_count | INTEGER | NULLABLE | - |
| score | STRING | NULLABLE | - |
| intention | STRING | NULLABLE | - |
| moodboards | STRING | NULLABLE | - |
| query | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| publisher | STRING | NULLABLE | - |
| cover_image_list | STRING | REPEATED | - |
| created_user_id | STRING | NULLABLE | - |
| is_onboard | BOOLEAN | NULLABLE | - |
| moderation_status | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.mongo_production.copilot_moodboard` (copilot_moodboard)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_moodboard_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:09:30
**扫描工具**: scan_metadata_v2.py
