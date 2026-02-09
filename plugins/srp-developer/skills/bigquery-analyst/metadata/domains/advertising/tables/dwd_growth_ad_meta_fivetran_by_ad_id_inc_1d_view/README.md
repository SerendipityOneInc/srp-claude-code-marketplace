# dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-08
**最后更新**: 2025-12-08

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| source | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_name | STRING | NULLABLE | - |
| account_id | STRING | NULLABLE | - |
| account_name | STRING | NULLABLE | - |
| campaign_id | STRING | NULLABLE | - |
| campaign_name | STRING | NULLABLE | - |
| ad_group_id | STRING | NULLABLE | - |
| ad_group_name | STRING | NULLABLE | - |
| ad_id | STRING | NULLABLE | - |
| ad_name | STRING | NULLABLE | - |
| ad_category | STRING | NULLABLE | - |
| country_code | STRING | NULLABLE | - |
| impression | INTEGER | NULLABLE | - |
| click | INTEGER | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| conversion | FLOAT | NULLABLE | - |
| _fivetran_id | STRING | NULLABLE | - |
| reach | INTEGER | NULLABLE | - |
| cost_per_inline_link_click | FLOAT | NULLABLE | - |
| cpc | FLOAT | NULLABLE | - |
| cpm | FLOAT | NULLABLE | - |
| ctr | FLOAT | NULLABLE | - |
| frequency | FLOAT | NULLABLE | - |
| inline_link_click_ctr | STRING | NULLABLE | - |
| geo_regions | STRING | NULLABLE | - |
| geo_cities | STRING | NULLABLE | - |
| geo_zips | STRING | NULLABLE | - |
| targeting_age_min | INTEGER | NULLABLE | - |
| targeting_age_max | INTEGER | NULLABLE | - |
| targeting_genders | STRING | NULLABLE | - |
| campaign_objective | STRING | NULLABLE | - |
| ad_set_optimization_goal | STRING | NULLABLE | - |
| ad_set_bid_strategy | STRING | NULLABLE | - |
| _fivetran_synced | TIMESTAMP | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.fivetran_facebook_ads_full.basic_ad_actions` (basic_ad_actions)
- `srpproduct-dc37e.fivetran_facebook_ads_full.account_history` (account_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.campaign_history` (campaign_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.ad_history` (ad_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.ad_set_history` (ad_set_history)
- `srpproduct-dc37e.fivetran_facebook_ads_full.basic_ad` (basic_ad)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:05
**扫描工具**: scan_metadata_v2.py
