# rpt_gensmo_management_dashboard_retention_full_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_full_1d`
**层级**: RPT (报表层)
**业务域**: user_behavior
**表类型**: TABLE
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-06-05
**最后更新**: 2025-10-22

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 全量时间分区,分区字段 |
| event_dt | DATE | NULLABLE | 事件日期 |
| is_new_user | STRING | NULLABLE | 是否为新用户 (new/old) |
| ad_media_source | STRING | NULLABLE | 广告媒体来源 |
| user_country | STRING | NULLABLE | 用户所在国家 |
| last_platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| last_app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| user_type | STRING | NULLABLE | 用户类型 (unregister/register/deregister) |
| d0_active | INTEGER | NULLABLE | 基准日活跃用户数 |
| d1_retention | INTEGER | NULLABLE | 次日留存用户数 |
| d2_retention | INTEGER | NULLABLE | D+2日留存用户数 |
| d6_retention | INTEGER | NULLABLE | D+6日留存用户数 |
| LT_1_to_6 | INTEGER | NULLABLE | D+1到D+6日期间用户总留存天 |
| w1_retention | INTEGER | NULLABLE | 第一周（D+7到D+13）留存用户数 |
| d1_7_retention | INTEGER | NULLABLE | D+1到D+7日期间留存用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_management_dashboard_retention_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:03
**扫描工具**: scan_metadata_v2.py
