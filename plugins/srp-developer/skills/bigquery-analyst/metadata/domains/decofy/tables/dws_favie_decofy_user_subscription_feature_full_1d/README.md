# dws_favie_decofy_user_subscription_feature_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_subscription_feature_full_1d`
**层级**: DWS (汇总层)
**业务域**: subscription
**表类型**: TABLE
**行数**: 37,458 行
**大小**: 0.01 GB
**创建时间**: 2025-08-12
**最后更新**: 2025-08-12

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| user_id | STRING | NULLABLE | 用户ID |
| country_name | STRING | NULLABLE | 国家名称 |
| platform | STRING | NULLABLE | 平台 |
| app_version | STRING | NULLABLE | 应用版本 |
| appsflyer_id | STRING | NULLABLE | 广告平台用户ID |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| created_at | DATETIME | NULLABLE | 用户创建时间 |
| first_subscription_time | DATETIME | NULLABLE | 第一次订阅时间 |
| latest_subscription_time | DATETIME | NULLABLE | 最近一次订阅时间 |
| total_subscription_count | INTEGER | NULLABLE | 总订阅次数 |
| first_paid_time | DATETIME | NULLABLE | 第一次付费时间 |
| latest_paid_time | DATETIME | NULLABLE | 最近一次付费时间 |
| latest_paid_amount | INTEGER | NULLABLE | 最近一次付费金额 |
| latest_paid_currency | STRING | NULLABLE | 最近一次付费货币 |
| total_paid_count | INTEGER | NULLABLE | 总付费次数 |
| total_paid_amount | INTEGER | NULLABLE | 总付费金额 |
| total_paid_currency | STRING | NULLABLE | 总付费货币 |
| today_is_expires | INTEGER | NULLABLE | 今天是否到期 |
| current_paid_package | STRING | NULLABLE | 当前付费套餐 |
| current_paid_expires_time | DATETIME | NULLABLE | 当前付费到期时间 |
| current_package_price | INTEGER | NULLABLE | 当前套餐价格 |
| current_package_currency | STRING | NULLABLE | 当前套餐货币 |
| first_trial_time | DATETIME | NULLABLE | 第一次免费试用时间 |
| latest_trial_time | DATETIME | NULLABLE | 最近一次免费试用时间 |
| total_trial_count | INTEGER | NULLABLE | 总试用次数 |
| current_trial_expires_time | DATETIME | NULLABLE | 当前试用到期时间 |
| first_deleted_time | DATETIME | NULLABLE | 第一次删除订阅时间 |
| latest_deleted_time | DATETIME | NULLABLE | 最近一次删除订阅时间 |
| total_deleted_count | INTEGER | NULLABLE | 总订阅删除次数 |
| subscription_status | STRING | NULLABLE | 订阅状态：active_paid(活跃付费), active_trial(活跃试用), expired_paid(过期付费), trial_only(仅试用), no_subscription(无订阅) |
| days_to_expire | INTEGER | NULLABLE | 距离到期天数，对活跃付费或活跃试用用户有效 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_subscription_feature_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:16:38
**扫描工具**: scan_metadata_v2.py
