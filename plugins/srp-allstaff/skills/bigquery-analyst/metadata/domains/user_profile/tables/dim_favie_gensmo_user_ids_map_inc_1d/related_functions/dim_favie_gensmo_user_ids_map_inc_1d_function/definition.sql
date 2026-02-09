WITH latest_mapping AS (
        SELECT
            dt,
            user_id,
            device_id,
            appsflyer_id,
            event_timestamp,
            first_value(event_timestamp) OVER (
                PARTITION BY user_id,device_id,appsflyer_id
                ORDER BY event_timestamp desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) AS last_timestamp,
            ROW_NUMBER() OVER (
                PARTITION BY user_id,device_id,appsflyer_id
                ORDER BY event_timestamp DESC
            ) AS rn
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND user_id IS NOT NULL
            AND device_id IS NOT NULL
            AND appsflyer_id IS NOT NULL
            AND refer_group = 'valid'
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

    latest_mapping_with_internal as (
        SELECT
            t1.dt,
            t1.user_id,
            t1.device_id,
            t1.appsflyer_id,
            t2.is_internal_user,
            t1.last_timestamp
        FROM (select * from latest_mapping WHERE rn = 1) t1
        left outer join dim_gensmo_user_account t2
        on t1.user_id = t2.user_id
    )
    select 
        dt,
        user_id,
        device_id,
        appsflyer_id,
        is_internal_user,
        last_timestamp
    from latest_mapping_with_internal