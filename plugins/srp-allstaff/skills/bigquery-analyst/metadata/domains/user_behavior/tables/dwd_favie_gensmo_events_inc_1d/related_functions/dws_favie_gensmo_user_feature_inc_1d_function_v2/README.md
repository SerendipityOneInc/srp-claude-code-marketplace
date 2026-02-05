# dws_favie_gensmo_user_feature_inc_1d_function_v2

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d_function_v2`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-10-05
**最后更新**: 2025-10-05

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

- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d` (dwd_favie_gensmo_events_inc_1d)

---

## 💻 函数定义

```sql
WITH user_account_by_device_id AS (
        select 
            device_id,
            user_type,
            is_internal_user,
            created_at,
            user_login_type,
            user_tenure_type,
            first_access_info,
            last_access_info,
            permanent_geo_address
        from favie_dw.dim_favie_gensmo_user_snapshot_function(dt_param)
        where  user_activity_type = 'active'
    ),

    last_30_days_event_data as (
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_timestamp,
            event_action_type,
            event_interval,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            platform,
            app_version
        from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt > DATE_SUB(dt_param, INTERVAL 30 DAY)
            and dt <= dt_param
            and refer_group = "valid"
            and event_version is not null
            and event_version = "1.0.0"  
    ),

    last_day_event_data as (
        select 
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_timestamp,
            event_action_type,
            event_interval,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            platform,
            app_version
        from last_30_days_event_data
        where dt = dt_param
    ),

    last_30_days_user_action_types_info_with_count AS (
        SELECT  
            device_id,
            ARRAY_AGG(struct(
                event_action_type,
                event_action_type_count
            )) AS action_types_with_count
        FROM
        (
            SELECT  
                device_id,
                event_action_type,
                COUNT(1) AS event_action_type_count
            FROM last_30_days_event_data
            WHERE event_action_type is not null
                AND lower(event_action_type) != "default"
            GROUP BY  device_id,event_action_type
        )
        GROUP BY  device_id
    ),

    last_day_user_duration_info AS (
        SELECT 
            device_id,
            SUM(if(event_interval<30000,event_interval,0))/1000 AS duration
        FROM last_day_event_data
        GROUP BY 
            device_id
    ),

    last_day_action_types_info_with_count as (
        SELECT  
            device_id,
            ARRAY_AGG(struct(
                event_action_type,
                event_action_type_count
            )) AS action_types_with_count
        FROM(SELECT  
                device_id,
                event_action_type,
                COUNT(1) AS event_action_type_count
            FROM last_day_event_data
            WHERE event_action_type is not null
                AND lower(event_action_type) != "default"
            GROUP BY  device_id,event_action_type
        )
        GROUP BY  device_id
    ),

    last_day_user_geo_usage AS (
        SELECT 
            device_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            COUNT(1) AS usage_count
        FROM last_day_event_data
        GROUP BY device_id,
                 geo_continent_name,
                 geo_sub_continent_name,
                 geo_country_name,
                 geo_region_name,
                 geo_metro_name,
                 geo_city_name
    ),

    last_day_user_geo_usage_rank AS (
        SELECT 
            device_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            usage_count,
            ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY usage_count DESC) AS rn
        FROM last_day_user_geo_usage
    ),

    gensmo_user_feature as (
        SELECT 
            dt_param as dt,
            t0.device_id,
            cast(null as string) as first_device_id,
            t1.first_access_info.appsflyer_id as appsflyer_id,
            t1.is_internal_user,
            t1.user_type,
            t1.created_at,
            t1.last_access_info.access_at as last_access_at,
            t1.user_tenure_type,

            struct(
                t2.geo_continent_name,
                t2.geo_sub_continent_name,
                t2.geo_country_name,
                t2.geo_region_name,
                t2.geo_metro_name,
                t2.geo_city_name,

                t1.last_access_info.appsflyer_id,
                t1.last_access_info.access_at,
                t1.user_login_type as login_type,
                coalesce(t0.duration,0) as duration,
                t1.last_access_info.app_info.platform,
                t1.last_access_info.app_info.app_version,
                cast(null as array<string>) as action_types,
                t3.action_types_with_count
            ) as last_day_feature,

            struct(
                t1.permanent_geo_address.geo_continent_name,
                t1.permanent_geo_address.geo_sub_continent_name,
                t1.permanent_geo_address.geo_country_name,
                t1.permanent_geo_address.geo_region_name,
                t1.permanent_geo_address.geo_metro_name,
                t1.permanent_geo_address.geo_city_name,

                cast(null as array<string>) as action_types,
                t4.action_types_with_count
            ) as last_30_days_feature
        FROM last_day_user_duration_info t0 
        left outer join user_account_by_device_id t1
        on t0.device_id = t1.device_id
        left outer join (select * from last_day_user_geo_usage_rank where rn = 1) t2
        on t1.device_id = t2.device_id
        left outer join last_day_action_types_info_with_count t3
        on t1.device_id = t3.device_id
        left outer join last_30_days_user_action_types_info_with_count t4
        on t1.device_id = t4.device_id
    )

    SELECT 
        dt,
        device_id,
        first_device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        created_at,
        last_day_feature,
        last_30_days_feature,
        date(last_access_at) as last_access_at
    FROM gensmo_user_feature
```

---

**文档生成**: 2026-01-30 13:42:12
**扫描工具**: scan_functions.py
