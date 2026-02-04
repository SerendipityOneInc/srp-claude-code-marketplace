CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gensmo_user_full_view`
AS with dim_gensmo_registered_user as (
        SELECT
            t1.device_id,
            t1.user_id,
            t1.user_email,
            t1.user_name,
            t1.is_effective_user,
            t1.last_continent,
            t1.last_sub_continent,
            t1.last_country,
            t1.last_region,
            t1.last_metro,
            t1.last_city,
            t1.updated_date,
            t1.created_date,
            t1.updated_time,
            t1.created_time,
            t1.device_ids,
            cast(null as string) as source_type,
            dt,
        FROM `gensmo_dim.dim_gensmo_registered_user_full_1d` t1 
        left outer join (
                SELECT MAX(dt) AS max_dt
                FROM gensmo_dim.dim_gensmo_registered_user_full_1d
        )t2 on t1.dt=t2.max_dt
        where  user_id is not null
    ),
    dim_gensmo_unregistered_user as (
        SELECT
            device_id,
            user_id,
            cast(null as string) as user_email,
            cast(null as string) as user_name,
            cast(null as bool) is_effective_user,
            last_continent,
            last_sub_continent,
            last_country,
            last_region,
            last_metro,
            last_city,
            updated_date,
            created_date,
            updated_time,
            created_time,
            cast(null as ARRAY<STRUCT<value STRING>>) as device_ids,
            source_type,
            dt,
        FROM `gensmo_dim.dim_gensmo_unregistered_user_full_1d` t1 
        left outer join (
                SELECT MAX(dt) AS max_dt
                FROM gensmo_dim.dim_gensmo_unregistered_user_full_1d
        )t2 on t1.dt=t2.max_dt
        where  device_id is not null
    ),

    dim_gensmo_user as (
        select 
            device_id,
            user_id,
            user_email,
            user_name,
            is_effective_user,
            last_continent,
            last_sub_continent,
            last_country,
            last_region,
            last_metro,
            last_city,
            updated_date,
            created_date,
            updated_time,
            created_time,
            device_ids,
            source_type,
            dt
        from dim_gensmo_registered_user
        union all
        select 
            device_id,
            user_id,
            user_email,
            user_name,
            is_effective_user,
            last_continent,
            last_sub_continent,
            last_country,
            last_region,
            last_metro,
            last_city,
            updated_date,
            created_date,
            updated_time,
            created_time,
            device_ids,
            source_type,
            dt
        from dim_gensmo_unregistered_user
    )

    select 
        device_id,
        user_id,
        user_email,
        user_name,
        is_effective_user,
        last_continent,
        last_sub_continent,
        last_country,
        last_region,
        last_metro,
        last_city,
        updated_date,
        created_date,
        updated_time,
        created_time,
        device_ids,
        source_type,
        dt
    from (
        select 
            device_id,
            user_id,
            user_email,
            user_name,
            is_effective_user,
            last_continent,
            last_sub_continent,
            last_country,
            last_region,
            last_metro,
            last_city,
            updated_date,
            created_date,
            updated_time,
            created_time,
            device_ids,
            source_type,
            dt,
            row_number() over (
                partition by coalesce(device_id,concat("virtual-",user_id)) 
                order by case when user_id is not null then 1 else 0 end desc) as row_no
        from dim_gensmo_user 
    ) where row_no = 1;