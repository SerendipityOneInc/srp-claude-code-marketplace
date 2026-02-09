# rpt_gem_growth_ad_kol_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_growth_ad_kol_inc_1d_view`
**层级**: RPT (报表层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-09-17
**最后更新**: 2025-09-17

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| source | STRING | NULLABLE | - |
| ad_category | STRING | NULLABLE | - |
| attribution_method | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| is_inhouse | STRING | NULLABLE | - |
| account_id | STRING | NULLABLE | - |
| account_name | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| impression | INTEGER | NULLABLE | - |
| click | INTEGER | NULLABLE | - |
| conversion | FLOAT | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| install_cnt | INTEGER | NULLABLE | - |
| new_user_cnt | FLOAT | NULLABLE | - |
| d0_active_cnt | FLOAT | NULLABLE | - |
| d1_retention_cnt | FLOAT | NULLABLE | - |
| lt7_cnt | FLOAT | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gem_growth_ad_kol_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:03:51
**扫描工具**: scan_metadata_v2.py
