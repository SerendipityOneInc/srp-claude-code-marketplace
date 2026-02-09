# dwd_favie_gensmo_events_ab_infos_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_ab_infos_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-07-08
**最后更新**: 2025-07-08

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dim_gem_user_ab_config_view` (dim_gem_user_ab_config_view)

---

## 💻 函数定义

```sql
WITH dwd_favie_gensmo_events_with_ab_router_id as (
            SELECT 
                  dt,
                  session_id,
                  user_id,
                  device_id,
                  refer,
                  refer_pv_seq,
                  pre_refer,
                  cal_pre_refer,
                  cal_pre_refer_event,
                  cal_next_refer,
                  cal_refer_last_event,
                  ap_name,
                  
                  user_pseudo_id,
                  user_login_type,

                  event_name,
                  event_method,
                  event_action_type,
                  event_items,
                  event_interval,
                  event_version,
                  event_source, 
                  event_timestamp,
                  event_uuid,

                  safe_cast(ab_router_id as int64) as ab_router_id,

                  geo_continent_name,
                  geo_sub_continent_name,
                  geo_region_name,
                  geo_metro_name,
                  geo_country_name,
                  geo_city_name,

                  device_category,
                  device_mobile_brand_name,
                  device_mobile_model_name,
                  device_mobile_os_hardware_model,
                  device_operating_system,
                  device_operating_system_version,
                  device_vendor_id,
                  device_language,
                  device_is_limited_ad_tracking,

                  platform,
                  app_version,
                  web_version,
                  utm_source,
                  stream_id,       
                  appsflyer_id,

                  home_request_seq,
                  home_request_first_event_name,
                  home_request_first_event_method,
                  home_request_first_event_action_type,
                  home_request_first_event_ap_name,
                  home_request_first_event_items,

                  app_version_seq,
                  web_version_seq,
                  event_version_seq,
                  refer_group
            FROM `favie_dw.dwd_favie_gensmo_events_inc_1d`
                  left outer join unnest(event_ab_infos) as ab_router_id
            WHERE dt = dt_param
      ),

      ab_config_info as (
            SELECT  project   AS ab_project_name
                  ,tags
                  ,enabled
                  ,unique_id AS ab_router_id
                  ,updated_at
                  ,router    AS ab_router_name
                  ,created_at
                  ,weight
                  ,description
            FROM `srpproduct-dc37e.favie_dw.dim_gem_user_ab_config_view`
            where unique_id is not null
      ),

      dwd_favie_gensmo_events_with_ab_info as (
            SELECT 
                  t1.dt,
                  t1.session_id,
                  t1.user_id,
                  t1.device_id,
                  t1.refer,
                  t1.refer_pv_seq,
                  t1.pre_refer,
                  t1.cal_pre_refer,
                  t1.cal_pre_refer_event,
                  t1.cal_next_refer,
                  t1.cal_refer_last_event,
                  t1.ap_name,
                  
                  t1.user_pseudo_id,
                  t1.user_login_type,

                  t1.event_name,
                  t1.event_method,
                  t1.event_action_type,
                  t1.event_items,
                  t1.event_interval,
                  t1.event_version,
                  t1.event_source, 
                  t1.event_timestamp,
                  t1.event_uuid,

                  t1.ab_router_id,
                  t2.ab_project_name,
                  t2.ab_router_name,

                  t1.geo_continent_name,
                  t1.geo_sub_continent_name,
                  t1.geo_region_name,
                  t1.geo_metro_name,
                  t1.geo_country_name,
                  t1.geo_city_name,

                  t1.device_category,
                  t1.device_mobile_brand_name,
                  t1.device_mobile_model_name,
                  t1.device_mobile_os_hardware_model,
                  t1.device_operating_system,
                  t1.device_operating_system_version,
                  t1.device_vendor_id,
                  t1.device_language,
                  t1.device_is_limited_ad_tracking,

                  t1.platform,
                  t1.app_version,
                  t1.web_version,
                  t1.utm_source,
                  t1.stream_id,       
                  t1.appsflyer_id,

                  t1.home_request_seq,
                  t1.home_request_first_event_name,
                  t1.home_request_first_event_method,
                  t1.home_request_first_event_action_type,
                  t1.home_request_first_event_ap_name,
                  t1.home_request_first_event_items,

                  t1.app_version_seq,
                  t1.web_version_seq,
                  t1.event_version_seq,
                  t1.refer_group
            FROM dwd_favie_gensmo_events_with_ab_router_id t1 
            LEFT OUTER JOIN ab_config_info t2
            on t1.ab_router_id = t2.ab_router_id
      )

      select 
            dt,
            session_id,
            user_id,
            device_id,
            refer,
            refer_pv_seq,
            pre_refer,
            cal_pre_refer,
            cal_pre_refer_event,
            cal_next_refer,
            cal_refer_last_event,
            ap_name,
            
            user_pseudo_id,
            user_login_type,

            event_name,
            event_method,
            event_action_type,
            event_items,
            event_interval,
            event_version,
            event_source, 
            event_timestamp,
            event_uuid,

            ab_router_id,
            ab_project_name,
            ab_router_name,

            geo_continent_name,
            geo_sub_continent_name,
            geo_region_name,
            geo_metro_name,
            geo_country_name,
            geo_city_name,

            device_category,
            device_mobile_brand_name,
            device_mobile_model_name,
            device_mobile_os_hardware_model,
            device_operating_system,
            device_operating_system_version,
            device_vendor_id,
            device_language,
            device_is_limited_ad_tracking,

            platform,
            app_version,
            web_version,
            utm_source,
            stream_id,       
            appsflyer_id,
            
            home_request_seq, 
            home_request_first_event_name, 
            home_request_first_event_method, 
            home_request_first_event_action_type, 
            home_request_first_event_ap_name, 
            home_request_first_event_items, 

            app_version_seq, 
            web_version_seq, 
            event_version_seq,
            refer_group
      from dwd_favie_gensmo_events_with_ab_info
```

---

**文档生成**: 2026-01-30 13:40:58
**扫描工具**: scan_functions.py
