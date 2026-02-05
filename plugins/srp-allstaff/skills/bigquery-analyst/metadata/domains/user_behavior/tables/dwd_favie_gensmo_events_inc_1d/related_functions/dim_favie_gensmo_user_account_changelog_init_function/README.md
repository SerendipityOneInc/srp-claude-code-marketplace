# dim_favie_gensmo_user_account_changelog_init_function

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_init_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: aggregation
**语言**: SQL
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

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
WITH dim_gensmo_user_account AS (
        SELECT 
            user_id,
            user_name,
            user_email,
            user_phone,
            user_type,
            last_device_id,
            device_ids,
            first_device_id,
            updated_at,
            created_at,
            is_internal_user,
            is_bot_user
        FROM favie_dw.dim_favie_gensmo_user_account_full_1d
        WHERE dt = (SELECT MAX(dt) FROM favie_dw.dim_favie_gensmo_user_account_full_1d WHERE dt IS NOT NULL)
    ),
    
    mongo_gensmo_user_account_full AS (
        select 
            user_id,
            user_name,
            user_email,
            user_phone,
            user_type,
            last_device_id,
            device_ids,
            first_device_id,
            updated_at,
            created_at
        from dim_gensmo_user_account
        where Date(created_at) <= dt_param
    ),

    event_user_info_by_user_id_base as (
        select 
            user_id,
            device_id,
            event_timestamp,
            if(coalesce(geo_continent_name,geo_sub_continent_name,geo_country_name,geo_region_name,geo_metro_name,geo_city_name) is null, null,struct(
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name
            )) as geo_address,
            if(coalesce(platform,app_version) is null ,null,struct(
                platform,
                app_version
            )) as app_info
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE  dt <= dt_param
            and user_id is not null
            and REGEXP_CONTAINS(user_id, r'^[0-9]+$') 
            and device_id is not null  
            and event_timestamp is not null
            and refer_group = 'valid'
    ),

    event_user_info_by_user_id as (
        SELECT 
            user_id,
            first_value(app_info) over (partition by user_id order by if(app_info is not null,0,1), event_timestamp) as app_info,
            first_value(geo_address) over (partition by user_id order by if(geo_address is not null,0,1), event_timestamp) as geo_address,
            first_value(device_id) over (partition by user_id order by if(device_id is not null,0,1), event_timestamp) as first_device_id,
            first_value(device_id) over (partition by user_id order by if(device_id is not null,0,1), event_timestamp desc) as last_device_id,
            row_number() over (partition by user_id order by event_timestamp) as rn
        FROM event_user_info_by_user_id_base       
    ),

    event_user_info_by_device_id_base as (
        select 
            device_id,
            event_timestamp,
            if(coalesce(geo_continent_name,geo_sub_continent_name,geo_country_name,geo_region_name,geo_metro_name,geo_city_name) is null, null,struct(
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name
            )) as geo_address,
            if(coalesce(platform,app_version) is null ,null,struct(
                platform,
                app_version
            )) as app_info
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt <= dt_param
            and device_id is not null 
            and event_timestamp is not null
            And refer_group = 'valid'
    ),

    event_user_info_by_device_id as (
        SELECT 
            device_id,
            first_value(app_info) over (partition by device_id order by if(app_info is not null,0,1), event_timestamp) as app_info,
            first_value(geo_address) over (partition by device_id order by if(geo_address is not null,0,1), event_timestamp) as geo_address,
            row_number() over (partition by device_id order by event_timestamp) as rn
        FROM event_user_info_by_device_id_base          
    ),

    device_id_appsflyer_id_map as (
        SELECT 
            device_id,
            appsflyer_id,
            ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY event_timestamp) AS rn
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt >= DATE_SUB(dt_param, INTERVAL 60 DAY)
            and dt <= dt_param
            and device_id IS NOT NULL
            and appsflyer_id IS NOT NULL
            and event_timestamp is not null
            and refer_group = 'valid'
    ),

    mongo_gensmo_user_account_full_with_event_info AS (
        SELECT 
            dt_param AS dt,
            t1.updated_at,
            t1.created_at,

            t1.user_id,
            coalesce(t1.first_device_id,t2.first_device_id) AS first_device_id,
            coalesce(t2.last_device_id,t1.last_device_id) as last_device_id,
            t4.appsflyer_id,
            t1.device_ids,
            t1.user_name,
            t1.user_email,
            t1.user_type,
            false as is_internal_user,

            coalesce(t2.geo_address, t3.geo_address) as geo_address,
            coalesce(t2.app_info, t3.app_info) as app_info
        FROM mongo_gensmo_user_account_full t1
        LEFT OUTER JOIN (select * from event_user_info_by_user_id where rn = 1) t2 ON t1.user_id = t2.user_id
        LEFT OUTER JOIN (select * from event_user_info_by_device_id where rn = 1) t3 ON t1.last_device_id = t3.device_id
        LEFT OUTER JOIN (select * from device_id_appsflyer_id_map where rn =1) t4 ON t1.last_device_id = t4.device_id
    )

    SELECT 
        dt as process_date,
        updated_at,
        created_at,

        user_id,
        first_device_id,
        last_device_id,
        appsflyer_id,
        device_ids,
        user_email,
        user_name,
        user_type,
        is_internal_user,

        geo_address,
        app_info      
    FROM mongo_gensmo_user_account_full_with_event_info
```

---

**文档生成**: 2026-01-30 13:40:36
**扫描工具**: scan_functions.py
