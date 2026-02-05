# rpt_gensmo_user_group_penetration_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 182,964,662 行
**大小**: 24.71 GB
**创建时间**: 2025-11-13
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| user_tenure_type | STRING | NULLABLE | 用户周期类型: New User/Old User |
| user_login_type | STRING | NULLABLE | 是否登录用户 |
| country_name | STRING | NULLABLE | 用户30日内最常使用所在国家 |
| platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| user_group | STRING | NULLABLE | 用户分组 |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| group_user_cnt | INTEGER | NULLABLE | 用户组用户数 |
| active_user_cnt | INTEGER | NULLABLE | 活跃用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:36
**扫描工具**: scan_metadata_v2.py
