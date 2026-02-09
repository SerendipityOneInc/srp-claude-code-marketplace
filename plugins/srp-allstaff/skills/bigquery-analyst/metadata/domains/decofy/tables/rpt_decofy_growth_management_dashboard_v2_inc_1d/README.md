# rpt_decofy_growth_management_dashboard_v2_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v2_inc_1d`
**层级**: RPT (报表层)
**业务域**: gem
**表类型**: TABLE
**行数**: 15,094 行
**大小**: 0.01 GB
**创建时间**: 2025-08-14
**最后更新**: 2025-08-21

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
| subscription_7d_cnt | INTEGER | NULLABLE | 7天订阅转化数 |
| subscription_3d_cnt | INTEGER | NULLABLE | 3天订阅转化数 |
| subscription_1d_cnt | INTEGER | NULLABLE | 1天订阅转化数 |
| subscription_0d_cnt | INTEGER | NULLABLE | 当天订阅转化数 |
| paid_7d_cnt | INTEGER | NULLABLE | 7天付费转化数 |
| paid_3d_cnt | INTEGER | NULLABLE | 3天付费转化数 |
| paid_1d_cnt | INTEGER | NULLABLE | 1天付费转化数 |
| paid_0d_cnt | INTEGER | NULLABLE | 当天付费转化数 |
| trial_7d_cnt | INTEGER | NULLABLE | 7天试用转化数 |
| trial_3d_cnt | INTEGER | NULLABLE | 3天试用转化数 |
| trial_1d_cnt | INTEGER | NULLABLE | 1天试用转化数 |
| trial_0d_cnt | INTEGER | NULLABLE | 当天试用转化数 |
| total_order_paid_amount | FLOAT | NULLABLE | 总订单付费金额 |
| first_paid_weekly_9990_cnt | INTEGER | NULLABLE | 首次付费周订阅9.99数量 |
| first_paid_annual_39990_cnt | INTEGER | NULLABLE | 首次付费年订阅39.99数量 |
| first_paid_free_trial_cnt | INTEGER | NULLABLE | 首次付费免费试用数量 |
| second_paid_weekly_9990_cnt | INTEGER | NULLABLE | 二次付费周订阅9.99数量 |
| second_paid_annual_39990_cnt | INTEGER | NULLABLE | 二次付费年订阅39.99数量 |
| second_paid_free_trial_cnt | INTEGER | NULLABLE | 二次付费免费试用数量 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v2_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:00:48
**扫描工具**: scan_metadata_v2.py
