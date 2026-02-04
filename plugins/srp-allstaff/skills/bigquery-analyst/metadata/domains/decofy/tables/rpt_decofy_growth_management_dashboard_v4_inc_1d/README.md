# rpt_decofy_growth_management_dashboard_v4_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v4_inc_1d`
**层级**: RPT (报表层)
**业务域**: gem
**表类型**: TABLE
**行数**: 5,752 行
**大小**: 0.00 GB
**创建时间**: 2025-09-04
**最后更新**: 2026-01-30

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
| real_order_paid_amount_7d | FLOAT | NULLABLE | 7天内真实订单付费金额 |
| subscription_7d | INTEGER | NULLABLE | 7天开通的订阅数 |
| order_cnt_7d | INTEGER | NULLABLE | 7天内开通的订单数 |
| paid_order_cnt_7d | INTEGER | NULLABLE | 7天内开通的付费订单数 |
| subscribed_user_7d | INTEGER | NULLABLE | 7天内订阅用户数 |
| paid_user_7d | INTEGER | NULLABLE | 7天内付费用户数 |
| weekly_benefit_order_7d | INTEGER | NULLABLE | 7天归因周期内周费benefit订单数 |
| weekly_trail_order_7d | INTEGER | NULLABLE | 7天归因周期内周费trial订单数 |
| weekly_normal_order_7d | INTEGER | NULLABLE | 7天归因周期内周费normal订单数 |
| annual_benefit_order_7d | INTEGER | NULLABLE | 7天归因周期内年费benefit订单数 |
| annual_trail_order_7d | INTEGER | NULLABLE | 7天归因周期内年费trial订单数 |
| annual_normal_order_7d | INTEGER | NULLABLE | 7天归因周期内年费normal订单数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_growth_management_dashboard_v4_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:00:52
**扫描工具**: scan_metadata_v2.py
