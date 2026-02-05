# dim_favie_gensmo_feed_item_products_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_item_products_view`
**层级**: 未分类
**业务域**: product_quality
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
| feed_type | STRING | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| moodboard_image_url | STRING | NULLABLE | - |
| query | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| tags | RECORD | REPEATED | - |
| score | FLOAT | NULLABLE | - |
| is_feed | BOOLEAN | NULLABLE | - |
| search_engine | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| product | STRING | NULLABLE | - |
| created_time | TIMESTAMP | NULLABLE | - |
| update_time | TIMESTAMP | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_item_products_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:07:58
**扫描工具**: scan_metadata_v2.py
