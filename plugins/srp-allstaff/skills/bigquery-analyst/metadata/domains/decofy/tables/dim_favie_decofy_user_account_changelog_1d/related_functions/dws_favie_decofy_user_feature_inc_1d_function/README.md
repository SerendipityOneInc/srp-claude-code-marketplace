# dws_favie_decofy_user_feature_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_decofy_user_feature_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: utility
**语言**: SQL
**创建时间**: 2025-09-04
**最后更新**: 2025-09-04

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

- `srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_changelog_1d` (dim_favie_decofy_user_account_changelog_1d)
- `srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d` (dwd_favie_decofy_events_inc_1d)

---

## 💻 函数定义

```sql
WITH last_day_event_data as (
        select 
            user_id,
            appsflyer_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            platform,
            app_version,
            event_action_type,
            event_timestamp,
            event_interval,
            user_login_type,
            device_id
        from srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d
        where dt = dt_param
            and user_id is not null
            and lower(user_id) not in ("unknown","default")
            and refer_group = "valid"
            and event_version = "1.0.0"
    ),

    last_30_days_event_data as (
        select 
            t1.*
        from (
            select 
                user_id,
                appsflyer_id,
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name,
                platform,
                app_version,
                event_action_type
            from srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d
            WHERE dt >= DATE_SUB(dt_param, INTERVAL 30 DAY)
                and dt <= dt_param
                and user_id is not null
                and lower(user_id) not in ("unknown","default")
                and refer_group = "valid"
                and event_version = "1.0.0"
        ) t1 left outer join (
            select distinct user_id from last_day_event_data
        ) t2 on t1.user_id = t2.user_id
        where t2.user_id is not null 
    ),

    last_day_user_geo_usage AS (
        SELECT 
            user_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            COUNT(1) AS usage_count
        FROM last_day_event_data
        GROUP BY user_id,
                 geo_continent_name,
                 geo_sub_continent_name,
                 geo_country_name,
                 geo_region_name,
                 geo_metro_name,
                 geo_city_name
    ),

    last_day_user_geo_usage_rank AS (
        SELECT 
            user_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            usage_count,
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY usage_count DESC) AS rn
        FROM last_day_user_geo_usage
    ),


    last_30_days_user_geo_usage AS (
        SELECT 
            user_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            COUNT(1) AS usage_count
        FROM last_30_days_event_data
        GROUP BY user_id,
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name
    ),

    last_30_days_user_geo_usage_rank AS (
        SELECT 
            user_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            usage_count,
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY usage_count DESC) AS rn
        FROM last_30_days_user_geo_usage
    ),

    last_day_user_platform_usage AS (
        SELECT
            user_id,
            platform,
            app_version,
            COUNT(1) AS usage_count
        FROM last_day_event_data
        GROUP BY
            user_id , platform,app_version
    ),

   last_day_user_platform_usage_rank AS (
        SELECT
            user_id,
            platform,
            app_version,
            usage_count,
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY usage_count DESC) AS rn
        FROM last_day_user_platform_usage
    ),

    last_30_days_user_action_types_info AS (
        SELECT
            user_id,
            ARRAY_AGG(distinct event_action_type) AS action_types
        FROM last_30_days_event_data
        WHERE event_action_type IS NOT NULL
            and lower(event_action_type)!="default"
        GROUP BY
            user_id
    ),


    last_day_user_access_info AS (
        SELECT 
            user_id,
            MAX(event_timestamp) AS access_at,
            SUM(if(event_interval<30000,event_interval,0))/1000 AS duration,
            MAX(CASE WHEN user_login_type = "login" and user_id is not null THEN "login" ELSE "guest" END) AS login_type,
            ARRAY_AGG(distinct if(lower(event_action_type)="default",null,event_action_type) IGNORE NULLS) AS action_types
        FROM last_day_event_data
        GROUP BY 
            user_id
    ),

    last_day_appsflyer_id AS (
        SELECT 
            user_id,
            device_id,
            appsflyer_id,
            row_number() over(partition by user_id order by event_timestamp desc) as rn
        FROM last_day_event_data
        where appsflyer_id is not null
            and device_id is not null
    ),

    last_day_appsflyer_id_rank as (
        SELECT 
            user_id,
            device_id,
            appsflyer_id
        FROM last_day_appsflyer_id
        where rn = 1
    ),

    gensmo_user_feature as (
        SELECT 
            dt_param as dt,
            t0.user_id,
            t0.first_device_id,
            t0.appsflyer_id as first_appsflyer_id,
            t0.is_internal_user,
            t0.user_type,
            t0.created_at,

            struct(
                t2.geo_continent_name,
                t2.geo_sub_continent_name,
                t2.geo_country_name,
                t2.geo_region_name,
                t2.geo_metro_name,
                t2.geo_city_name,

                t1.access_at,
                t1.login_type,
                t1.duration,
                t4.platform,
                t4.app_version,
                t1.action_types,
                t6.appsflyer_id,
                t6.device_id
            ) as last_day_feature,

            struct(
                t3.geo_continent_name,
                t3.geo_sub_continent_name,
                t3.geo_country_name,
                t3.geo_region_name,
                t3.geo_metro_name,
                t3.geo_city_name,
                t5.action_types
            ) as last_30_days_feature
        FROM srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_changelog_1d t0 
        left outer join last_day_user_access_info t1
        on t0.user_id = t1.user_id
        left outer join (select * from last_day_user_geo_usage_rank where rn = 1) t2
        on t1.user_id = t2.user_id
        left outer join (select * from last_30_days_user_geo_usage_rank where rn = 1 ) t3
        on t1.user_id = t3.user_id
        left outer join (select * from last_day_user_platform_usage_rank where rn = 1) t4
        on t1.user_id = t4.user_id
        left outer join last_30_days_user_action_types_info t5
        on t1.user_id = t5.user_id
        left outer join last_day_appsflyer_id_rank t6
        on t1.user_id = t6.user_id
        where t1.user_id is not null
    )

    SELECT 
        dt,
        user_id,
        first_device_id,
        first_appsflyer_id,
        is_internal_user,
        "register" as user_type,
        if(date(created_at) = dt_param, "New User","Old User") as user_tenure_type,
        created_at,
        last_day_feature,
        last_30_days_feature
    FROM gensmo_user_feature
```

---

**文档生成**: 2026-01-30 13:41:50
**扫描工具**: scan_functions.py
