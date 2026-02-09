# rpt_gensmo_user_x_action_retention_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_action_retention_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 607,893,047 行
**大小**: 122.48 GB
**创建时间**: 2025-11-07
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| action_type | STRING | NULLABLE | 功能类型: e.g., try_on_trigger,try_on_complete etc. |
| country_name | STRING | NULLABLE | 用户30日内最常使用所在国家 |
| platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| user_login_type | STRING | NULLABLE | 是否登录用户 |
| user_tenure_segment | STRING | NULLABLE | 用户周期细分类型: New User(1 Day)/New User(2-7 Days)/New User(8-30 Days)/Old User |
| user_tenure_type | STRING | NULLABLE | 用户周期类型: New User/Old User |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| user_group | STRING | NULLABLE | 用户分组 |
| retention_type | STRING | NULLABLE | 留存类型:retention_d1,retention_d2,retention_d7,retention_d1_d7,retention_7d,retention_30d |
| active_user_cnt | INTEGER | NULLABLE | 当前周期活跃用户数 |
| retention_user_cnt | INTEGER | NULLABLE | 目标周期留存用户数 |
| group_type | STRING | NULLABLE | 数据分组类型 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_action_retention_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:49
**扫描工具**: scan_metadata_v2.py
