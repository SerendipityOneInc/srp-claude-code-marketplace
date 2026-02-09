# dws_decofy_subscribe_pay_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_pay_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 54,136 行
**大小**: 0.01 GB
**创建时间**: 2025-09-25
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| user_id | STRING | NULLABLE | 用户ID |
| country_name | STRING | NULLABLE | 国家或地区名称 |
| platform | STRING | NULLABLE | 用户平台，如 iOS、Android、Web |
| app_version | STRING | NULLABLE | 应用版本号 |
| user_group | STRING | NULLABLE | 用户分群标签 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| product_id | STRING | NULLABLE | 订阅产品ID |
| simple_product_id | STRING | NULLABLE | 简化产品ID |
| product_with_trial | INTEGER | NULLABLE | 首单是否使用免费试用，1表示使用，0表示未使用 |
| order_source | STRING | NULLABLE | 订单来源 |
| subscribe_7d_user_id | STRING | NULLABLE | 7天内有订阅的用户ID |
| subscribe_7d_subscription_id | STRING | NULLABLE | 7天内订阅的订阅ID |
| subscribe_7d_first_order_discount_amount | INTEGER | NULLABLE | 订阅首笔订单优惠金额 |
| subscribe_pay_14d_user_id | STRING | NULLABLE | 14天内有订阅且付费的用户ID |
| subscribe_pay_14d_subscription_id | STRING | NULLABLE | 7天内订阅且14内付费的订阅ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_pay_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:20
**扫描工具**: scan_metadata_v2.py
