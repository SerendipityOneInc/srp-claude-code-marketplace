# dim_favie_gensmo_feed_tag_result_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_tag_result_view`
**层级**: 未分类
**业务域**: feed
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
| moodboard_id | STRING | NULLABLE | - |
| moodboard_image_url | STRING | NULLABLE | - |
| Style_primary | STRING | NULLABLE | - |
| Style_secondary | STRING | NULLABLE | - |
| Occasion_primary | STRING | NULLABLE | - |
| Occasion_secondary | STRING | NULLABLE | - |
| Weather_primary | STRING | NULLABLE | - |
| Weather_secondary | STRING | NULLABLE | - |
| Temperature_primary | STRING | NULLABLE | - |
| Temperature_secondary | STRING | NULLABLE | - |
| Color_primary | STRING | NULLABLE | - |
| Color_secondary | STRING | NULLABLE | - |
| Gender_primary | STRING | NULLABLE | - |
| Gender_secondary | STRING | NULLABLE | - |
| Age_primary | STRING | NULLABLE | - |
| Age_secondary | STRING | NULLABLE | - |
| Body_Shape_primary | STRING | NULLABLE | - |
| Body_Shape_secondary | STRING | NULLABLE | - |
| Body_Size_primary | STRING | NULLABLE | - |
| Body_Size_secondary | STRING | NULLABLE | - |
| Height_primary | STRING | NULLABLE | - |
| Height_secondary | STRING | NULLABLE | - |
| products | RECORD | REPEATED | - |
| rn | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_tag_result_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:05
**扫描工具**: scan_metadata_v2.py
