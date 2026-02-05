# rpt_decofy_subscription_membership_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: points_membership
**表类型**: TABLE
**行数**: 5,317 行
**大小**: 0.00 GB
**创建时间**: 2025-09-11
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 统计日期 |
| country_name | STRING | NULLABLE | 用户国家 |
| platform | STRING | NULLABLE | 平台 |
| user_group | STRING | NULLABLE | 用户分组 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| order_source | STRING | NULLABLE | 订单来源 |
| membership_tenure_type | STRING | NULLABLE | 会员生命周期类型：new,active,expiring,expired |
| subscription_active_user_cnt | INTEGER | NULLABLE | 活跃订阅用户数 |
| subscription_renewal_user_cnt | INTEGER | NULLABLE | 续订用户数 |
| subscription_should_expires_user_cnt | INTEGER | NULLABLE | 应到期订阅用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_decofy_subscription_membership_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:01:17
**扫描工具**: scan_metadata_v2.py
