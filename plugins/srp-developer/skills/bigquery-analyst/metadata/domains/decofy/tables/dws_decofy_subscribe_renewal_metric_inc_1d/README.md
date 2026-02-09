# dws_decofy_subscribe_renewal_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_renewal_metric_inc_1d`
**层级**: DWS (汇总层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-09-22
**最后更新**: 2025-09-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 日期，分区字段，格式YYYY-MM-DD |
| user_id | STRING | NULLABLE | 用户ID |
| appsflyer_id | STRING | NULLABLE | appsflyer_id |
| country_name | STRING | NULLABLE | 国家名称 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| user_group | STRING | NULLABLE | 用户组 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| product_id | STRING | NULLABLE | 订阅产品ID |
| simple_product_id | STRING | NULLABLE | 简化产品ID |
| is_first_order_paid | INTEGER | NULLABLE | 首单是否付费，1表示付费，0表示未付费 |
| order_source | STRING | NULLABLE | 订单来源 |
| first_order_due_cnt | INTEGER | NULLABLE | 首单到期订单数数 |
| first_order_renewal_cnt | INTEGER | NULLABLE | 首单续订订单数 |
| second_order_due_cnt | INTEGER | NULLABLE | 二单到期订单数 |
| second_order_renewal_cnt | INTEGER | NULLABLE | 二单续订订单数 |
| third_more_order_due_cnt | INTEGER | NULLABLE | 三单到期订单数 |
| third_more_order_renewal_cnt | INTEGER | NULLABLE | 三单续订订单数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_decofy_subscribe_renewal_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:24
**扫描工具**: scan_metadata_v2.py
