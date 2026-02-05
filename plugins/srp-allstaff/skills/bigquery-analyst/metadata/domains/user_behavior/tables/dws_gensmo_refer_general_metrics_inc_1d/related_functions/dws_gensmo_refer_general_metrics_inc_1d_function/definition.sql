with refer_base_data as (
        select 
            dt,
            device_id,
            refer,
            -- case 
            --     when refer like 'home%' and ap_name = 'ap_key_entry_point' 
            --     then coalesce(
            --         (select 
            --                 favie_dw.gensmo_name_udf(event_item.item_id) 
            --             from unnest(event_items) event_item
            --             where event_item.item_type = 'key_entry_feature' 
            --             limit 1
            --         ), ap_name)
            --     else ap_name
            -- end as ap_name,
            ap_name,
            (
                select 
                    favie_dw.gensmo_name_udf(event_item.item_id) 
                from unnest(event_items) event_item
                where event_item.item_type = 'key_entry_feature' 
                limit 1
            ) as key_entry_feature_id,
            event_name,
            coalesce(event_method,'unknown') as event_method,
            coalesce(event_action_type,'unknown') as event_action_type,
            event_timestamp,
            event_version,
            event_interval
        from favie_dw.dwd_favie_gensmo_events_inc_1d
        where dt = dt_param
            and event_version is not null
            and event_version = '1.0.0'
            and refer_group = 'valid'
    ),

    refer_base_data_with_key_feature_name as (
        select 
            t1.dt,
            t1.device_id,
            t1.refer,
            coalesce(t2.feature_name, t1.ap_name) as ap_name,
            t1.event_name,
            t1.event_method,
            t1.event_action_type,
            t1.event_timestamp,
            t1.event_version,
            t1.event_interval  
        from refer_base_data t1
        left outer join favie_dw.dim_gensmo_top_feature_config_view t2
        on t1.key_entry_feature_id = cast(t2.feature_id as string)
    ),

    refer_ap_click_metric_data as (
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            "refer_ap_click_cnt" as data_name,
            count(1) as data_value
        from refer_base_data_with_key_feature_name
        where event_name = 'select_item' 
            and event_method in ('swipe','click','shake','screenshot','')
        group by 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type
    ),

    refer_backend_metric_data as (
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            "refer_backend_cnt" as data_name,
            count(1) as data_value
        from refer_base_data
        where event_name = 'select_item' 
            and event_method  in ('request_send','load_complete','data_reception_complete','error_general','auto_trigger')
        group by 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type
    ),

    refer_pv_data as (
        select 
            dt,
            device_id,
            refer,
            'ap_screen' as ap_name,
            event_name,
            event_method,
            event_action_type,
            'refer_pv_cnt' as data_name,
            count(1) as data_value,
        from refer_base_data
        where event_name = 'select_item' 
        and event_method = 'page_view'
        group by 
            dt,
            device_id,
            refer,
            event_name,
            event_method,
            event_action_type         
    ),

    refer_leave_directly_data as (
        select 
            dt,
            device_id,
            refer,
            'ap_screen' as ap_name,
            'select_item' as event_name,
            'leave_directly' as event_method,
            'leave' as event_action_type,
            'refer_leave_directly_cnt' as data_name,
            if(countif(event_name = 'select_item' and event_method in ('swipe','click','shake','screenshot'))>0,0,1) as data_value,
        from refer_base_data
        group by 
            dt,
            device_id,
            refer
    ),

    refer_duration_data as (
        select 
            dt,
            device_id,
            refer,
            'ap_screen' as ap_name,
            'all_event' as event_name,
            'stay' as event_method,
            'stay' as event_action_type,
            'refer_duration_amount' as data_name,
            sum((if(event_interval<30000,event_interval,0)/1000)) as data_value
        from refer_base_data
        group by 
            dt,
            device_id,
            refer
    ),

    refer_all_data as (
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_ap_click_metric_data
        union all 
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_backend_metric_data
        union all 
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_leave_directly_data
        union all
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_duration_data
        union all 
        select 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            data_name,
            cast(data_value as float64) as data_value
        from refer_pv_data
    )

    SELECT
        dt,
        device_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    FROM refer_all_data