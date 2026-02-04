with all_account as (
        SELECT  
            safe_cast(uid as string) AS user_id,
            name AS user_name,
            email AS user_email,
            phone_number AS user_phone,
            firebase_uid,
            CASE WHEN is_active THEN 1 ELSE 2 END AS user_type,
            device_id as last_device_id,
            device_ids, 
            device_ids[safe_offset(0)] AS first_device_id,
            is_bot,
            updated_at,       
            created_at
        FROM `srpproduct-dc37e.favie_dw.dim_gem_account_view`   
        WHERE uid IS NOT NULL 

        UNION ALL
        SELECT  
            safe_cast(uid as string) AS user_id,
            safe_cast(NULL AS STRING) AS user_name,
            safe_cast(NULL AS STRING) AS user_email,
            safe_cast(NULL AS STRING) AS user_phone,
            firebase_uid,
            0 AS user_type,
            device_id as last_device_id,
            ARRAY[device_id] AS device_ids,
            device_id as first_device_id,
            cast(null as string) as is_bot,
            updated_at,       
            created_at
        FROM `srpproduct-dc37e.favie_dw.dim_gem_unregister_account_view`
        WHERE uid IS NOT NULL
            AND device_id IS NOT NULL 
    ),
    internal_user as (
        select 
            user_id
        from(
            select 
                user_id,
                row_number() over(partition by user_id order by user_id) as rn
            from favie_dw.dim_starquest_internal_user_view
        ) where rn = 1
    )

    select 
        dt_param as dt,
        t1.user_id,
        t1.user_name,
        t1.user_email,
        t1.user_phone,
        t1.user_type,
        t1.last_device_id,
        t1.device_ids,
        t1.first_device_id,
        t1.updated_at,       
        t1.created_at,
        if(t2.user_id is not null, true, false) as is_internal_user,
        if(coalesce(lower(trim(is_bot)), 'false') = 'true', true, false) as is_bot_user
    from  all_account t1 
    left outer join internal_user t2
    on t1.user_id = safe_cast(t2.user_id as string)