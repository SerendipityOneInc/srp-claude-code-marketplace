# dwd_favie_decofy_subscription_notification_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d`
**层级**: DWD (明细层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 38,392 行
**大小**: 0.01 GB
**创建时间**: 2025-09-05
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
| notification_uuid | STRING | NULLABLE | 订阅消息UUID |
| notification_type | STRING | NULLABLE | 订阅消息类型 |
| transaction_id | STRING | NULLABLE | 交易ID |
| original_transaction_id | STRING | NULLABLE | 原始交易ID |
| subscription_status | INTEGER | NULLABLE | 订阅状态 |
| subtype | STRING | NULLABLE | 订阅消息子类型 |
| created_at | TIMESTAMP | NULLABLE | 创建时间 |
| updated_at | TIMESTAMP | NULLABLE | 更新时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_decofy_subscription_notification_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:27
**扫描工具**: scan_metadata_v2.py
