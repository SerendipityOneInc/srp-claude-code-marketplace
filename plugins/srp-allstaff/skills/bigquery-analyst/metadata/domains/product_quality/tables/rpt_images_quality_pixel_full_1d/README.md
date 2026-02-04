# rpt_images_quality_pixel_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 4,723 行
**大小**: 0.00 GB
**创建时间**: 2024-12-02
**最后更新**: 2024-12-06

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_f_creates_at | DATE | NULLABLE | 商品创建时间 |
| site | STRING | NULLABLE | 站点 |
| sku_total_cnt | INTEGER | NULLABLE | SKU总数 |
| spu_total_cnt | INTEGER | NULLABLE | SPU总数 |
| possess_tiny_image_sku_cnt | INTEGER | NULLABLE | 有tiny image的SKU数 |
| possess_small_image_sku_cnt | INTEGER | NULLABLE | 有small image的SKU数 |
| possess_medium_image_sku_cnt | INTEGER | NULLABLE | 有medium image的SKU数 |
| possess_large_image_sku_cnt | INTEGER | NULLABLE | 有large image的SKU数 |
| possess_tiny_main_image_sku_cnt | INTEGER | NULLABLE | 主图是tiny image的SKU数 |
| possess_small_main_image_sku_cnt | INTEGER | NULLABLE | 主图是small image的SKU数 |
| possess_medium_main_image_sku_cnt | INTEGER | NULLABLE | 主图是medium image的SKU数 |
| possess_large_main_image_sku_cnt | INTEGER | NULLABLE | 主图是large image的SKU数 |
| possess_tiny_image_spu_cnt | INTEGER | NULLABLE | 有tiny image的SPU数 |
| possess_small_image_spu_cnt | INTEGER | NULLABLE | 有small image的SPU数 |
| possess_medium_image_spu_cnt | INTEGER | NULLABLE | 有medium image的SPU数 |
| possess_large_image_spu_cnt | INTEGER | NULLABLE | 有large image的SPU数 |
| possess_tiny_main_image_spu_cnt | INTEGER | NULLABLE | 主图是tiny image的SPU数 |
| possess_small_main_image_spu_cnt | INTEGER | NULLABLE | 主图是small image的SPU数 |
| possess_medium_main_image_spu_cnt | INTEGER | NULLABLE | 主图是medium image的SPU数 |
| possess_large_main_image_spu_cnt | INTEGER | NULLABLE | 主图是large image的SPU数 |
| dt | DATE | NULLABLE | 日期 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_images_quality_pixel_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:02
**扫描工具**: scan_metadata_v2.py
