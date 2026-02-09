# dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

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
| country_code | STRING | NULLABLE | - |
| impression | INTEGER | NULLABLE | - |
| click | INTEGER | NULLABLE | - |
| cost | FLOAT | NULLABLE | - |
| conversion | FLOAT | NULLABLE | - |
| customer_id | INTEGER | NULLABLE | - |
| _fivetran_id | STRING | NULLABLE | - |
| campaign_base_campaign | STRING | NULLABLE | - |
| interactions | INTEGER | NULLABLE | - |
| interaction_event_types | STRING | NULLABLE | - |
| device | STRING | NULLABLE | - |
| active_view_impressions | INTEGER | NULLABLE | - |
| active_view_measurable_impressions | INTEGER | NULLABLE | - |
| cost_per_conversion | FLOAT | NULLABLE | - |
| active_view_measurability | FLOAT | NULLABLE | - |
| conversions_value | FLOAT | NULLABLE | - |
| geo_target_name | STRING | NULLABLE | - |
| geo_target_canonical_name | STRING | NULLABLE | - |
| geo_target_type | STRING | NULLABLE | - |
| geo_bid_modifier | FLOAT | NULLABLE | - |
| ad_network_type | STRING | NULLABLE | - |
| active_view_viewability | FLOAT | NULLABLE | - |
| view_through_conversions | INTEGER | NULLABLE | - |
| video_views | INTEGER | NULLABLE | - |
| active_view_measurable_cost_micros | INTEGER | NULLABLE | - |
| ad_group_base_ad_group | STRING | NULLABLE | - |
| _fivetran_synced | TIMESTAMP | NULLABLE | - |
| channel | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.google_yla_03.campaign_history` (campaign_history)
- `srpproduct-dc37e.google_yla_03.geo_target` (geo_target)
- `srpproduct-dc37e.google_ads_gensmo02ios.ad_history` (ad_history)
- `srpproduct-dc37e.google_ads_gensmo02ios.geo_target` (geo_target)
- `srpproduct-dc37e.google_ads_gensmo02ios.account_history` (account_history)
- `srpproduct-dc37e.google_ads_savyo.campaign_history` (campaign_history)
- `srpproduct-dc37e.google_inhouse_ads.ad_group_history` (ad_group_history)
- `srpproduct-dc37e.google_ads_yingliang.geo_target` (geo_target)
- `srpproduct-dc37e.google_ads_savyo.ad_group_history` (ad_group_history)
- `srpproduct-dc37e.appsflyer_google03.account_history` (account_history)
- `srpproduct-dc37e.google_ads_gensmo02ios.ad_group_history` (ad_group_history)
- `srpproduct-dc37e.google_inhouse_ads.campaign_criterion_history` (campaign_criterion_history)
- `srpproduct-dc37e.google_ads_yingliang.campaign_criterion_history` (campaign_criterion_history)
- `srpproduct-dc37e.google_inhouse_ads.ad_history` (ad_history)
- `srpproduct-dc37e.google_inhouse_ads.campaign_history` (campaign_history)
- `srpproduct-dc37e.google_inhouse_ads.geo_target` (geo_target)
- `srpproduct-dc37e.appsflyer_google03.campaign_criterion_history` (campaign_criterion_history)
- `srpproduct-dc37e.google_ads_yingliang.ad_history` (ad_history)
- `srpproduct-dc37e.google_ads_yingliang.account_history` (account_history)
- `srpproduct-dc37e.google_ads_savyo.account_history` (account_history)
- `srpproduct-dc37e.google_ads_gensmo02ios.campaign_history` (campaign_history)
- `srpproduct-dc37e.google_inhouse_ads.account_history` (account_history)
- `srpproduct-dc37e.appsflyer_google03.ad_history` (ad_history)
- `srpproduct-dc37e.google_ads_savyo.campaign_criterion_history` (campaign_criterion_history)
- `srpproduct-dc37e.google_ads_yingliang.campaign_history` (campaign_history)
- `srpproduct-dc37e.appsflyer_google03.ad_group_history` (ad_group_history)
- `srpproduct-dc37e.appsflyer_google03.geo_target` (geo_target)
- `srpproduct-dc37e.google_ads_savyo.geo_target` (geo_target)
- `srpproduct-dc37e.google_yla_03.ad_group_history` (ad_group_history)
- `srpproduct-dc37e.google_yla_03.campaign_criterion_history` (campaign_criterion_history)
- `srpproduct-dc37e.google_yla_03.account_history` (account_history)
- `srpproduct-dc37e.google_ads_savyo.ad_history` (ad_history)
- `srpproduct-dc37e.google_ads_yingliang.ad_group_history` (ad_group_history)
- `srpproduct-dc37e.google_ads_gensmo02ios.campaign_criterion_history` (campaign_criterion_history)
- `srpproduct-dc37e.google_yla_03.ad_history` (ad_history)
- `srpproduct-dc37e.appsflyer_google03.campaign_history` (campaign_history)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_growth_ad_google_fivetran_by_ad_id_inc_1d_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:00
**扫描工具**: scan_metadata_v2.py
