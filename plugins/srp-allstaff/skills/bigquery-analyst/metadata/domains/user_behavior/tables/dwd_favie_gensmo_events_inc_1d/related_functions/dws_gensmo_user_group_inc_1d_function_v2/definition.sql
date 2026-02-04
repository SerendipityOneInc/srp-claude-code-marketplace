WITH refer_base_data AS (
        SELECT 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            COALESCE(event_method, 'unknown') AS event_method,
            COALESCE(event_action_type, 'unknown') AS event_action_type,
            event_timestamp,
            event_ab_infos,
            event_version
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 7 DAY) AND dt_param
            AND event_version IS NOT NULL
            AND event_version = '1.0.0'
            and refer_group = 'valid'
    ),

    refer_item_base_data AS (
        SELECT 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            COALESCE(event_method, 'unknown') AS event_method,
            COALESCE(event_action_type, 'unknown') AS event_action_type,
            event_timestamp,
            event_version,
            event_item.item_type AS item_type
        FROM favie_dw.dwd_favie_gensmo_events_items_inc_1d
        WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 7 DAY) AND dt_param
            AND event_version is not null
            AND event_version = '1.0.0'
            AND refer_group = 'valid'
    ),

    ab_base as (
        SELECT DISTINCT 
            t1.dt, 
            t2.project,
            t2.router,
            t2.unique_id,
            t1.device_id
        FROM (SELECT 
                DISTINCT dt_param AS dt, 
                SAFE_CAST(ab_unique_id AS INT64) AS ab_unique_id, 
                device_id
            FROM refer_base_data, UNNEST(event_ab_infos) AS ab_unique_id
            WHERE TRIM(COALESCE(ab_unique_id, '')) != '' 
                and dt = dt_param
        )  t1 LEFT JOIN favie_dw.dim_gem_user_ab_config_view t2
        ON t1.ab_unique_id = t2.unique_id
    ),

    ab_valid as (
        select 
            dt,
            project,
            count(distinct concat(router,unique_id)) as router_count
        FROM ab_base
        GROUP BY dt, project
        HAVING router_count > 1
    ),

    user_all_group as (
        SELECT DISTINCT 
            dt_param AS dt, 
            'all' AS user_group, 
            device_id,
            user_activity_type,
            coalesce(last_access_info.appsflyer_id,"unknown") AS appsflyer_id,
            coalesce(permanent_geo_address.geo_country_name,"unknown") AS country_name,
            coalesce(last_access_info.app_info.platform,"unknown") AS platform,
            coalesce(last_access_info.app_info.app_version,"unknown") AS app_version,
            user_login_type,
            user_tenure_segment,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id
        FROM favie_dw.dim_favie_gensmo_user_snapshot_with_ad_function(dt_param,false)
        where is_internal_user = false
    ),

    user_other_groups_base AS (        
        SELECT DISTINCT dt_param AS dt, 'collage_gen_request' AS user_group, device_id
        FROM refer_base_data
        WHERE event_action_type = 'collage_gen_request'

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'feed_detail' AS user_group, device_id
        FROM refer_base_data
        WHERE refer = 'feed_detail'
            AND event_name = 'select_item'
            AND event_method = 'page_view'

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'tryon(trigger)' AS user_group, device_id
        FROM refer_base_data
        WHERE event_action_type in ('try_on_trigger','tryon')

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'product_save' AS user_group, device_id
        FROM refer_item_base_data
        WHERE event_action_type = 'save'
            AND item_type = 'product'

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'collage_save' AS user_group, device_id
        FROM refer_item_base_data
        WHERE event_action_type = 'save'
            AND item_type IN ('similar_collage', 'general_collage')

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'tryon_save' AS user_group, device_id
        FROM refer_item_base_data
        WHERE event_action_type = 'save'
            AND item_type = 'try_on_collage'

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'product_detail' AS user_group, device_id
        FROM refer_base_data
        WHERE refer IN ('product_detail', 'pseudo_product_detail', 'product_search_detail', 'product_detail_from_search')
            AND event_name = 'select_item'
            AND event_method = 'page_view'

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'product_export' AS user_group, device_id
        FROM refer_base_data
        WHERE refer IN ('product_detail', 'pseudo_product_detail', 'product_search_detail', 'product_detail_from_search')
            AND ap_name = 'ap_product_card'

        UNION ALL

        SELECT DISTINCT t1.dt, 
            'ab_' || t1.project || '@' || t1.router || '@' || t1.unique_id AS user_group,
            t1.device_id
        FROM ab_base t1
        LEFT JOIN ab_valid t2
        ON t1.project = t2.project and t1.dt = t2.dt
        where t2.project is not null

        UNION ALL

        SELECT DISTINCT dt_param AS dt, 'replica' AS user_group, t2.device_id
        FROM srpproduct-dc37e.favie_dw.dim_gem_user_replica_view t1
        LEFT JOIN favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function(dt_param)  t2
        ON t1.user_id = t2.user_id

        UNION ALL

        SELECT
            distinct dt_param as dt, 'poster' AS user_group,device_id
        from favie_dw.dws_gensmo_refer_general_metrics_inc_1d
        where dt = dt_param
            and data_name = 'refer_ap_click_cnt'
            and event_action_type = 'post'
            and data_value is not null
        group by device_id
        having sum(data_value) = 1  

        UNION ALL

        select 
            distinct dt_param as dt, 'creator' AS user_group,device_id
        from favie_dw.dws_gensmo_refer_general_metrics_inc_1d
        where dt = dt_param
            and data_name = 'refer_ap_click_cnt'
            and event_action_type = 'post'
            and data_value is not null
        group by device_id
        having sum(data_value) > 1

        UNION ALL

        select
            distinct dt_param as dt, 'operation_try_on_user' AS user_group,device_id
        from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        where event_version IS NOT NULL
            and event_version = '1.0.0'
            and refer_group = 'valid'
            and event_action_type = 'try_on_trigger'
            and refer = 'try_on_lite'
            and ap_name = 'ap_try_on_lite_inspo'

        UNION ALL

        select
            distinct dt_param as dt, 'upload_try_on_user' AS user_group,device_id
        from srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        where event_version IS NOT NULL
            and event_version = '1.0.0'
            and refer_group = 'valid'
            and event_action_type = 'try_on_trigger'
            and refer = 'try_on_lite'
            and ap_name = 'bd_try_on_attached_photo'


        UNION ALL

        select
            distinct dt_param as dt, 'custom_avatar_try_on_user' AS user_gruop,t2.last_device_id AS device_id
        from favie_dw.dim_try_on_user_task_view t1
        left join `srpproduct-dc37e.favie_dw.dim_gensmo_user_account_view` t2
        on t1.created_user_id = t2.user_id
        where t2.user_id is not null
            and REGEXP_CONTAINS(t1.avatar_url, r'swap_face')

        UNION ALL

        select
            distinct dt_param as dt, 'only_custom_avatar_try_on_user' AS user_gruop, t2.last_device_id AS device_id
        from (
            select distinct created_user_id
            from favie_dw.dim_try_on_user_task_view
            group by created_user_id 
            having countif(REGEXP_CONTAINS(avatar_url, r'swap_face'))>0 
                and countif(NOT REGEXP_CONTAINS(avatar_url, r'swap_face'))=0
        ) t1 
        left join `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d` t2
        on t1.created_user_id = t2.user_id
        where t2.last_device_id is not null

        UNION ALL

        select
            distinct dt_param as dt, 'only_default_avatar_try_on_user_account' AS user_group, t2.last_device_id AS device_id
        from (
            select created_user_id
            from favie_dw.dim_try_on_user_task_view
            group by created_user_id 
            having countif(REGEXP_CONTAINS(avatar_url, r'swap_face'))=0
        ) t1
        left join `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d` t2
        on t1.created_user_id = t2.user_id
        where t2.last_device_id is not null



    ),

    user_other_groups as (
        select 
            t1.dt,
            t1.user_group,
            t1.device_id,
            t2.appsflyer_id,
            t2.user_activity_type,
            t2.country_name,
            t2.platform,
            t2.app_version,
            t2.user_login_type,
            t2.user_tenure_segment,
            t2.user_tenure_type,
            t2.ad_source,
            t2.ad_group_id,
            t2.ad_campaign_id,
            t2.ad_id
        from user_other_groups_base t1
        left outer join user_all_group t2
        on t1.device_id = t2.device_id
        where t2.device_id is not null
    )

    SELECT 
        dt,
        user_group,
        device_id,
        appsflyer_id,
        user_activity_type,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_segment,
        user_tenure_type,
        ad_source,
        ad_group_id,
        ad_campaign_id,
        ad_id
    FROM user_all_group
    UNION all
    SELECT 
        dt,
        user_group,
        device_id,
        appsflyer_id,
        user_activity_type,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_segment,
        user_tenure_type,
        ad_source,
        ad_group_id,
        ad_campaign_id,
        ad_id
    FROM user_other_groups