# rpt_gem_growth_management_dashboard_v4_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d`
**层级**: RPT (报表层)
**业务域**: gem
**表类型**: TABLE
**行数**: 110,242 行
**大小**: 0.04 GB
**创建时间**: 2025-08-28
**最后更新**: 2025-12-09

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
| ad_category | STRING | NULLABLE | 广告类别 |
| country_code | STRING | NULLABLE | 国家代码 |
| channel | STRING | NULLABLE | 渠道 |
| attribution_method | STRING | NULLABLE | 归因方式 |
| impression | INTEGER | NULLABLE | 曝光数 |
| click | INTEGER | NULLABLE | 点击数 |
| conversion | FLOAT | NULLABLE | 转化数 |
| cost | FLOAT | NULLABLE | 成本 |
| install_cnt | INTEGER | NULLABLE | 安装数 |
| new_user_cnt | FLOAT | NULLABLE | 新用户数 |
| d0_active_cnt | FLOAT | NULLABLE | D0活跃数 |
| d1_retention_cnt | FLOAT | NULLABLE | D1留存数 |
| lt7_cnt | FLOAT | NULLABLE | 近7天活跃天数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:57
**扫描工具**: scan_metadata_v2.py
