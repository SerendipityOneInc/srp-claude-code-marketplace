# dwd_favie_gensmo_events_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-07-25
**最后更新**: 2025-07-25

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
WITH gensmo_events_data AS (
      SELECT 
            CAST(
                  (SELECT value.int_value 
                  FROM UNNEST(event_params) 
                  WHERE key = 'ga_session_id') AS STRING
            ) AS session_id,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'gensmo_user_id') AS user_id,    

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'gensmo_active_id') AS device_id,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'appsflyer_id') AS appsflyer_id,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'refer') AS refer,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'pre_refer') AS pre_refer,   

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'item_list_name') AS ap_name,

            user_pseudo_id,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'gensmo_user_type') AS user_login_type,     

            event_name,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'method') AS event_method,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'action_type') AS event_action_type,

            JSON_VALUE_ARRAY((SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'ab_info')) AS event_ab_infos,

            ARRAY(
                  SELECT AS STRUCT 
                        IF(item_id="(not set)",cast(null as string) ,item_id) as item_id, 
                        IF(item_name="(not set)",cast(null as string),item_name) as item_name, 
                        IF(item_category="(not set)",cast(null as string),item_category) as item_type,
                        IF(item_list_index="(not set)",cast(null as int64),safe_cast(item_list_index as int64)) as item_index
                  FROM UNNEST(items)
                  WHERE coalesce(item_id,item_name,item_category,item_list_index,"(not set)") != "(not set)"
            ) AS event_items,

            -- TIMESTAMP_MICROS(
            cast ((SELECT value.string_value 
                  FROM UNNEST(event_params) 
                  WHERE key = 'gensmo_timestamp') as int64)
            AS event_timestamp_gensmo,

            TIMESTAMP_MICROS(cast(event_timestamp as int64)) as event_timestamp_ga,  

            if(geo.continent = "(not set)",null,geo.continent) AS geo_continent_name,
            if(geo.sub_continent = "(not set)",null,geo.sub_continent) AS geo_sub_continent_name,
            if(geo.region = "(not set)",null,geo.region) AS geo_region_name,
            if(geo.metro = "(not set)",null,geo.metro) AS geo_metro_name,
            if(geo.country = "(not set)",null,geo.country) AS geo_country_name,
            if(geo.city = "(not set)",null,geo.city) AS geo_city_name,

            IF(device.category = "(not set)", NULL, device.category) AS device_category,
            IF(device.mobile_brand_name = "(not set)", NULL, device.mobile_brand_name) AS device_mobile_brand_name,
            IF(device.mobile_model_name = "(not set)", NULL, device.mobile_model_name) AS device_mobile_model_name,
            IF(device.mobile_os_hardware_model = "(not set)", NULL, device.mobile_os_hardware_model) AS device_mobile_os_hardware_model,
            IF(device.operating_system = "(not set)", NULL, device.operating_system) AS device_operating_system,
            IF(device.operating_system_version = "(not set)", NULL, device.operating_system_version) AS device_operating_system_version,
            IF(device.vendor_id = "(not set)", NULL, device.vendor_id) AS device_vendor_id,
            IF(device.language = "(not set)", NULL, device.language) AS device_language,
            IF(device.is_limited_ad_tracking = "(not set)", NULL, device.is_limited_ad_tracking) AS device_is_limited_ad_tracking,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'platform') AS platform,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'version') AS `version`,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'native_version') AS native_version,

            (SELECT value.string_value 
            FROM UNNEST(event_params) 
            WHERE key = 'utm_source') AS utm_source,

            stream_id,

            coalesce(
                  (SELECT value.string_value 
                        FROM UNNEST(event_params) 
                        WHERE key = 'event_version') 
                  ,"default"
            )AS event_version,
            "GA" as event_source,
            DATE(FORMAT_DATE('%Y-%m-%d', PARSE_DATE('%Y%m%d', _TABLE_SUFFIX))) AS dt,
            GENERATE_UUID() as event_uuid,
            favie_dw.get_app_name(stream_id) as app_name
      FROM `srpproduct-dc37e.analytics_445561079.events_intraday_*`
      WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', dt_param) 
            AND stream_id NOT IN ('11363678660') 
            AND event_name IN ('select_item', 'view_item_list', 'view_item', 'user_engagement')
      )

      SELECT 
            session_id,
            user_id,
            device_id,
            refer,
            pre_refer,
            ap_name,
            
            user_pseudo_id,
            user_login_type,

            event_name,
            event_method,
            event_action_type,
            event_ab_infos,
            event_items,
            TIMESTAMP_MICROS(
                  if(event_timestamp_gensmo<10000000000000,event_timestamp_gensmo*1000,event_timestamp_gensmo)
            ) as event_timestamp,
            event_uuid,

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
            `version`,
            native_version,
            utm_source,
            stream_id,
            appsflyer_id,
            event_version,
            event_source,
            app_name,
            dt
      FROM gensmo_events_data
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
