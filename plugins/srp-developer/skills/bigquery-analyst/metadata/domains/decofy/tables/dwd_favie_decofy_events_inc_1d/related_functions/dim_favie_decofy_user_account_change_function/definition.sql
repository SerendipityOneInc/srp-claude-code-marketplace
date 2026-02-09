WITH current_user AS (
        SELECT
            scd2_sk,
            start_date,
            end_date,
            is_current,
            updated_at,
            created_at,
            user_id,
            device_ids,
            user_name,
            user_email,
            user_type,
            is_internal_user,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        FROM favie_dw.dim_favie_decofy_user_account_scd2_1d
        WHERE is_current = true
    ),

    account_change_users_base as (
        select
            uid,
            device_ids,
            email,
            username,
            avatar,
            firebase_uid,
            last_login_country,
            last_login_ip,
            created_at,
            updated_at,
            deleted_at,
            last_login
        from `favie_dw.dim_decofy_users_view`
        where date(created_at) <= dt_param
    ),

    account_changed_users AS (
        SELECT
            SAFE_CAST(t1.uid AS STRING) AS user_id,
            t1.updated_at,
            t1.created_at,
            t1.device_ids,
            t1.username AS user_name,
            t1.email AS user_email
        FROM account_change_users_base t1 left outer join current_user t2
        on SAFE_CAST(t1.uid AS STRING) is not null and SAFE_CAST(t1.uid AS STRING) = t2.user_id
        WHERE t2.user_id is null     --表示新增用户
            or t1.updated_at > t2.updated_at --表示用户信息有更新,使用大于号是为了避免重复更新，保证拉链表更新幂等性
    ),

    active_user_30d_base AS (
        SELECT 
            user_id,
            appsflyer_id,
            device_id,
            event_timestamp,
            if(coalesce(geo_continent_name,geo_sub_continent_name,geo_country_name,geo_region_name,geo_metro_name,geo_city_name) is null ,null,struct(
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name
            )) as geo_address
        FROM srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d
        WHERE dt >= DATE_SUB(dt_param, INTERVAL 30 DAY) AND dt <= dt_param 
            and user_id is not null
            and user_id not in ("unknown","default")
            and refer_group = 'valid'        
    ),

    permanent_geo_address as (
        select 
            user_id,
            geo_address
        from(
            select 
                user_id,
                geo_address,
                row_number() over (partition by user_id order by usage_count desc) as rn
            from (
                select 
                    user_id,
                    geo_address,
                    count(1) as usage_count
                from active_user_30d_base
                group by user_id, geo_address
            )
        ) where rn = 1
    ),

    active_user_1d_base AS (
        SELECT 
            user_id,
            appsflyer_id,
            device_id,
            event_timestamp,
            if(coalesce(platform,app_version) is null , null,struct(
                platform,
                app_version
            )) as app_info,
            if(coalesce(geo_continent_name,geo_sub_continent_name,geo_country_name,geo_region_name,geo_metro_name,geo_city_name) is null ,null,struct(
                geo_continent_name,
                geo_sub_continent_name,
                geo_country_name,
                geo_region_name,
                geo_metro_name,
                geo_city_name
            )) as geo_address
        FROM srpproduct-dc37e.favie_dw.dwd_favie_decofy_events_inc_1d
        WHERE dt = dt_param 
            and user_id is not null
            and lower(user_id) not in ("unknown","default")
            and refer_group = 'valid'        
    ),
    
    active_user_info as (
        select 
            user_id,
            struct(
                first_device_id as device_id,
                first_appsflyer_id as appsflyer_id,
                first_app_info as app_info
            ) as first_access_info,
            struct(
                last_device_id as device_id,
                last_appsflyer_id as appsflyer_id,
                last_access_at as access_at,
                last_app_info as app_info
            ) as last_access_info,
            first_geo_address
        from (
            SELECT 
                user_id,

                first_value(appsflyer_id) over (partition by user_id order by if(appsflyer_id is not null,1,0) desc, event_timestamp ) as first_appsflyer_id,
                first_value(device_id) over (partition by user_id order by if(device_id is not null,1,0) desc , event_timestamp ) as first_device_id,
                first_value(app_info) over (partition by user_id order by if(app_info is not null,1,0) desc, event_timestamp ) as first_app_info,
                first_value(geo_address) over (partition by user_id order by if(geo_address is not null,1,0) desc, event_timestamp ) as first_geo_address,

                first_value(event_timestamp) over (partition by user_id order by  event_timestamp desc ) as last_access_at,
                first_value(appsflyer_id) over (partition by user_id order by if(appsflyer_id is not null,1,0) desc, event_timestamp desc ) as last_appsflyer_id,
                first_value(app_info) over (partition by user_id order by if(app_info is not null,1,0) desc, event_timestamp desc) as last_app_info,
                first_value(device_id) over (partition by user_id order by if(device_id is not null,1,0) desc , event_timestamp desc) as last_device_id,
                row_number() over (partition by user_id order by event_timestamp) as rn
            FROM active_user_1d_base
        ) WHERE rn = 1
    ),

    active_user_feature as (
        select 
            t1.user_id,
            t1.first_access_info,
            t1.last_access_info,
            t1.first_geo_address,
            t2.geo_address as permanent_geo_address,
        from active_user_info t1
        left outer join permanent_geo_address t2
        on t1.user_id = t2.user_id 
    ),

    all_changed_user_base as (
        select
            user_id,
            updated_at,
            created_at,
            device_ids,
            user_name,
            user_email,
            cast(1 as int64) as user_type,
            False as is_internal_user,
            cast(null as STRUCT<
                device_id STRING,
                appsflyer_id STRING,
                app_info STRUCT<
                    platform STRING,
                    app_version STRING
                >
            >) as first_access_info,
            cast(null as STRUCT<
                device_id STRING,
                appsflyer_id STRING,
                access_at TIMESTAMP,
                app_info STRUCT<
                    platform STRING,
                    app_version STRING
                >
            >) as last_access_info,
            cast(null as struct<
                geo_continent_name STRING,
                geo_sub_continent_name STRING,
                geo_country_name STRING,
                geo_region_name STRING,
                geo_metro_name STRING,
                geo_city_name STRING
            >) as first_geo_address,
            cast(null as struct<
                geo_continent_name STRING,
                geo_sub_continent_name STRING,
                geo_country_name STRING,
                geo_region_name STRING,
                geo_metro_name STRING,
                geo_city_name STRING
            >) as permanent_geo_address
        from account_changed_users
        union all
        select
            user_id,
            cast(null as timestamp) as updated_at,
            cast(null as timestamp) as created_at,
            cast(null as array<string>) as device_ids,
            cast(null as string) as user_name,
            cast(null as string) as user_email,
            cast(null as int64) as user_type,
            False as is_internal_user,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        from active_user_feature
    ),

    all_changed_user_rank as (
        select
            user_id,
            first_value(updated_at) over (partition by user_id order by if(updated_at is not null,0,1)) as updated_at,
            first_value(created_at) over (partition by user_id order by if(created_at is not null,0,1)) as created_at,
            first_value(device_ids) over (partition by user_id order by if(device_ids is not null,0,1)) as device_ids,
            first_value(user_name) over (partition by user_id order by if(user_name is not null,0,1)) as user_name,
            first_value(user_email) over (partition by user_id order by if(user_email is not null,0,1)) as user_email,
            first_value(user_type) over (partition by user_id order by if(user_type is not null,0,1)) as user_type,
            first_value(is_internal_user) over (partition by user_id order by if(is_internal_user is not null,0,1)) as is_internal_user,
            first_value(first_access_info) over (partition by user_id order by if(first_access_info is not null,0,1)) as first_access_info,
            first_value(last_access_info) over (partition by user_id order by if(last_access_info is not null,0,1)) as last_access_info,
            first_value(first_geo_address) over (partition by user_id order by if(first_geo_address is not null,0,1)) as first_geo_address,
            first_value(permanent_geo_address) over (partition by user_id order by if(permanent_geo_address is not null,0,1)) as permanent_geo_address,
            row_number() over (partition by user_id) as rn
        from all_changed_user_base
    ),

    all_changed_user_info as (
        select
            t1.user_id,
            t2.scd2_sk,
            coalesce(t2.created_at,t1.created_at) as created_at,
            coalesce(t1.updated_at,t2.updated_at) as updated_at,
            coalesce(t1.device_ids,t2.device_ids) as device_ids,
            coalesce(t1.user_name,t2.user_name) as user_name,
            coalesce(t1.user_email,t2.user_email) as user_email,
            coalesce(t1.user_type,t2.user_type) as user_type,
            coalesce(t1.is_internal_user,t2.is_internal_user) as is_internal_user,
            coalesce(t2.first_access_info,t1.first_access_info) as first_access_info,
            coalesce(t1.last_access_info,t2.last_access_info) as last_access_info,
            coalesce(t2.first_geo_address,t1.first_geo_address) as first_geo_address,
            coalesce(t1.permanent_geo_address,t2.permanent_geo_address) as permanent_geo_address,
            if(t2.user_id is null, true, false) as is_new_user
        from (select * from all_changed_user_rank where rn = 1) t1
        left outer join current_user t2
        on t1.user_id = t2.user_id
        where t2.user_id is null --表示新增用户
            or (
                t2.start_date < dt_param and
                t2.end_date = DATE('9999-12-31')
            )  --表示当前有效可更新记录  
    )
    select
        user_id,
        scd2_sk,
        created_at,
        updated_at,
        device_ids,
        user_name,
        user_email,
        user_type,
        is_internal_user,
        first_access_info,
        last_access_info,
        first_geo_address,
        permanent_geo_address,
        is_new_user
    from all_changed_user_info
    where created_at is not null