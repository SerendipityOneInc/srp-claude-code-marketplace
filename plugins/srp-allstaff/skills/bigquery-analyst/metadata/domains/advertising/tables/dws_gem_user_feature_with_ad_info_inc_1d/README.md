# dws_gem_user_feature_with_ad_info_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_user_feature_with_ad_info_inc_1d`
**层级**: DWS (汇总层)
**业务域**: advertising
**表类型**: TABLE
**行数**: 529,848 行
**大小**: 0.37 GB
**创建时间**: 2025-09-24
**最后更新**: 2025-09-26

---

## 📊 表说明

Gensmo用户特征与广告信息关联宽表，包含用户行为特征和广告归因信息

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 数据日期 |
| device_id | STRING | NULLABLE | 设备ID，当前活跃设备 |
| first_device_id | STRING | NULLABLE | 首次登录设备ID |
| user_event_appsflyer_id | STRING | NULLABLE | 用户事件Appsflyer追踪ID |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型，如register、unregister、deregister |
| user_tenure_type | STRING | NULLABLE | 用户生命周期类型，如new、old |
| created_at | TIMESTAMP | NULLABLE | 用户创建时间 |
| last_access_at | DATE | NULLABLE | 用户上一次访问日期，用于分析用户活跃度和回归行为 |
| last_day_feature_geo_continent_name | STRING | NULLABLE | 大洲名称 |
| last_day_feature_geo_sub_continent_name | STRING | NULLABLE | 次大洲名称 |
| last_day_feature_geo_country_name | STRING | NULLABLE | 国家名称 |
| last_day_feature_geo_region_name | STRING | NULLABLE | 地区名称 |
| last_day_feature_geo_metro_name | STRING | NULLABLE | 都市区名称 |
| last_day_feature_geo_city_name | STRING | NULLABLE | 城市名称 |
| last_day_feature_access_at | TIMESTAMP | NULLABLE | 最近访问时间 |
| last_day_feature_login_type | STRING | NULLABLE | 最近登录类型 |
| last_day_feature_duration | FLOAT | NULLABLE | 最近活跃时长（秒） |
| last_day_feature_platform | STRING | NULLABLE | 最近访问平台类型 |
| last_day_feature_app_version | STRING | NULLABLE | 最近访问应用版本 |
| last_day_feature_action_types_with_count | RECORD | REPEATED | 最近一天内的行为类型及计数 |
| last_30_days_feature_geo_continent_name | STRING | NULLABLE | 大洲名称 |
| last_30_days_feature_geo_sub_continent_name | STRING | NULLABLE | 次大洲名称 |
| last_30_days_feature_geo_country_name | STRING | NULLABLE | 国家名称 |
| last_30_days_feature_geo_region_name | STRING | NULLABLE | 地区名称 |
| last_30_days_feature_geo_metro_name | STRING | NULLABLE | 都市区名称 |
| last_30_days_feature_geo_city_name | STRING | NULLABLE | 城市名称 |
| last_30_days_feature_action_types_with_count | RECORD | REPEATED | 最近30天内的行为类型及计数 |
| af_event_time | STRING | NULLABLE | AppsFlyer事件时间 |
| af_platform | STRING | NULLABLE | AppsFlyer平台 |
| af_event_name | STRING | NULLABLE | AppsFlyer事件名称 |
| app_name | STRING | NULLABLE | 应用名称 |
| source | STRING | NULLABLE | 广告来源 |
| channel | STRING | NULLABLE | 渠道 |
| campaign_name | STRING | NULLABLE | 广告系列名称 |
| campaign_id | STRING | NULLABLE | 广告系列ID |
| ad_group_name | STRING | NULLABLE | 广告组名称 |
| ad_group_id | STRING | NULLABLE | 广告组ID |
| ad_id | STRING | NULLABLE | 广告ID |
| ad_name | STRING | NULLABLE | 广告名称 |
| af_event_seq | INTEGER | NULLABLE | AppsFlyer事件序列号 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_user_feature_with_ad_info_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:18:01
**扫描工具**: scan_metadata_v2.py
