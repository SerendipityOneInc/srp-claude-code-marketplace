# dws_favie_gem_sku_top_search_cube_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`
**层级**: DWS (汇总层)
**业务域**: search
**表类型**: TABLE
**行数**: 7,500 行
**大小**: 0.00 GB
**创建时间**: 2025-10-09
**最后更新**: 2025-10-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_site | STRING | NULLABLE | - |
| product_shop_site | STRING | NULLABLE | - |
| user_type | STRING | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| user_tenure_type | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| product_sku_id | STRING | NULLABLE | - |
| product_cate_tag | STRING | NULLABLE | - |
| product_title | STRING | NULLABLE | - |
| product_link | STRING | NULLABLE | - |
| product_image_link | STRING | NULLABLE | - |
| product_price_raw | STRING | NULLABLE | - |
| product_gem_return_cnt | INTEGER | NULLABLE | - |
| product_gem_return_user_uniq_cnt | INTEGER | NULLABLE | - |
| product_moodboard_cnt | INTEGER | NULLABLE | - |
| product_moodboard_user_uniq_cnt | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_gem_sku_top_search_cube_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:51
**扫描工具**: scan_metadata_v2.py
