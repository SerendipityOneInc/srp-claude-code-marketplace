# rpt_images_quality_pixel_distribution_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_distribution_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 2,211,983 行
**大小**: 0.56 GB
**创建时间**: 2024-12-06
**最后更新**: 2025-12-31

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_f_creates_at | DATE | NULLABLE | 商品创建时间 |
| site | STRING | NULLABLE | 站点 |
| total_sku_cnt | INTEGER | NULLABLE | SKU总数 |
| total_spu_cnt | INTEGER | NULLABLE | SPU总数 |
| tiny_image_sku_cnt | INTEGER | NULLABLE | tiny image的SKU数 |
| small_image_sku_cnt | INTEGER | NULLABLE | small image的SKU数 |
| medium_image_sku_cnt | INTEGER | NULLABLE | medium image的SKU数 |
| large_image_sku_cnt | INTEGER | NULLABLE | large image的SKU数 |
| size_2k_image_sku_cnt | INTEGER | NULLABLE | 2k image的SKU数 |
| size_4k_image_sku_cnt | INTEGER | NULLABLE | 4k image的SKU数 |
| size_8k_image_sku_cnt | INTEGER | NULLABLE | 8k image的SKU数 |
| tiny_main_image_sku_cnt | INTEGER | NULLABLE | 主图是tiny image的SKU数 |
| small_main_image_sku_cnt | INTEGER | NULLABLE | 主图是small image的SKU数 |
| medium_main_image_sku_cnt | INTEGER | NULLABLE | 主图是medium image的SKU数 |
| large_main_image_sku_cnt | INTEGER | NULLABLE | 主图是large image的SKU数 |
| size_2k_main_image_sku_cnt | INTEGER | NULLABLE | 主图是2k image的SKU数 |
| size_4k_main_image_sku_cnt | INTEGER | NULLABLE | 主图是4k image的SKU数 |
| size_8k_main_image_sku_cnt | INTEGER | NULLABLE | 主图是8k image的SKU数 |
| tiny_image_spu_cnt | INTEGER | NULLABLE | tiny image的SPU数 |
| small_image_spu_cnt | INTEGER | NULLABLE | small image的SPU数 |
| medium_image_spu_cnt | INTEGER | NULLABLE | medium image的SPU数 |
| large_image_spu_cnt | INTEGER | NULLABLE | large image的SPU数 |
| size_2k_image_spu_cnt | INTEGER | NULLABLE | 2k image的SPU数 |
| size_4k_image_spu_cnt | INTEGER | NULLABLE | 4k image的SPU数 |
| size_8k_image_spu_cnt | INTEGER | NULLABLE | 8k image的SPU数 |
| tiny_main_image_spu_cnt | INTEGER | NULLABLE | 主图是tiny image的SPU数 |
| small_main_image_spu_cnt | INTEGER | NULLABLE | 主图是small image的SPU数 |
| medium_main_image_spu_cnt | INTEGER | NULLABLE | 主图是medium image的SPU数 |
| large_main_image_spu_cnt | INTEGER | NULLABLE | 主图是large image的SPU数 |
| size_2k_main_image_spu_cnt | INTEGER | NULLABLE | 主图是2k image的SPU数 |
| size_4k_main_image_spu_cnt | INTEGER | NULLABLE | 主图是4k image的SPU数 |
| size_8k_main_image_spu_cnt | INTEGER | NULLABLE | 主图是8k image的SPU数 |
| dt | DATE | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_distribution_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:58
**扫描工具**: scan_metadata_v2.py
