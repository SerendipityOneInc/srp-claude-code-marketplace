# favie_nonstandard_product_detail_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.favie_nonstandard_product_detail_full_1d`
**层级**: 未分类
**业务域**: product_quality
**表类型**: TABLE
**行数**: 6,460,192 行
**大小**: 2.84 GB
**创建时间**: 2025-06-19
**最后更新**: 2026-01-30

---

## 📊 表说明

Native BigQuery table for Favie nonstandard product details with optimized structure for analytics

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| rowkey | STRING | REQUIRED | - |
| f_sku_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| spu_id | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| sub_title | STRING | NULLABLE | - |
| sub_title_link | STRING | NULLABLE | - |
| description_external_link | STRING | NULLABLE | - |
| price | STRING | NULLABLE | - |
| rrp | STRING | NULLABLE | - |
| historical_prices | STRING | NULLABLE | - |
| f_historical_prices | STRING | NULLABLE | - |
| review_summary | STRING | NULLABLE | - |
| images | STRING | NULLABLE | - |
| f_images | STRING | NULLABLE | - |
| f_image_list | STRING | NULLABLE | - |
| f_tags | STRING | NULLABLE | - |
| f_system_tags | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| f_updates_at | STRING | NULLABLE | - |
| f_creates_at | STRING | NULLABLE | - |
| f_meta | STRING | NULLABLE | - |
| request_sku_id | STRING | NULLABLE | - |
| sku_link | STRING | NULLABLE | - |
| shop_id | STRING | NULLABLE | - |
| shop_name | STRING | NULLABLE | - |
| shop_site | STRING | NULLABLE | - |
| link_in_shop | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| rich_product_description | STRING | NULLABLE | - |
| f_images_tags | STRING | NULLABLE | - |
| f_images_bg_remove | STRING | NULLABLE | - |
| f_cate_tags | STRING | NULLABLE | - |
| f_categories | STRING | NULLABLE | - |
| categories | STRING | NULLABLE | - |
| videos | STRING | NULLABLE | - |
| f_videos | STRING | NULLABLE | - |
| f_brand | STRING | NULLABLE | - |
| brand | STRING | NULLABLE | - |
| feature_bullets | STRING | NULLABLE | - |
| attributes | STRING | NULLABLE | - |
| specifications | STRING | NULLABLE | - |
| extended_info | STRING | NULLABLE | - |
| standard_attributes | STRING | NULLABLE | - |
| best_seller_rank | STRING | NULLABLE | - |
| seller | STRING | NULLABLE | - |
| inventory | STRING | NULLABLE | - |
| keywords | STRING | NULLABLE | - |
| deal | STRING | NULLABLE | - |
| returns_policy | STRING | NULLABLE | - |
| variants | STRING | NULLABLE | - |
| variants_str | STRING | NULLABLE | - |
| promotion | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.favie_nonstandard_product_detail_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:39
**扫描工具**: scan_metadata_v2.py
