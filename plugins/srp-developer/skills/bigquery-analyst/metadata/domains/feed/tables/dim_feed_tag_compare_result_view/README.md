# dim_feed_tag_compare_result_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_feed_tag_compare_result_view`
**层级**: 未分类
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-09
**最后更新**: 2025-06-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| moodboard_id | STRING | NULLABLE | - |
| tagger1_style1 | STRING | NULLABLE | - |
| tagger1_style2 | STRING | NULLABLE | - |
| tagger1_occasion1 | STRING | NULLABLE | - |
| tagger1_occasion2 | STRING | NULLABLE | - |
| tagger1_color | STRING | NULLABLE | - |
| tagger1_weather | STRING | NULLABLE | - |
| tagger1_temperature | STRING | NULLABLE | - |
| tagger1_gender | STRING | NULLABLE | - |
| tagger1_age | STRING | NULLABLE | - |
| tagger1_body_shape | STRING | NULLABLE | - |
| tagger1_body_size | STRING | NULLABLE | - |
| tagger1_height | STRING | NULLABLE | - |
| tagger2_style1 | STRING | NULLABLE | - |
| tagger2_style2 | STRING | NULLABLE | - |
| tagger2_occasion1 | STRING | NULLABLE | - |
| tagger2_occasion2 | STRING | NULLABLE | - |
| tagger2_color | STRING | NULLABLE | - |
| tagger2_weather | STRING | NULLABLE | - |
| tagger2_temperature | STRING | NULLABLE | - |
| tagger2_gender | STRING | NULLABLE | - |
| tagger2_age | STRING | NULLABLE | - |
| tagger2_body_shape | STRING | NULLABLE | - |
| tagger2_body_size | STRING | NULLABLE | - |
| tagger2_height | STRING | NULLABLE | - |
| style1_score | FLOAT | NULLABLE | - |
| style2_score | FLOAT | NULLABLE | - |
| occasion1_score | FLOAT | NULLABLE | - |
| occasion2_score | FLOAT | NULLABLE | - |
| color_score | FLOAT | NULLABLE | - |
| weather_score | FLOAT | NULLABLE | - |
| temperature_score | FLOAT | NULLABLE | - |
| gender_score | FLOAT | NULLABLE | - |
| age_score | FLOAT | NULLABLE | - |
| body_shape_score | FLOAT | NULLABLE | - |
| body_size_score | FLOAT | NULLABLE | - |
| height_score | FLOAT | NULLABLE | - |
| moodboard_image_url | STRING | NULLABLE | - |
| compare_group | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_feed_tag_compare_result_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:35
**扫描工具**: scan_metadata_v2.py
