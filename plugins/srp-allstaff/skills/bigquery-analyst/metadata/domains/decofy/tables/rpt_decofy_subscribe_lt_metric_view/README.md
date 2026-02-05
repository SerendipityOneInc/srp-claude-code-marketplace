# rpt_decofy_subscribe_lt_metric_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_lt_metric_view`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-10-13
**最后更新**: 2025-10-13

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| product_id | STRING | NULLABLE | - |
| simple_product_id | STRING | NULLABLE | - |
| product_with_trial | INTEGER | NULLABLE | - |
| order_source | STRING | NULLABLE | - |
| first_order_due_30d_cnt | INTEGER | NULLABLE | - |
| first_order_renewal_30d_cnt | INTEGER | NULLABLE | - |
| first_order_due_60d_cnt | INTEGER | NULLABLE | - |
| first_order_renewal_60d_cnt | INTEGER | NULLABLE | - |
| default_first_order_renewal_rate | FLOAT | NULLABLE | - |
| first_order_renewal_rate | FLOAT | NULLABLE | - |
| second_order_due_30d_cnt | INTEGER | NULLABLE | - |
| second_order_renewal_30d_cnt | INTEGER | NULLABLE | - |
| second_order_due_60d_cnt | INTEGER | NULLABLE | - |
| second_order_renewal_60d_cnt | INTEGER | NULLABLE | - |
| default_second_order_renewal_rate | FLOAT | NULLABLE | - |
| second_order_renewal_rate | FLOAT | NULLABLE | - |
| third_more_order_due_30d_cnt | INTEGER | NULLABLE | - |
| third_more_order_renewal_30d_cnt | INTEGER | NULLABLE | - |
| third_more_order_due_60d_cnt | INTEGER | NULLABLE | - |
| third_more_order_renewal_60d_cnt | INTEGER | NULLABLE | - |
| default_third_more_order_renewal_rate | FLOAT | NULLABLE | - |
| third_more_order_renewal_rate | FLOAT | NULLABLE | - |
| third_more_order_renewal_rate_fix | FLOAT | NULLABLE | - |
| subscription_LT | FLOAT | NULLABLE | - |
| subscription_paid_LT | FLOAT | NULLABLE | - |
| free_trial_paid_rate | FLOAT | NULLABLE | - |
| paid_LT | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_lt_metric_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:02
**扫描工具**: scan_metadata_v2.py
