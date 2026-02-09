# rpt_favie_product_detail_metric_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_metric_full_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-03-05
**最后更新**: 2025-03-05

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| site | STRING | NULLABLE | - |
| shop_site | STRING | NULLABLE | - |
| total_product_num | INTEGER | REQUIRED | - |
| total_product_category_success_num | INTEGER | REQUIRED | - |
| total_product_image_success_num | INTEGER | REQUIRED | - |
| total_product_review_success_num | INTEGER | REQUIRED | - |
| daily_new_product_num | INTEGER | REQUIRED | - |
| daily_new_product_category_success_num | INTEGER | REQUIRED | - |
| daily_new_product_image_success_num | INTEGER | REQUIRED | - |
| daily_new_product_review_success_num | INTEGER | REQUIRED | - |
| daily_update_product_num | INTEGER | REQUIRED | - |
| daily_spider_update_product_num | INTEGER | NULLABLE | - |
| latest_7days_update_product_num | INTEGER | REQUIRED | - |
| latest_30days_update_product_num | INTEGER | REQUIRED | - |
| invalid_price_num | INTEGER | REQUIRED | - |
| unexpected_price_num | INTEGER | REQUIRED | - |
| out_of_stock_num | INTEGER | REQUIRED | - |
| dt | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_product_detail_metric_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:13
**扫描工具**: scan_metadata_v2.py
