# rpt_gensmo_user_ltn_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_ltn_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 4,923,703 行
**大小**: 0.88 GB
**创建时间**: 2025-11-07
**最后更新**: 2026-01-30

---

## 📊 表说明

Gensmo用户生命周期（lifetime）相关指标宽表，统计不同生命周期、分组下的活跃天数、活跃用户数等核心指标

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| country_name | STRING | NULLABLE | 用户所属国家名称 |
| platform | STRING | NULLABLE | 平台类型，如iOS、Android等 |
| app_version | STRING | NULLABLE | 应用版本号 |
| user_login_type | STRING | NULLABLE | 用户登录类型：login,guest |
| user_tenure_segment | STRING | NULLABLE | 用户周期细分类型: New User(1 Day)/New User(2-7 Days)/New User(8-30 Days)/Old User |
| user_tenure_type | STRING | NULLABLE | 用户周期类型: New User/Old User |
| ad_source | STRING | NULLABLE | 广告来源 |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_campaign_id | STRING | NULLABLE | 广告活动ID |
| user_group | STRING | NULLABLE | 用户分组分类 |
| lifetime_days | INTEGER | NULLABLE | 用户生命周期天数 |
| active_days_cnt | INTEGER | NULLABLE | 用户活跃天数 |
| active_user_cnt | INTEGER | NULLABLE | 活跃用户数 |
| group_type | STRING | NULLABLE | 数据分组类型 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_ltn_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:40
**扫描工具**: scan_metadata_v2.py
