# rpt_decofy_growth_management_dashboard_v3_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v3_inc_1d`
**层级**: RPT (报表层)
**业务域**: gem
**表类型**: TABLE
**行数**: 3,148 行
**大小**: 0.00 GB
**创建时间**: 2025-08-20
**最后更新**: 2025-09-04

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区字段 |
| source | STRING | NULLABLE | 来源 |
| platform | STRING | NULLABLE | 苹果/安卓 |
| app_name | STRING | NULLABLE | 应用名称 |
| account_id | STRING | NULLABLE | 账户ID |
| account_name | STRING | NULLABLE | 账户名称 |
| campaign_id | STRING | NULLABLE | Campaign ID |
| campaign_name | STRING | NULLABLE | Campaign名称 |
| ad_group_id | STRING | NULLABLE | Ad Group ID |
| ad_group_name | STRING | NULLABLE | Ad Group名称 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_name | STRING | NULLABLE | 广告名称 |
| country_code | STRING | NULLABLE | 国家代码 |
| channel | STRING | NULLABLE | 渠道 |
| impression | INTEGER | NULLABLE | 曝光数 |
| click | INTEGER | NULLABLE | 点击数 |
| conversion | FLOAT | NULLABLE | 转化数 |
| cost | FLOAT | NULLABLE | 成本 |
| install_cnt | INTEGER | NULLABLE | 安装数 |
| user_cnt | INTEGER | NULLABLE | 用户数 |
| real_order_paid_amount_7d | FLOAT | NULLABLE | 7天真实订单付费金额 |
| is_paid_order_7d_1_1 | INTEGER | NULLABLE | 7天付费订单1-1 |
| is_trial_order_7d_1_1 | INTEGER | NULLABLE | 7天试用订单1-1 |
| is_benefit_order_7d_1_1 | INTEGER | NULLABLE | 7天福利订单1-1 |
| is_order_weekly_9990_7d_1_1 | INTEGER | NULLABLE | 7天周订阅9990订单1-1 |
| is_order_annual_39990_7d_1_1 | INTEGER | NULLABLE | 7天年订阅39990订单1-1 |
| is_order_free_trial_7d_1_1 | INTEGER | NULLABLE | 7天免费试用订单1-1 |
| is_renewal_order_1_2 | INTEGER | NULLABLE | 续费订单1-2 |
| is_trial_to_paid_order_1_2 | INTEGER | NULLABLE | 试用转付费订单1-2 |
| is_benefit_to_paid_order_1_2 | INTEGER | NULLABLE | 福利转付费订单1-2 |
| is_paid_order_1_2 | INTEGER | NULLABLE | 付费订单1-2 |
| is_paid_order_weekly_9990_paid_1_2 | INTEGER | NULLABLE | 付费周订阅9990订单1-2 |
| is_paid_order_annual_39990_paid_1_2 | INTEGER | NULLABLE | 付费年订阅39990订单1-2 |
| is_paid_order_free_trial_paid_1_2 | INTEGER | NULLABLE | 付费免费试用订单1-2 |
| is_paid_order_weekly_9990_paid_renewal_order_1_2 | INTEGER | NULLABLE | 付费周订阅9990续费订单1-2 |
| is_paid_order_annual_39990_paid_trial_to_paid_order_1_2 | INTEGER | NULLABLE | 付费年订阅39990试用转付费订单1-2 |
| is_paid_order_free_trial_paid_benefit_to_paid_order_1_2 | INTEGER | NULLABLE | 付费免费试用福利转付费订单1-2 |
| is_renewal_order_1_3 | INTEGER | NULLABLE | 续费订单1-3 |
| is_trial_to_paid_order_1_3 | INTEGER | NULLABLE | 试用转付费订单1-3 |
| is_benefit_to_paid_order_1_3 | INTEGER | NULLABLE | 福利转付费订单1-3 |
| is_paid_order_1_3 | INTEGER | NULLABLE | 付费订单1-3 |
| is_paid_order_weekly_9990_paid_1_3 | INTEGER | NULLABLE | 付费周订阅9990订单1-3 |
| is_paid_order_annual_39990_paid_1_3 | INTEGER | NULLABLE | 付费年订阅39990订单1-3 |
| is_paid_order_free_trial_paid_1_3 | INTEGER | NULLABLE | 付费免费试用订单1-3 |
| is_paid_order_weekly_9990_paid_renewal_order_1_3 | INTEGER | NULLABLE | 付费周订阅9990续费订单1-3 |
| is_paid_order_annual_39990_paid_trial_to_paid_order_1_3 | INTEGER | NULLABLE | 付费年订阅39990试用转付费订单1-3 |
| is_paid_order_free_trial_paid_benefit_to_paid_order_1_3 | INTEGER | NULLABLE | 付费免费试用福利转付费订单1-3 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v3_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:00:51
**扫描工具**: scan_metadata_v2.py
