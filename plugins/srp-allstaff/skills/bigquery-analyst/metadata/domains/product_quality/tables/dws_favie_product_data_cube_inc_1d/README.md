# dws_favie_product_data_cube_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_product_data_cube_inc_1d`
**层级**: DWS (汇总层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 4,287,827 行
**大小**: 0.79 GB
**创建时间**: 2026-01-04
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| product_site | STRING | NULLABLE | - |
| product_shop_site | STRING | NULLABLE | - |
| site_domain | STRING | NULLABLE | - |
| site_top_domain | STRING | NULLABLE | - |
| site_tier | STRING | NULLABLE | - |
| site_type | STRING | NULLABLE | - |
| site_rank | STRING | NULLABLE | - |
| site_categories | STRING | NULLABLE | - |
| site_parser_type | STRING | NULLABLE | - |
| site_country_region | STRING | NULLABLE | - |
| sku_uniq_cnt | INTEGER | NULLABLE | - |
| spu_uniq_cnt | INTEGER | NULLABLE | - |
| inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| inc_spu_uniq_cnt | INTEGER | NULLABLE | - |
| update_sku_uniq_cnt | INTEGER | NULLABLE | - |
| update_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d3_update_and_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d3_update_and_inc_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d7_update_and_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d7_update_and_inc_spu_uniq_cnt | INTEGER | NULLABLE | - |
| d28_update_and_inc_sku_uniq_cnt | INTEGER | NULLABLE | - |
| d28_update_and_inc_spu_uniq_cnt | INTEGER | NULLABLE | - |
| invalid_price_sku_uniq_cnt | INTEGER | NULLABLE | - |
| unexpected_price_sku_uniq_cnt | INTEGER | NULLABLE | - |
| out_of_stock_sku_uniq_cnt | INTEGER | NULLABLE | - |
| dt | DATE | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_product_data_cube_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:25
**扫描工具**: scan_metadata_v2.py
