# dws_gensmo_user_activity_profile_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_activity_profile_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-10-21
**最后更新**: 2025-10-21

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
WITH event_base_data as (
        select 
            dt,
            device_id,
            user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_timestamp,
            event_action_type,
            event_interval,
            appsflyer_id,
            user_login_type,
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
            )) as app_info,
            if(coalesce(trim(event_action_type),'') not in ('','default','load_more','enter_home','no_action','delete'),event_action_type,null) as common_action_type,
        from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            and refer_group = "valid"
            and event_version is not null
            and event_version = "1.0.0"  
    ),

    user_action_info_metrics_base as (
        select 
            device_id,
            common_action_type,
            struct(
                common_action_type as action_type,
                count(common_action_type) as action_cnt
            ) as user_action,
        from event_base_data
        where common_action_type is not null
        group by device_id, common_action_type
    ),

    user_action_info_metrics as (
        select 
            device_id,
            ARRAY_AGG(user_action) as common_actions
        from user_action_info_metrics_base
        group by device_id
    ),

    event_data_with_first_value as (
        select 
            dt,
            device_id,
            if(lower(trim(user_id)) in ('','default','unknown'), null, user_id) as user_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_timestamp,
            event_action_type,
            event_interval,
            first_value(event_timestamp) over(partition by device_id order by event_timestamp) as first_event_timestamp,
            first_value(event_timestamp) over(partition by device_id order by event_timestamp desc) as last_event_timestamp,
            first_value(appsflyer_id) over(partition by device_id order by if(appsflyer_id is not null,1,0) desc ,event_timestamp) as appsflyer_id,
            first_value(geo_address) over(partition by device_id order by if(geo_address is not null,1,0) desc,event_timestamp) as geo_address,
            first_value(app_info) over(partition by device_id order by if(app_info is not null,1,0) desc,event_timestamp desc) as app_info,
            common_action_type,
        from event_base_data
    ),

    user_duration_info as (
        select 
            dt,
            device_id,
            appsflyer_id,
            first_event_timestamp,
            last_event_timestamp,
            geo_address,
            app_info,
            SUM(if(event_interval<30000,event_interval,0))/1000 AS user_duration,
            ARRAY_AGG(distinct user_id ignore nulls) as user_ids
        FROM event_data_with_first_value
        where dt = dt_param
        GROUP BY dt,device_id,appsflyer_id,first_event_timestamp,last_event_timestamp,geo_address,app_info
    ),

    finally_data as (
        select 
            t1.dt,
            t1.device_id,
            t1.appsflyer_id,
            t1.user_ids,

            t3.is_internal_user,
            t3.user_type,
            t3.user_tenure_type,
            t3.user_tenure_segment,
            t3.user_login_type,
            t3.created_at as user_created_at,
            
            t1.first_event_timestamp,
            t1.last_event_timestamp,
            t1.geo_address,
            t1.app_info,
            t1.user_duration,
            t2.common_actions,
        from user_duration_info t1
        left outer join user_action_info_metrics t2
        on t1.device_id = t2.device_id 
        left outer join favie_dw.dim_favie_gensmo_user_snapshot_function(dt_param) t3
        on t1.device_id = t3.device_id
    )

    SELECT 
        dt,
        device_id,
        appsflyer_id,
        IFNULL(user_ids, []) AS user_ids,

        is_internal_user,
        user_type,
        user_tenure_type,
        user_tenure_segment,
        user_login_type,
        user_created_at,

        first_event_timestamp,
        last_event_timestamp,
        geo_address,
        app_info,
        IFNULL(user_duration, 0) AS user_duration,
        IFNULL(common_actions, []) AS common_actions
    FROM finally_data
```

---

**文档生成**: 2026-01-30 13:42:45
**扫描工具**: scan_functions.py
