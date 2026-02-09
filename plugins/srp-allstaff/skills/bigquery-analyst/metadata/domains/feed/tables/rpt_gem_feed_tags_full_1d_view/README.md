# rpt_gem_feed_tags_full_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_feed_tags_full_1d_view`
**层级**: RPT (报表层)
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
| dt | STRING | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| moodboard_image_url | STRING | NULLABLE | - |
| style_1 | STRING | NULLABLE | - |
| style_2 | STRING | NULLABLE | - |
| occasion_1 | STRING | NULLABLE | - |
| occasion_2 | STRING | NULLABLE | - |
| color | STRING | NULLABLE | - |
| weather | STRING | NULLABLE | - |
| temperature | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| age | STRING | NULLABLE | - |
| body_size | STRING | NULLABLE | - |
| body_shape | STRING | NULLABLE | - |
| height | STRING | NULLABLE | - |
| tagger | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gem_feed_tags_full_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:50
**扫描工具**: scan_metadata_v2.py
