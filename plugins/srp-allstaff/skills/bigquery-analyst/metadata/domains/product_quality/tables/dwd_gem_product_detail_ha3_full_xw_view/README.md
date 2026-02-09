# dwd_gem_product_detail_ha3_full_xw_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_full_xw_view`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2026-01-29
**最后更新**: 2026-01-29

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| CMD | STRING | NULLABLE | - |
| f_sku_id | STRING | NULLABLE | - |
| f_spu_id | STRING | NULLABLE | - |
| site | STRING | NULLABLE | - |
| site_info | STRING | NULLABLE | - |
| sku_id | STRING | NULLABLE | - |
| spu_id | STRING | NULLABLE | - |
| title | STRING | NULLABLE | - |
| link | STRING | NULLABLE | - |
| keywords | STRING | NULLABLE | - |
| brand | STRING | NULLABLE | - |
| f_brand | STRING | NULLABLE | - |
| category_id | STRING | NULLABLE | - |
| category_names | STRING | NULLABLE | - |
| f_category_id | STRING | NULLABLE | - |
| f_category_names | STRING | NULLABLE | - |
| description | STRING | NULLABLE | - |
| user_reviews_infos | STRING | NULLABLE | - |
| extend_text | STRING | NULLABLE | - |
| specifications | STRING | NULLABLE | - |
| item_emb | STRING | NULLABLE | - |
| pidvid | STRING | NULLABLE | - |
| auction_tag | STRING | NULLABLE | - |
| f_level_one_category | STRING | NULLABLE | - |
| f_level_leaf_category | STRING | NULLABLE | - |
| attr_name | STRING | NULLABLE | - |
| is_excellent | INTEGER | NULLABLE | - |
| rating | INTEGER | NULLABLE | - |
| ratings_total | INTEGER | NULLABLE | - |
| local_price | INTEGER | NULLABLE | - |
| base_price | INTEGER | NULLABLE | - |
| uv_sum | INTEGER | NULLABLE | - |
| seller_score | INTEGER | NULLABLE | - |
| price_power_score | INTEGER | NULLABLE | - |
| status | INTEGER | NULLABLE | - |
| base_currency | INTEGER | NULLABLE | - |
| local_currency | INTEGER | NULLABLE | - |
| is_used | INTEGER | NULLABLE | - |
| is_bundle | INTEGER | NULLABLE | - |
| is_preorder | INTEGER | NULLABLE | - |
| is_best_offer | INTEGER | NULLABLE | - |
| is_marketplace_item | INTEGER | NULLABLE | - |
| is_private_brand | INTEGER | NULLABLE | - |
| recent_sales | INTEGER | NULLABLE | - |
| is_best_seller | INTEGER | NULLABLE | - |
| inventory | STRING | NULLABLE | - |
| is_deal | INTEGER | NULLABLE | - |
| is_lightning_deal | INTEGER | NULLABLE | - |
| is_member_exclusive | INTEGER | NULLABLE | - |
| discount | FLOAT | NULLABLE | - |
| sell_amount_last_month | INTEGER | NULLABLE | - |
| brand_score | INTEGER | NULLABLE | - |
| saving_score | INTEGER | NULLABLE | - |
| specifications_kv | STRING | NULLABLE | - |
| text_info | STRING | NULLABLE | - |
| f_images | STRING | NULLABLE | - |
| feature_bullets | STRING | NULLABLE | - |
| product_tag | STRING | NULLABLE | - |
| style_tag | STRING | NULLABLE | - |
| material_tag | STRING | NULLABLE | - |
| color_tag | STRING | NULLABLE | - |
| pattern_tag | STRING | NULLABLE | - |
| occasion_tag | STRING | NULLABLE | - |
| season_tag | STRING | NULLABLE | - |
| f_main_image_url | STRING | NULLABLE | - |
| seo_title | STRING | NULLABLE | - |
| seo_text_info | STRING | NULLABLE | - |
| demographic | STRING | NULLABLE | - |
| alg_description | STRING | NULLABLE | - |
| norm_brand | STRING | NULLABLE | - |
| display_score | INTEGER | NULLABLE | - |
| display_image | STRING | NULLABLE | - |
| collage_category | STRING | NULLABLE | - |
| is_brand_site | STRING | NULLABLE | - |
| image_score | FLOAT | NULLABLE | - |
| length | STRING | NULLABLE | - |
| closure | STRING | NULLABLE | - |
| fit_type | STRING | NULLABLE | - |
| function | STRING | NULLABLE | - |
| neckline | STRING | NULLABLE | - |
| sleeve_length | STRING | NULLABLE | - |
| sleeve_style | STRING | NULLABLE | - |
| shape | STRING | NULLABLE | - |
| features | STRING | NULLABLE | - |
| color_family | STRING | NULLABLE | - |
| color_tone | STRING | NULLABLE | - |
| color_saturation | STRING | NULLABLE | - |
| tag_text_info | STRING | NULLABLE | - |
| created_time | STRING | NULLABLE | - |
| product_created_at | TIMESTAMP | NULLABLE | - |
| product_updated_at | TIMESTAMP | NULLABLE | - |
| record_create_time | TIMESTAMP | NULLABLE | - |
| record_update_time | TIMESTAMP | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_product_detail_ha3_full_xw_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:13:31
**扫描工具**: scan_metadata_v2.py
