with gensmo_refer_metrics AS (
        SELECT
            refer,
            pre_refer,
            platform,
            app_version,
            native_version,
            COUNT(DISTINCT user_pseudo_id) AS uv,
            COUNTIF(event_name="select_item" and event_method = "page_view") AS pv1,
            COUNT(DISTINCT concat(user_pseudo_id,session_id,refer_pv_seq)) AS pv2,
            SUM(if(event_interval<30000,event_interval,0))/1000 AS duration,
            dt
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND event_version != "default"
        GROUP BY
            dt,refer,pre_refer,platform,app_version,native_version
    )

    select 
        refer,
        pre_refer,
        platform,
        app_version,
        native_version,
        pv2 as pv,
        uv,
        duration,
        dt
    from gensmo_refer_metrics