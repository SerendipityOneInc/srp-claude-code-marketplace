# dws_decofy_membership_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_decofy_membership_full_1d`
**层级**: DWS (汇总层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 180,168 行
**大小**: 0.07 GB
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
| appsflyer_id | STRING | NULLABLE | Appsflyer ID |
| order_source | STRING | NULLABLE | 订单来源 |
| membership_tenure_type | STRING | NULLABLE | 会员生命周期: new,active,expiring,expired |
| first_subscribe_at | TIMESTAMP | NULLABLE | 会员创建时间 |
| first_subscribe_product_id | STRING | NULLABLE | 会员首次订阅产品ID |
| first_subscribe_simple_product_id | STRING | NULLABLE | 会员首次订阅简化产品ID |
| first_pay_at | TIMESTAMP | NULLABLE | 会员首次付费时间 |
| first_pay_subscribe_at | TIMESTAMP | NULLABLE | 会员首次付费订阅时间 |
| latest_subscribe_at | TIMESTAMP | NULLABLE | 会员最近一次订阅时间 |
| latest_subscribe_seq | INTEGER | NULLABLE | 会员最近一次订阅序号 |
| latest_order_product_id | STRING | NULLABLE | 会员近一次订单产品ID |
| latest_order_simple_product_id | STRING | NULLABLE | 会员最近一次订单简化产品ID |
| latest_order_expires_date | TIMESTAMP | NULLABLE | 会员到期时间 |
| latest_order_renewal_at | TIMESTAMP | NULLABLE | 会员续费时间 |
| latest_order_created_at | TIMESTAMP | NULLABLE | 会员最近一次订阅的订单创建时间 |
| latest_order_subscription_seq | INTEGER | NULLABLE | 会员最近一次订阅的订单序号 |
| latest_order_category | STRING | NULLABLE | 会员最近一次订阅的订单类别 |
| latest_order_type | STRING | NULLABLE | 会员最近一次订阅的订单类型 |
| latest_order_seq | INTEGER | NULLABLE | 会员最近一次订阅的订单序号 |
| total_order_cnt | INTEGER | NULLABLE | 会员累计订单数 |
| total_paid_order_cnt | INTEGER | NULLABLE | 会员累计付费订单数 |
| total_paid_order_usd_amount | INTEGER | NULLABLE | 会员所有订单的支付金额 |
| total_subscribe_cnt | INTEGER | NULLABLE | 会员累计订阅次数 |
| total_subscribe_product_cnt | INTEGER | NULLABLE | 会员累计订阅产品数 |
| subscribe_products | STRING | REPEATED | 会员累计订阅过的产品ID列表 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_decofy_membership_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:14
**扫描工具**: scan_metadata_v2.py
