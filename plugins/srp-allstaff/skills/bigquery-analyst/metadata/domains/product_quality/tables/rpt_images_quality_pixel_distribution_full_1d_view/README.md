# rpt_images_quality_pixel_distribution_full_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_distribution_full_1d_view`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-15
**最后更新**: 2025-12-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_f_creates_at | DATE | NULLABLE | - |
| site | STRING | NULLABLE | - |
| total_sku_cnt | INTEGER | NULLABLE | - |
| total_spu_cnt | INTEGER | NULLABLE | - |
| tiny_image_sku_cnt | INTEGER | NULLABLE | - |
| small_image_sku_cnt | INTEGER | NULLABLE | - |
| medium_image_sku_cnt | INTEGER | NULLABLE | - |
| large_image_sku_cnt | INTEGER | NULLABLE | - |
| size_2k_image_sku_cnt | INTEGER | NULLABLE | - |
| size_4k_image_sku_cnt | INTEGER | NULLABLE | - |
| size_8k_image_sku_cnt | INTEGER | NULLABLE | - |
| tiny_main_image_sku_cnt | INTEGER | NULLABLE | - |
| small_main_image_sku_cnt | INTEGER | NULLABLE | - |
| medium_main_image_sku_cnt | INTEGER | NULLABLE | - |
| large_main_image_sku_cnt | INTEGER | NULLABLE | - |
| size_2k_main_image_sku_cnt | INTEGER | NULLABLE | - |
| size_4k_main_image_sku_cnt | INTEGER | NULLABLE | - |
| size_8k_main_image_sku_cnt | INTEGER | NULLABLE | - |
| tiny_image_spu_cnt | INTEGER | NULLABLE | - |
| small_image_spu_cnt | INTEGER | NULLABLE | - |
| medium_image_spu_cnt | INTEGER | NULLABLE | - |
| large_image_spu_cnt | INTEGER | NULLABLE | - |
| size_2k_image_spu_cnt | INTEGER | NULLABLE | - |
| size_4k_image_spu_cnt | INTEGER | NULLABLE | - |
| size_8k_image_spu_cnt | INTEGER | NULLABLE | - |
| tiny_main_image_spu_cnt | INTEGER | NULLABLE | - |
| small_main_image_spu_cnt | INTEGER | NULLABLE | - |
| medium_main_image_spu_cnt | INTEGER | NULLABLE | - |
| large_main_image_spu_cnt | INTEGER | NULLABLE | - |
| size_2k_main_image_spu_cnt | INTEGER | NULLABLE | - |
| size_4k_main_image_spu_cnt | INTEGER | NULLABLE | - |
| size_8k_main_image_spu_cnt | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_distribution_full_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:00
**扫描工具**: scan_metadata_v2.py
