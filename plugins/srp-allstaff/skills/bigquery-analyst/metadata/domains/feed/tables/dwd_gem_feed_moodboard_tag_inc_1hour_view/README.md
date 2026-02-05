# dwd_gem_feed_moodboard_tag_inc_1hour_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_feed_moodboard_tag_inc_1hour_view`
**层级**: DWD (明细层)
**业务域**: feed
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-26
**最后更新**: 2025-06-26

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |
| process_time | TIMESTAMP | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| moodboard_image_url | STRING | NULLABLE | - |
| product_ids | STRING | REPEATED | - |
| products | STRING | REPEATED | - |
| style | STRING | NULLABLE | - |
| occasion | STRING | NULLABLE | - |
| color | STRING | NULLABLE | - |
| weather | STRING | NULLABLE | - |
| temperature | STRING | NULLABLE | - |
| age | STRING | NULLABLE | - |
| gender | STRING | NULLABLE | - |
| body_size | STRING | NULLABLE | - |
| body_shape | STRING | NULLABLE | - |
| height | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_feed_moodboard_tag_inc_1hour_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:15
**扫描工具**: scan_metadata_v2.py
