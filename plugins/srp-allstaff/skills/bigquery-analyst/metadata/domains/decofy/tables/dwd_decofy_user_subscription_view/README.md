# dwd_decofy_user_subscription_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_decofy_user_subscription_view`
**层级**: DWD (明细层)
**业务域**: subscription
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-08-19
**最后更新**: 2025-08-19

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| intension_source | STRING | NULLABLE | - |
| intension_timestamp | TIMESTAMP | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| product_id | STRING | NULLABLE | - |
| simple_product_id | STRING | NULLABLE | - |
| product_price | INTEGER | NULLABLE | - |
| product_currency | STRING | NULLABLE | - |
| product_with_trial | INTEGER | NULLABLE | - |
| subscription_id | STRING | NULLABLE | - |
| subscription_created_at | TIMESTAMP | NULLABLE | - |
| subscription_seq | INTEGER | NULLABLE | - |
| order_id | STRING | NULLABLE | - |
| order_source | STRING | NULLABLE | - |
| order_paid_amount | INTEGER | NULLABLE | - |
| order_paid_currency | STRING | NULLABLE | - |
| order_created_at | TIMESTAMP | NULLABLE | - |
| order_updated_at | TIMESTAMP | NULLABLE | - |
| order_expires_date | TIMESTAMP | NULLABLE | - |
| order_deleted_at | TIMESTAMP | NULLABLE | - |
| order_renewal_at | TIMESTAMP | NULLABLE | - |
| order_category | STRING | NULLABLE | - |
| order_type | STRING | NULLABLE | - |
| order_seq | INTEGER | NULLABLE | - |
| order_subscription_seq | INTEGER | NULLABLE | - |
| order_category_seq | INTEGER | NULLABLE | - |
| order_days_to_expire | INTEGER | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_decofy_user_subscription_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:20
**扫描工具**: scan_metadata_v2.py
