# rpt_gem_user_dimension_metrics_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_user_dimension_metrics_inc_1d`
**层级**: RPT (报表层)
**业务域**: gem
**表类型**: TABLE
**行数**: 35,279 行
**大小**: 0.00 GB
**创建时间**: 2025-04-17
**最后更新**: 2025-04-21

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| last_platform | STRING | NULLABLE | 用户当日使用最多的平台 |
| last_app_version | STRING | NULLABLE | 用户当日使用最多的app版本号 |
| country | STRING | NULLABLE | 用户30日内最常使用所在国家 |
| last_login_type | STRING | NULLABLE | 是否登录用户 |
| user_type | STRING | NULLABLE | 是否注册用户 |
| total_user_cnt | INTEGER | NULLABLE | 总用户数 |
| new_user_cnt | INTEGER | NULLABLE | 新增用户数 |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |
| active_user_d7_cnt | INTEGER | NULLABLE | 周活跃用户数 |
| active_user_d30_cnt | INTEGER | NULLABLE | 月活跃用户数 |
| retention_users | FLOAT | NULLABLE | 前一日用户留存数 |
| yesterday_new_users | INTEGER | NULLABLE | 前一日新增用户数 |
| total_duration | FLOAT | NULLABLE | 总停留时长 |
| duration_0_05_percentile | FLOAT | NULLABLE | 停留时长的百分之五分位数 |
| duration_0_25_percentile | FLOAT | NULLABLE | 停留时长的百分之二十五分位数 |
| duration_0_50_percentile | FLOAT | NULLABLE | 停留时长的百分之五十分位数 |
| duration_0_75_percentile | FLOAT | NULLABLE | 停留时长的百分之七十五分位数 |
| duration_0_95_percentile | FLOAT | NULLABLE | 停留时长的百分之九十五分位数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gem_user_dimension_metrics_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:04:10
**扫描工具**: scan_metadata_v2.py
