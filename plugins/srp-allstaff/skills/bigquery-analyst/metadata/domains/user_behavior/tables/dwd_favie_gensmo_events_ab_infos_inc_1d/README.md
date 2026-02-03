# dwd_favie_gensmo_events_ab_infos_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_ab_infos_inc_1d`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: TABLE
**行数**: 2,478,901,121 行
**大小**: 2173.44 GB
**创建时间**: 2025-05-08
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | - |
| session_id | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| device_id | STRING | NULLABLE | - |
| refer | STRING | NULLABLE | - |
| refer_pv_seq | INTEGER | NULLABLE | - |
| pre_refer | STRING | NULLABLE | - |
| cal_pre_refer | STRING | NULLABLE | - |
| cal_pre_refer_event | RECORD | NULLABLE | - |
| cal_next_refer | STRING | NULLABLE | - |
| cal_refer_last_event | RECORD | NULLABLE | - |
| ap_name | STRING | NULLABLE | - |
| user_pseudo_id | STRING | NULLABLE | - |
| user_login_type | STRING | NULLABLE | - |
| event_name | STRING | NULLABLE | - |
| event_method | STRING | NULLABLE | - |
| event_action_type | STRING | NULLABLE | - |
| event_items | RECORD | REPEATED | - |
| event_interval | FLOAT | NULLABLE | - |
| event_version | STRING | NULLABLE | - |
| event_source | STRING | NULLABLE | - |
| event_timestamp | TIMESTAMP | NULLABLE | - |
| event_uuid | STRING | NULLABLE | - |
| ab_router_id | INTEGER | NULLABLE | - |
| ab_router_name | STRING | NULLABLE | - |
| ab_project_name | STRING | NULLABLE | - |
| geo_continent_name | STRING | NULLABLE | - |
| geo_sub_continent_name | STRING | NULLABLE | - |
| geo_region_name | STRING | NULLABLE | - |
| geo_metro_name | STRING | NULLABLE | - |
| geo_country_name | STRING | NULLABLE | - |
| geo_city_name | STRING | NULLABLE | - |
| device_category | STRING | NULLABLE | - |
| device_mobile_brand_name | STRING | NULLABLE | - |
| device_mobile_model_name | STRING | NULLABLE | - |
| device_mobile_os_hardware_model | STRING | NULLABLE | - |
| device_operating_system | STRING | NULLABLE | - |
| device_operating_system_version | STRING | NULLABLE | - |
| device_vendor_id | STRING | NULLABLE | - |
| device_language | STRING | NULLABLE | - |
| device_is_limited_ad_tracking | STRING | NULLABLE | - |
| platform | STRING | NULLABLE | - |
| app_version | STRING | NULLABLE | - |
| web_version | STRING | NULLABLE | - |
| utm_source | STRING | NULLABLE | - |
| stream_id | STRING | NULLABLE | - |
| appsflyer_id | STRING | NULLABLE | - |
| home_request_seq | INTEGER | NULLABLE | - |
| home_request_first_event_name | STRING | NULLABLE | - |
| home_request_first_event_method | STRING | NULLABLE | - |
| home_request_first_event_action_type | STRING | NULLABLE | - |
| home_request_first_event_ap_name | STRING | NULLABLE | - |
| home_request_first_event_items | RECORD | REPEATED | - |
| app_version_seq | INTEGER | NULLABLE | - |
| web_version_seq | INTEGER | NULLABLE | - |
| event_version_seq | INTEGER | NULLABLE | - |
| refer_group | STRING | NULLABLE | 来源分组，用于对有效来源值进行分组归类 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_ab_infos_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:10:49
**扫描工具**: scan_metadata_v2.py
