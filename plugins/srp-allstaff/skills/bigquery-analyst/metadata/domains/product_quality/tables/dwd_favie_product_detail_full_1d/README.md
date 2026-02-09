# dwd_favie_product_detail_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-03
**最后更新**: 2025-12-03

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| spu_id | STRING | NULLABLE | - |
| request_sku_id | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| sub_title | STRING | NULLABLE | - |
| sub_title_link | STRING | NULLABLE | - |
| shop_id | STRING | NULLABLE | - |
| shop_name | STRING | NULLABLE | - |
| shop_site | STRING | NULLABLE | - |
| link_in_shop | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| description_external_link | STRING | NULLABLE | - |
| rich_product_description | STRING | NULLABLE | - |
| price | STRING | NULLABLE | - |
| f_historical_prices | STRING | NULLABLE | - |
| rrp | STRING | NULLABLE | - |
| images | STRING | NULLABLE | - |
| f_images | STRING | NULLABLE | - |
| categories | STRING | NULLABLE | - |
| f_categories | STRING | NULLABLE | - |
| videos | STRING | NULLABLE | - |
| f_videos | STRING | NULLABLE | - |
| brand | STRING | NULLABLE | - |
| f_brand | STRING | NULLABLE | - |
| keywords | STRING | NULLABLE | - |
| feature_bullets | STRING | NULLABLE | - |
| attributes | STRING | NULLABLE | - |
| specifications | STRING | NULLABLE | - |
| extended_info | STRING | NULLABLE | - |
| best_seller_rank | STRING | NULLABLE | - |
| seller | STRING | NULLABLE | - |
| inventory | STRING | NULLABLE | - |
| deal | STRING | NULLABLE | - |
| returns_policy | STRING | NULLABLE | - |
| review_summary | STRING | NULLABLE | - |
| promotion | STRING | NULLABLE | - |
| variants | STRING | NULLABLE | - |
| f_meta | STRING | NULLABLE | - |
| f_updates_at | STRING | NULLABLE | - |
| f_creates_at | STRING | NULLABLE | - |
| f_tags | STRING | NULLABLE | - |
| first_parser_name | STRING | NULLABLE | - |
| last_parser_name | STRING | NULLABLE | - |
| f_system_tags | STRING | NULLABLE | - |
| f_image_list | STRING | NULLABLE | - |
| f_status | STRING | NULLABLE | - |
| sku_link | STRING | NULLABLE | - |
| f_cate_tags | STRING | NULLABLE | - |
| variants_str | STRING | NULLABLE | - |
| price_status | INTEGER | NULLABLE | - |
| ad_link | STRING | NULLABLE | - |
| design_info | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:11:30
**扫描工具**: scan_metadata_v2.py
