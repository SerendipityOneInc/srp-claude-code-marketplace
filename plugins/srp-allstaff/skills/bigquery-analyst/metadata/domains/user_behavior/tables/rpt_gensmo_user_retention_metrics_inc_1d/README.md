# rpt_gensmo_user_retention_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 3,096,133 行
**大小**: 0.45 GB
**创建时间**: 2025-06-16
**最后更新**: 2025-10-21

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
| user_login_type | STRING | NULLABLE | 是否登录用户 |
| user_tenure_type | STRING | NULLABLE | 用户使用时长类型，分为新用户和老用户 |
| user_group | STRING | NULLABLE | 用户分组 |
| retention_user_d1_cnt | INTEGER | NULLABLE | 次日留存用户数 |
| active_user_cnt | FLOAT | NULLABLE | 当日活跃用户数 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| ad_id | STRING | NULLABLE | 广告ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:41
**扫描工具**: scan_metadata_v2.py
