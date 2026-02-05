WITH try_on_metric AS (
        select
            dt,
            user_tenure_type,
            COALESCE(user_country_name,"unknown") as user_country_name,
            COALESCE(platform,"unknown") as platform,
            COALESCE(app_version,"unknown") as app_version,

            sum(if(event_name = "select_item" and event_action_type = "try_on"
                ,event_cnt,null)) as try_on_complete_d1_cnt,
            count(distinct if(
                refer = "try_on_gen" 
                and pre_refer not in ("ai_wardrobe","avatar_manage")
                ,device_id,null)
            ) as try_on_complete_user_d1_cnt,

            sum(if(refer in ("try_on_gen","create_replica","try_on_select_panel","try_on_selected_panel")
                and pre_refer not in ("try_on_gen","create_replica","try_on_select_panel","try_on_selected_panel","ai_wardrobe","avatar_manage")
                and event_name = "select_item" and event_method = "page_view"
                ,event_cnt,null)) as try_on_d1_cnt,
            count(distinct if(refer in ("try_on_gen","create_replica","try_on_select_panel","try_on_selected_panel")
                and pre_refer not in ("try_on_gen","create_replica","try_on_select_panel","try_on_selected_panel","ai_wardrobe","avatar_manage")
                ,device_id,null)
            ) as try_on_user_d1_cnt

        from favie_dw.dws_gensmo_refer_event_metrics_inc_1d
        where dt = dt_param
            AND refer is not null
            AND platform is not null
            AND event_version = '1.0.0'
        group by 
            dt,
            user_tenure_type,
            user_country_name,
            platform,
            app_version
    ),

    dim_favie_gensmo_user_full_1d as (
        select 
            dt,
            if(date(created_at) = dt_param, "New User", "Old User") as user_tenure_type,
            COALESCE(geo_country_name,"unknown") as user_country_name,
            COALESCE(last_platform,"unknown") as platform,
            COALESCE(last_app_version,"unknown") as app_version,
            last_pseudo_id,
            last_access_at,
            updated_at
        from favie_dw.dim_favie_gensmo_user_full_1d 
        where dt = dt_param
            and Date(last_access_at) = dt_param
            and created_at is not null
            and last_pseudo_id is not null
    ),

    active_user_cnt as (
        select 
            dt,
            user_tenure_type,
            user_country_name,
            platform,
            app_version,
            count(distinct last_pseudo_id) as active_user_d1_cnt
        from dim_favie_gensmo_user_full_1d
        group by 
            dt,
            user_tenure_type,
            user_country_name,
            platform,
            app_version
    ),

    try_on_metric_with_actvie_cnt as (
        select
            t1.dt,
            t1.user_tenure_type,
            t1.user_country_name,
            t1.platform,
            t1.app_version,
            t1.try_on_complete_d1_cnt,
            t1.try_on_complete_user_d1_cnt,
            t1.try_on_d1_cnt,
            t1.try_on_user_d1_cnt,
            t2.active_user_d1_cnt
        from try_on_metric t1
        left outer join active_user_cnt t2
        on t1.dt = t2.dt
        and t1.user_tenure_type = t2.user_tenure_type
        and t1.user_country_name = t2.user_country_name
        and t1.platform = t2.platform
        and t1.app_version = t2.app_version
    )


    SELECT
        dt,
        user_tenure_type,
        user_country_name,
        platform,
        app_version,

        try_on_complete_d1_cnt,
        try_on_complete_user_d1_cnt,
        try_on_d1_cnt,
        try_on_user_d1_cnt,
        active_user_d1_cnt
    FROM
        try_on_metric_with_actvie_cnt