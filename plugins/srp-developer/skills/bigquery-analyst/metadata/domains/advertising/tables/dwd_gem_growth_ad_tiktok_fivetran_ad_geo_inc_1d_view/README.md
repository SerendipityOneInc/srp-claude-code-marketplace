# dwd_gem_growth_ad_tiktok_fivetran_ad_geo_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gem_growth_ad_tiktok_fivetran_ad_geo_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-07-07
**最后更新**: 2025-07-07

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| ad_id | STRING | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| dt | DATE | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| _fivetran_synced | TIMESTAMP | NULLABLE | - |
| conversion | INTEGER | NULLABLE | - |
| spend | FLOAT | NULLABLE | - |
| clicks | INTEGER | NULLABLE | - |
| cost_per_landing_page_view | FLOAT | NULLABLE | - |
| likes | INTEGER | NULLABLE | - |
| profile_visits_rate | FLOAT | NULLABLE | - |
| cost_per_result | FLOAT | NULLABLE | - |
| result_rate | FLOAT | NULLABLE | - |
| follows | INTEGER | NULLABLE | - |
| total_landing_page_view | INTEGER | NULLABLE | - |
| result | INTEGER | NULLABLE | - |
| real_time_conversion | INTEGER | NULLABLE | - |
| aeo_type | STRING | NULLABLE | - |
| real_time_result | INTEGER | NULLABLE | - |
| comments | INTEGER | NULLABLE | - |
| cost_per_conversion | FLOAT | NULLABLE | - |
| cpc | FLOAT | NULLABLE | - |
| clicks_on_music_disc | INTEGER | NULLABLE | - |
| real_time_cost_per_conversion | FLOAT | NULLABLE | - |
| landing_page_view_rate | FLOAT | NULLABLE | - |
| real_time_conversion_rate | FLOAT | NULLABLE | - |
| ctr | FLOAT | NULLABLE | - |
| shares | INTEGER | NULLABLE | - |
| profile_visits | INTEGER | NULLABLE | - |
| real_time_result_rate | FLOAT | NULLABLE | - |
| impressions | INTEGER | NULLABLE | - |
| real_time_cost_per_result | FLOAT | NULLABLE | - |
| cpm | FLOAT | NULLABLE | - |
| conversion_rate | FLOAT | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.fivetran_tiktok_ads.ad_country_report` (ad_country_report)
- `srpproduct-dc37e.fivetran_tiktok_ads.ad_history` (ad_history)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gem_growth_ad_tiktok_fivetran_ad_geo_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:12:34
**扫描工具**: scan_metadata_v2.py
