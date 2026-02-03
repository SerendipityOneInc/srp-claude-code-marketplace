with gensmo_refer_metrics AS (
        SELECT
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            
            cal_pre_refer as pre_refer,
            cal_pre_refer_event.ap_name as pre_refer_ap_name,
            cal_pre_refer_event.event_name as pre_refer_event_name,
            cal_pre_refer_event.event_method as pre_refer_event_method,
            cal_pre_refer_event.event_action_type as pre_refer_event_action_type,

            cal_next_refer as next_refer,

            platform,
            app_version,
            web_version,
            event_version,
            COUNT(1) AS event_cnt,
            dt
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
        GROUP BY
            device_id,
            refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            
            cal_pre_refer,
            cal_pre_refer_event.ap_name,
            cal_pre_refer_event.event_name,
            cal_pre_refer_event.event_method,
            cal_pre_refer_event.event_action_type,

            cal_next_refer,

            platform,
            app_version,
            web_version,
            event_version,
            dt
    ),

    dim_user_info as (
        select 
            dt,
            device_id,
            last_30_days_feature.geo_country_name as geo_country_name,
            user_tenure_type,
            last_day_feature.login_type as user_login_type
        from favie_dw.dws_favie_gensmo_user_feature_inc_1d 
        where dt = dt_param
            and device_id is not null
    ),

    gensmo_refer_metrics_with_user_info as (
        select 
            t1.device_id,

            t2.user_tenure_type,
            t2.user_login_type as user_login_type,
            t2.geo_country_name as user_country_name,

            t1.refer,
            t1.ap_name,
            t1.event_name,
            t1.event_method,
            t1.event_action_type,

            t1.pre_refer,
            t1.pre_refer_ap_name,
            t1.pre_refer_event_name,
            t1.pre_refer_event_method,
            t1.pre_refer_event_action_type,

            t1.next_refer,

            t1.platform,
            t1.app_version,
            t1.web_version,
            t1.event_version,
            t1.event_cnt,
            t1.dt
        from gensmo_refer_metrics t1
        left join dim_user_info t2
            on t1.device_id = t2.device_id
    )

    select 
        device_id,
        user_tenure_type,
        user_login_type,
        user_country_name,

        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,

        pre_refer,
        pre_refer_ap_name,
        pre_refer_event_name,
        pre_refer_event_method,
        pre_refer_event_action_type,

        next_refer,

        platform,
        app_version,
        web_version,
        event_version,
        event_cnt,
        dt
    from gensmo_refer_metrics_with_user_info