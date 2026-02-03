# rpt_decofy_subscription_order_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_order_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 7,923 行
**大小**: 0.00 GB
**创建时间**: 2025-09-10
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| country_name | STRING | NULLABLE | 用户30日内最常使用所在国家 |
| platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| user_group | STRING | NULLABLE | 用户分组 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| order_source | STRING | NULLABLE | 订单来源 |
| product_id | STRING | NULLABLE | 产品ID |
| simple_product_id | STRING | NULLABLE | 产品简化ID |
| subscription_type | STRING | NULLABLE | 订阅类型：first_subscription, resubscription |
| order_category | STRING | NULLABLE | 订单一级分类：pay_order, trial_order, benefit_order, unknown_order |
| order_type | STRING | NULLABLE | 订单二级分类：trial, trial_to_paid, benefit, benefit_to_paid, paid, renewal, unknown |
| created_order_cnt | INTEGER | NULLABLE | 当天创建订单数 |
| created_order_amount | INTEGER | NULLABLE | 当天创建订单收入 |
| due_order_cnt | INTEGER | NULLABLE | 当天到期订单数 |
| due_order_amount | INTEGER | NULLABLE | 当天到期订单收入 |
| renewed_order_cnt | INTEGER | NULLABLE | 当天续订订单数 |
| renewed_order_amount | INTEGER | NULLABLE | 当天续订订单收入 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_order_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:20
**扫描工具**: scan_metadata_v2.py
