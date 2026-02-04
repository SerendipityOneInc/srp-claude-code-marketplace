# dws_favie_gensmo_user_feature_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-24
**最后更新**: 2025-09-24

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
WITH user_account_by_first_device_id AS (
        select 
            user_id,
            first_device_id,
            last_device_id,
            user_type,
            is_internal_user,
            first_value(appsflyer_id) over (partition by first_device_id order by if(appsflyer_id is not null,0,1),created_at) as appsflyer_id,
            first_value(created_at) over (partition by first_device_id order by created_at) as created_at,
        from favie_dw.dim_favie_gensmo_user_account_changelog_1d
        where first_device_id is not null
            and last_device_id is not null
            and created_at is not null
            and date(created_at) <= dt_param
    ),

    user_account_by_last_device_id AS (
        select 
            user_id,
            last_device_id,
            first_value(is_internal_user) over (partition by last_device_id order by if(is_internal_user,0,1),created_at) as is_internal_user,
            first_value(first_device_id) over (partition by last_device_id order by created_at) as first_device_id,
            first_value(created_at) over (partition by last_device_id order by created_at) as created_at,
            first_value(user_type) over (partition by last_device_id order by user_type desc) as user_type,
            first_value(appsflyer_id) over (partition by last_device_id order by if(appsflyer_id is not null,0,1),created_at) as appsflyer_id,
            row_number() over (partition by last_device_id order by created_at) as rn
        from user_account_by_first_device_id
    ),
    
    last_day_event_data as (
        select 
            *
        from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        where dt = dt_param
            and device_id is not null
            and lower(device_id) not in ("unknown","default")
            and refer_group = "valid"
            and event_version = "1.0.0"
    ),

    last_30_days_event_data as (
        select 
            t1.*
        from (
            select * from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
            WHERE dt >= DATE_SUB(dt_param, INTERVAL 30 DAY)
                and dt <= dt_param
                and device_id is not null
                and lower(device_id) not in ("unknown","default")
                and refer_group = "valid"
                and event_version = "1.0.0"
        ) t1 left outer join (
            select distinct device_id from last_day_event_data
         ) t2
        on t1.device_id = t2.device_id
        where t2.device_id is not null 
    ),

    last_access_data as (
        
        SELECT 
            device_id,
            MAX(dt) AS last_access_at
        FROM `favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt <= dt_param-1
            AND device_id IS NOT NULL
        GROUP BY device_id
            
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


    last_30_days_user_geo_usage AS (
        SELECT 
            device_id,
            geo_continent_name,
            geo_sub_continent_name,
            geo_country_name,
            geo_region_name,
            geo_metro_name,
            geo_city_name,
            COUNT(1) AS usage_count
        FROM last_30_days_event_data
        GROUP BY device_id,
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name
    ),

    last_30_days_user_geo_usage_rank AS (
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
        FROM last_30_days_user_geo_usage
    ),

    last_day_user_platform_usage AS (
        SELECT
            device_id,
            platform,
            app_version,
            COUNT(1) AS usage_count
        FROM last_day_event_data
        GROUP BY
            device_id , platform,app_version
    ),

   last_day_user_platform_usage_rank AS (
        SELECT
            device_id,
            platform,
            app_version,
            usage_count,
            ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY usage_count DESC) AS rn
        FROM last_day_user_platform_usage
    ),


    last_30_days_user_action_types_info AS (
        SELECT
            device_id,
            ARRAY_AGG(distinct event_action_type) AS action_types
        FROM last_30_days_event_data
        WHERE event_action_type IS NOT NULL
            and lower(event_action_type)!="default"
        GROUP BY
            device_id
    ),

    last_day_user_access_info AS (
        SELECT 
            device_id,
            max(appsflyer_id) as appsflyer_id,
            MAX(event_timestamp) AS access_at,
            SUM(if(event_interval<30000,event_interval,0))/1000 AS duration,
            MAX(CASE WHEN user_login_type = "login" and REGEXP_CONTAINS(user_id, r'^[0-9]+$') THEN "login" ELSE "guest" END) AS login_type,
            ARRAY_AGG(distinct if(lower(event_action_type)="default",null,event_action_type) IGNORE NULLS) AS action_types
        FROM last_day_event_data
        GROUP BY 
            device_id
    ),




    last_30_days_user_action_types_info_with_count AS (
        

    SELECT  device_id
        ,ARRAY_AGG(struct(event_action_type,event_action_type_count)) AS action_types_with_count
    FROM
    (
        SELECT  device_id
            ,event_action_type
            ,COUNT(1) AS event_action_type_count
        FROM last_30_days_event_data
        WHERE event_action_type is not null
        AND lower(event_action_type) != "default"
        GROUP BY  device_id
                ,event_action_type
    )
    GROUP BY  device_id
    ),


    last_day_action_types_info_with_count as (

    SELECT  device_id
        ,ARRAY_AGG(struct(event_action_type,event_action_type_count)) AS action_types_with_count
    FROM
    (
        SELECT  device_id
            ,event_action_type
            ,COUNT(1) AS event_action_type_count
        FROM last_day_event_data
        WHERE event_action_type is not null
        AND lower(event_action_type) != "default"
        GROUP BY  device_id
                ,event_action_type
    )
    GROUP BY  device_id
    ),

    gensmo_user_feature as (
        SELECT 
            dt_param as dt,
            t0.last_device_id as device_id,
            t0.first_device_id,
            t0.appsflyer_id,
            t0.is_internal_user,
            t0.user_type,
            t0.created_at,
            t8.last_access_at,

            struct(
                t2.geo_continent_name,
                t2.geo_sub_continent_name,
                t2.geo_country_name,
                t2.geo_region_name,
                t2.geo_metro_name,
                t2.geo_city_name,

                t1.appsflyer_id,
                t1.access_at,
                t1.login_type,
                t1.duration,
                t4.platform,
                t4.app_version,
                t1.action_types,
                t6.action_types_with_count
            ) as last_day_feature,

            struct(
                t3.geo_continent_name,
                t3.geo_sub_continent_name,
                t3.geo_country_name,
                t3.geo_region_name,
                t3.geo_metro_name,
                t3.geo_city_name,

                t5.action_types,
                t7.action_types_with_count
            ) as last_30_days_feature
        FROM (select * from user_account_by_last_device_id where rn = 1) t0 
        left outer join last_day_user_access_info t1
        on t0.last_device_id = t1.device_id
        left outer join (select * from last_day_user_geo_usage_rank where rn = 1) t2
        on t1.device_id = t2.device_id
        left outer join (select * from last_30_days_user_geo_usage_rank where rn = 1 ) t3
        on t1.device_id = t3.device_id
        left outer join (select * from last_day_user_platform_usage_rank where rn = 1) t4
        on t1.device_id = t4.device_id
        left outer join last_30_days_user_action_types_info t5
        on t1.device_id = t5.device_id
        left outer join last_day_action_types_info_with_count t6
        on t1.device_id = t6.device_id
        left outer join last_30_days_user_action_types_info_with_count t7
        on t1.device_id = t7.device_id
        left outer join last_access_data t8
        on t1.device_id = t8.device_id
        where t1.device_id is not null
    )

    SELECT 
        dt,
        device_id,
        first_device_id,
        appsflyer_id,
        is_internal_user,
        case when user_type = 0 then "unregister"
             when user_type = 1 then "register"
             when user_type = 2 then "deregister"
             else "unknown" 
        end as user_type,
        if(date(created_at) = dt_param, "New User","Old User") as user_tenure_type,
        created_at,
        last_day_feature,
        last_30_days_feature,
        last_access_at
    FROM gensmo_user_feature
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
