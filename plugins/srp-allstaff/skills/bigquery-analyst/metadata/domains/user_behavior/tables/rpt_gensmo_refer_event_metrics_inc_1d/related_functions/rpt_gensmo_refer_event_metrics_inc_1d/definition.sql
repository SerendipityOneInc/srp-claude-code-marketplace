with gensmo_refer_metrics AS (
        SELECT
            refer,
            pre_refer,
            ap_name,
            event_name,
            event_method,
            event_action_type,
            platform,
            app_version,
            native_version,
            COUNT(1) AS event_cnt,
            COUNT(DISTINCT user_pseudo_id) AS event_user_cnt,
            dt
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND event_version != "default"
        GROUP BY
            dt,refer,pre_refer,ap_name,event_name,event_method,event_action_type,platform,app_version,native_version
    )

    select 
        refer,
        pre_refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        platform,
        app_version,
        native_version,
        event_cnt,
        event_user_cnt,
        dt
    from gensmo_refer_metrics