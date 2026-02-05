# dwd_favie_gem_product_search_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gem_product_search_inc_1d`
**层级**: DWD (明细层)
**业务域**: search
**表类型**: TABLE
**行数**: 199,901,327 行
**大小**: 208.09 GB
**创建时间**: 2025-10-07
**最后更新**: 2025-10-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| trace_id | STRING | NULLABLE | - |
| task_id | STRING | NULLABLE | - |
| raw_query | STRING | NULLABLE | - |
| rewrite_queries | STRING | REPEATED | - |
| qr_query | STRING | NULLABLE | - |
| qp_query | STRING | NULLABLE | - |
| query_modality | STRING | NULLABLE | - |
| search_engine | STRING | NULLABLE | - |
| product_sku_id | STRING | NULLABLE | - |
| product_site | STRING | NULLABLE | - |
| product_shop_site | STRING | NULLABLE | - |
| product_title | STRING | NULLABLE | - |
| product_brand | STRING | NULLABLE | - |
| product_price_currency | STRING | NULLABLE | - |
| product_price_value | INTEGER | NULLABLE | - |
| product_price_raw | STRING | NULLABLE | - |
| product_link | STRING | NULLABLE | - |
| product_image_link | STRING | NULLABLE | - |
| product_rating | FLOAT | NULLABLE | - |
| product_ratings_total | FLOAT | NULLABLE | - |
| product_cate_tag | STRING | NULLABLE | - |
| product_updates_at | STRING | NULLABLE | - |
| product_creates_at | STRING | NULLABLE | - |
| se_recall_timestamp | TIMESTAMP | NULLABLE | - |
| gem_search_timestamp | TIMESTAMP | NULLABLE | - |
| moodboard_id | STRING | NULLABLE | - |
| moodboard_timestamp | TIMESTAMP | NULLABLE | - |
| query_image_url | STRING | NULLABLE | - |
| query_image_description | STRING | NULLABLE | - |
| query_image_height | FLOAT | NULLABLE | - |
| query_image_width | FLOAT | NULLABLE | - |
| query_image_tag | STRING | NULLABLE | - |
| query_intention | STRING | NULLABLE | - |
| query_source | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| is_internal_user | BOOLEAN | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| reasoning | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gem_product_search_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:37
**扫描工具**: scan_metadata_v2.py
