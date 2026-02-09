CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_ab_search_pro_metrics_inc_1d_view`
AS WITH user_search_metrics AS (
        SELECT
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            model_type,
            SPLIT(user_group, '@')[OFFSET(0)] AS ab_project_name,
            SPLIT(user_group, '@')[OFFSET(2)] AS ab_router_id,
            SPLIT(user_group, '@')[OFFSET(1)] AS ab_router_name,

            home_device_id,
            collage_complete_cnt,
            collage_complete_device_id,
            search_result_product_click_cnt,
            search_result_positive_cnt,
            collage_gen_action_device_id,
            channel_collage_click_cnt,
            channel_screen_cnt,
            channel_device_id
        FROM
            `favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d`
        WHERE
            dt is not null AND user_group LIKE 'ab%'
    )
    
    SELECT
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        model_type,
        ab_project_name,
        ab_router_id,
        ab_router_name,
         home_device_id,
            collage_complete_cnt,
            collage_complete_device_id,
            search_result_product_click_cnt,
            search_result_positive_cnt,
            collage_gen_action_device_id,
            channel_collage_click_cnt,
            channel_screen_cnt,
            channel_device_id
            
    FROM
        user_search_metrics;