# rpt_decofy_subscribe_ltv_metric_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_ltv_metric_view`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-15
**最后更新**: 2025-10-15

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| country_name | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| user_group | STRING | NULLABLE | - |
| ad_source | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_campaign_id | STRING | NULLABLE | - |
| product_id | STRING | NULLABLE | - |
| simple_product_id | STRING | NULLABLE | - |
| product_with_trial | INTEGER | NULLABLE | - |
| order_source | STRING | NULLABLE | - |
| new_user_cnt | INTEGER | NULLABLE | - |
| subscribe_7d_user_cnt | INTEGER | NULLABLE | - |
| subscribe_7d_subscription_cnt | INTEGER | NULLABLE | - |
| subscribe_7d_first_order_discount_amt | INTEGER | NULLABLE | - |
| subscribe_pay_14d_user_cnt | INTEGER | NULLABLE | - |
| subscribe_pay_14d_subscription_cnt | INTEGER | NULLABLE | - |
| predict_subscribe_7d_user_cnt | FLOAT | NULLABLE | - |
| subscription_LT | FLOAT | NULLABLE | - |
| subscription_paid_LT | FLOAT | NULLABLE | - |
| free_trial_paid_rate | FLOAT | NULLABLE | - |
| paid_LT | FLOAT | NULLABLE | - |
| product_price | INTEGER | NULLABLE | - |
| LTV_7d | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_ltv_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:04
**扫描工具**: scan_metadata_v2.py
