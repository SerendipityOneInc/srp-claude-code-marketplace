# dwd_favie_decofy_subscription_order_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d`
**层级**: DWD (明细层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 16,174 行
**大小**: 0.01 GB
**创建时间**: 2025-09-11
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| user_id | STRING | NULLABLE | 用户ID |
| appsflyer_id | STRING | NULLABLE | appsflyer ID |
| product_id | STRING | NULLABLE | 产品ID |
| simple_product_id | STRING | NULLABLE | 简化产品ID |
| product_price | INTEGER | NULLABLE | 产品价格（USD） |
| product_first_order_price | INTEGER | NULLABLE | 产品首单价格（USD） |
| product_currency | STRING | NULLABLE | 产品货币 |
| product_with_trial | INTEGER | NULLABLE | 是否包含试用期：1(包含), 0(不包含) |
| product_period | INTEGER | NULLABLE | 产品周期（天） |
| subscription_id | STRING | NULLABLE | 订阅ID，用于标识同一个订阅下的所有订单 |
| subscription_created_at | TIMESTAMP | NULLABLE | 订阅创建时间 |
| subscription_seq | INTEGER | NULLABLE | 订阅序号（按订阅创建时间，1为首次） |
| original_transaction_id | STRING | NULLABLE | 原始交易ID |
| order_id | STRING | NULLABLE | 订单ID，订单记录的唯一标识 |
| order_source | STRING | NULLABLE | 订单来源: iOS,Android |
| order_paid_amount | INTEGER | NULLABLE | 实际支付价格 |
| order_paid_currency | STRING | NULLABLE | 实际支付货币 |
| order_created_at | TIMESTAMP | NULLABLE | 交易创建时间 |
| order_updated_at | TIMESTAMP | NULLABLE | 交易更新时间 |
| order_expires_date | TIMESTAMP | NULLABLE | 交易到期时间 |
| order_deleted_at | TIMESTAMP | NULLABLE | 交易删除时间 |
| order_renewal_at | TIMESTAMP | NULLABLE | 续费时间 |
| order_category | STRING | NULLABLE | 订单一级分类：pay_order, trial_order, benefit_order, unknown_order |
| order_type | STRING | NULLABLE | 订单二级类型：trial, trial_to_paid, benefit, benefit_to_paid, paid, renewal, unknown |
| order_seq | INTEGER | NULLABLE | 订单序号（按时间倒序，1为最新） |
| order_subscription_seq | INTEGER | NULLABLE | 订单在订阅中的序号（按时间倒序，1为最新） |
| order_days_to_expire | INTEGER | NULLABLE | 距离到期天数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_order_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:29
**扫描工具**: scan_metadata_v2.py
