with valid_device_ids as (
        SELECT 
            distinct  device_id
        FROM `favie_dw.dwd_favie_gensmo_events_inc_1d`
        where dt = dt_param and device_id is not null
        and refer not in ('app','unknown')
    ),
    invalid_device_ids as (
        select 
            distinct device_id
        from `favie_dw.dwd_favie_gensmo_events_inc_1d`
        where dt = dt_param and device_id is not null
        and device_id not in (select device_id from valid_device_ids)
    )
    select  
        dt_param as dt,
        platform,
        app_version,
        geo_country_name,
        event_name,
        event_method,
        count(distinct device_id) as invalid_user_cnt
    from `favie_dw.dwd_favie_gensmo_events_inc_1d`
    where dt = dt_param
    and device_id in (select device_id from invalid_device_ids)
    group by platform, app_version, geo_country_name, event_name, event_method