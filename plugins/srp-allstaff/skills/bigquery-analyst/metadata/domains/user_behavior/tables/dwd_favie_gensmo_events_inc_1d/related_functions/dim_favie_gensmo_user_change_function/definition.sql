WITH current_device_id_info AS (
        SELECT
            scd2_sk,
            start_date,
            end_date,
            is_current,
            created_at,
            device_id,
            is_internal_user,
            user_type,
            user_accounts,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        FROM favie_dw.dim_favie_gensmo_user_scd2_1d
        WHERE is_current = true
    ),

    gensmo_events_30d_base as (
        select 
            dt,
            device_id,
            user_id,
            event_timestamp,
            user_login_type,
            appsflyer_id,
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
        WHERE  dt <= dt_param and dt > DATE_SUB(dt_param, INTERVAL 30 DAY)
            --一般不会出现这种数据，为了防止拉链被破坏，做一层保护
            and date(event_timestamp)<=dt_param 
            and event_version is not null 
            and event_version = '1.0.0'
            and refer_group = 'valid'
    ),

    gensmo_events_dt_param_feature as (
        select 
            dt,
            device_id,
            first_event_timestamp,
            first_access_info,
            last_access_info,
            first_geo_address
        from (
            select 
                dt,
                device_id,
                user_id,
                appsflyer_id,
                user_login_type,
                event_timestamp,
                geo_address,
                app_info,
                first_value(event_timestamp) over(partition by device_id order by event_timestamp) as first_event_timestamp,
                STRUCT(
                    first_value(appsflyer_id) over(partition by device_id order by if(appsflyer_id is not null,1,0) desc,event_timestamp) as appsflyer_id,
                    first_value(app_info) over(partition by device_id order by if(app_info is not null,1,0) desc,event_timestamp) as app_info
                ) as first_access_info,
                first_value(geo_address) over(partition by device_id order by if(geo_address is not null,1,0) desc,event_timestamp) as first_geo_address,
                STRUCT(
                    first_value(appsflyer_id) over(partition by device_id order by if(appsflyer_id is not null ,1,0) desc,event_timestamp desc) as appsflyer_id,
                    first_value(event_timestamp) over(partition by device_id order by event_timestamp desc ) as access_at,
                    first_value(if(user_login_type='login',event_timestamp,null)) over(partition by device_id order by if(user_login_type = 'login',1,0) desc, event_timestamp desc) as login_at,
                    first_value(app_info) over(partition by device_id order by if(app_info is not null,1,0) desc,event_timestamp desc) as app_info
                ) as last_access_info,
                row_number() over(partition by device_id order by event_timestamp desc) as rn
            from gensmo_events_30d_base
            where dt = dt_param
        ) where rn = 1
    ),

    gensmo_events_dt_param_user_id_base as (
        select 
            distinct
            dt,
            device_id,
            user_id
        from gensmo_events_30d_base
        where dt = dt_param
    ),

    dim_gensmo_user_account as (
        select 
            dt_param as dt,
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
        from favie_dw.dim_gensmo_user_account_view
    ),

    gensmo_events_dt_param_user_id_valid as (
        select 
            t1.dt,
            t1.device_id,
            if(t2.user_id is not null,STRUCT(
                t2.user_id,
                t2.user_type
            ),null) as user_id2,
            if(t3.user_id is not null ,STRUCT(
                t3.user_id,
                t3.user_type
            ),null) as user_id3,
            first_value(t2.is_internal_user) over(partition by t1.device_id order by t2.is_internal_user desc) as is_internal_user2,
            first_value(t3.is_internal_user) over(partition by t1.device_id order by t3.is_internal_user desc) as is_internal_user3
        from gensmo_events_dt_param_user_id_base t1 
        left outer join dim_gensmo_user_account t2
        on t1.user_id = t2.user_id
        left outer join dim_gensmo_user_account t3
        on t1.device_id = t3.last_device_id
        where coalesce(t2.user_id,t3.user_id) is not null
    ),

    gensmo_events_dt_param_user_ids as (
        select 
            dt,
            device_id,
            if(is_internal_user2=true or is_internal_user3=true,true,false) as is_internal_user,
            array_agg(user_id2 ignore nulls) as user_accounts2,
            array_agg(user_id3 ignore nulls) as user_accounts3
        from gensmo_events_dt_param_user_id_valid
        group by dt,device_id,if(is_internal_user2=true or is_internal_user3=true,true,false)
    ),

    permanent_geo_address as (
        select 
            device_id,
            geo_address
        from(
            select 
                device_id,
                geo_address,
                row_number() over(partition by device_id order by usage_count desc) as rn
            from(
                select 
                    device_id,
                    geo_address,
                    count(1) as usage_count
                from gensmo_events_30d_base
                group by device_id,geo_address
            )
        )where rn = 1
    ),

    internal_user_data as (
        select 
            distinct device_id
        from favie_dw.dim_favie_gensmo_user_ids_map_inc_1d
        where dt = dt_param and is_internal_user = true
    ),

    gensmo_events_feature as (
        select 
            t1.dt,
            t1.device_id,
            t1.first_event_timestamp,
            t1.first_access_info,
            t1.last_access_info,
            t1.first_geo_address,
            t2.geo_address as permanent_geo_address,
            t3.user_accounts2,
            t3.user_accounts3,
            if(t3.is_internal_user or t4.device_id is not null,true,false) as is_internal_user
        from gensmo_events_dt_param_feature t1 
        left outer join permanent_geo_address t2
        on t1.device_id = t2.device_id
        left outer join gensmo_events_dt_param_user_ids t3
        on t1.device_id = t3.device_id
        left outer join internal_user_data t4
        on t1.device_id = t4.device_id
    ),

    user_change_info as (
        select 
            t1.device_id,
            t2.scd2_sk,
            t2.start_date,
            t2.end_date,
            t2.is_current,
            t2.created_at,
            t1.first_event_timestamp,
            t1.is_internal_user,
            ARRAY(
                select 
                    user_account
                from(
                    SELECT 
                        user_account,
                        row_number() over(partition by user_account.user_id order by user_account.user_type desc) as rn
                    FROM UNNEST(ARRAY_CONCAT(ifnull(t1.user_accounts2,[]),ifnull(t1.user_accounts3,[]),ifnull(t2.user_accounts,[]))) AS user_account
                ) where rn = 1
            ) AS user_accounts,
            coalesce(t2.first_access_info,t1.first_access_info) as first_access_info,
            t1.last_access_info,
            coalesce(t2.first_geo_address,t1.first_geo_address) as first_geo_address,
            t1.permanent_geo_address,
            if(t2.device_id is null,true,false) as is_new_user
        from gensmo_events_feature t1 
        left outer join current_device_id_info t2
        on t1.device_id = t2.device_id
        where t2.device_id is null
            or t2.last_access_info is null
            or date(t1.last_access_info.access_at) > date(t2.last_access_info.access_at)
    )

    select
        scd2_sk,
        start_date,
        end_date,
        is_current,

        device_id,
        created_at,
        first_event_timestamp,
        is_internal_user,
        favie_dw.classify_user_type(user_accounts) as user_type,
        user_accounts,
        first_access_info,
        last_access_info,
        first_geo_address,
        permanent_geo_address,
        is_new_user
    from user_change_info