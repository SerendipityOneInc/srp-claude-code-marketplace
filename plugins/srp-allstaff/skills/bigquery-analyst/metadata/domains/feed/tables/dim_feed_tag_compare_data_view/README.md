# dim_feed_tag_compare_data_view

**表全名**: `srpproduct-dc37e.favie_dw.dim_feed_tag_compare_data_view`
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
| style_one_tags | STRING | REPEATED | - |
| style_two_tags | STRING | REPEATED | - |
| occasion_one_tags | STRING | REPEATED | - |
| occasion_two_tags | STRING | REPEATED | - |
| color_tags | STRING | REPEATED | - |
| weather_tags | STRING | REPEATED | - |
| temperature_tags | STRING | REPEATED | - |
| gender_tags | STRING | REPEATED | - |
| age_tags | STRING | REPEATED | - |
| body_size_tags | STRING | REPEATED | - |
| body_shape_tags | STRING | REPEATED | - |
| height_tags | STRING | REPEATED | - |
| tagger | STRING | NULLABLE | - |
| moodboard_image_url | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_feed_tag_compare_data_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:08:33
**扫描工具**: scan_metadata_v2.py
