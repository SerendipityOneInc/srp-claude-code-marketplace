# dws_gem_growth_ads_insights_region_full_view

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_growth_ads_insights_region_full_view`
**层级**: DWS (汇总层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-03-25
**最后更新**: 2025-03-25

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| platform | STRING | NULLABLE | - |
| cost_date | DATE | NULLABLE | - |
| country | STRING | NULLABLE | - |
| region | STRING | NULLABLE | - |
| impressions | INTEGER | NULLABLE | - |
| clicks | INTEGER | NULLABLE | - |
| spend | FLOAT | NULLABLE | - |
| installs | FLOAT | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_05.ads_insights_region` (ads_insights_region)
- `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_06.ads_insights_region` (ads_insights_region)
- `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_04.ads_insights_region` (ads_insights_region)
- `srpproduct-dc37e.facebook_ads_gensmow2agensmo_yla_dt_01.ads_insights_region` (ads_insights_region)
- `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_02.ads_insights_region` (ads_insights_region)
- `srpproduct-dc37e.facebook_ads_gensmow2agensmo_yla_dt_03.ads_insights_region` (ads_insights_region)
- `srpproduct-dc37e.facebook_ads_gensmo_appgensmo_yla_dt_07.ads_insights_region` (ads_insights_region)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_growth_ads_insights_region_full_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:42
**扫描工具**: scan_metadata_v2.py
