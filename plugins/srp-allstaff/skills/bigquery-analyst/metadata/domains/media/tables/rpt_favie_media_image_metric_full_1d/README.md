# rpt_favie_media_image_metric_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_metric_full_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2024-11-22
**最后更新**: 2024-11-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| source_type | INTEGER | NULLABLE | - |
| total_image_num | INTEGER | REQUIRED | - |
| daily_new_image_num | INTEGER | REQUIRED | - |
| daily_update_image_num | INTEGER | REQUIRED | - |
| image_size_lt_10k | INTEGER | REQUIRED | - |
| image_size_10k_to_100k | INTEGER | REQUIRED | - |
| image_size_100k_to_500k | INTEGER | REQUIRED | - |
| image_size_500k_to_1m | INTEGER | REQUIRED | - |
| image_size_1m_to_5m | INTEGER | REQUIRED | - |
| image_size_5m_to_20m | INTEGER | REQUIRED | - |
| image_size_gt_20m | INTEGER | REQUIRED | - |
| image_pixel_tiny | INTEGER | REQUIRED | - |
| image_pixel_small | INTEGER | REQUIRED | - |
| image_pixel_medium | INTEGER | REQUIRED | - |
| image_pixel_large | INTEGER | REQUIRED | - |
| image_pixel_2k | INTEGER | REQUIRED | - |
| image_pixel_4k | INTEGER | REQUIRED | - |
| image_pixel_gt_8k | INTEGER | REQUIRED | - |
| image_format_jpeg | INTEGER | REQUIRED | - |
| image_format_png | INTEGER | REQUIRED | - |
| image_format_gif | INTEGER | REQUIRED | - |
| image_format_webp | INTEGER | REQUIRED | - |
| image_format_other | INTEGER | REQUIRED | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_media_image_metric_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:56
**扫描工具**: scan_metadata_v2.py
