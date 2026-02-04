WITH internal_user AS (
        SELECT 
            DISTINCT last_device_id
        FROM favie_dw.dim_favie_gensmo_user_account_changelog_1d
        WHERE is_internal_user
    ),
    
    refer_base_data AS (
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
            AND event_version = '1.0.0'
            AND device_id IS NOT NULL
            AND refer IS NOT NULL
            AND refer NOT IN ('unknown', 'app','default') 
            AND event_timestamp IS NOT NULL 
            AND event_timestamp != TIMESTAMP('1970-01-01 00:00:00 UTC')
            AND event_name IS NOT NULL
            AND ap_name IS NOT NULL
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
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_items_inc_1d
        WHERE dt BETWEEN DATE_SUB(dt_param, INTERVAL 7 DAY) AND dt_param
            AND event_version = '1.0.0'
            AND device_id IS NOT NULL
            AND refer IS NOT NULL
            AND refer NOT IN ('unknown', 'app','default') 
            AND event_timestamp IS NOT NULL 
            AND event_timestamp != TIMESTAMP('1970-01-01 00:00:00 UTC')
            AND event_name IS NOT NULL
            AND ap_name IS NOT NULL
    ),

    user_groups AS (
        SELECT DISTINCT dt_param AS dt, 'all' AS user_group, device_id
        FROM favie_dw.dws_favie_gensmo_user_feature_inc_1d
        WHERE dt = dt_param
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'search' AS user_group, device_id
        FROM refer_base_data
        WHERE event_action_type = 'collage_gen'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'feed_detail' AS user_group, device_id
        FROM refer_base_data
        WHERE refer = 'feed_detail'
            AND event_name = 'select_item'
            AND event_method = 'page_view'
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'tryon' AS user_group, device_id
        FROM refer_base_data
        WHERE event_action_type = 'try_on'
        
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
            'ab_' || t2.project || '@' || t2.router || '@' || t2.unique_id AS user_group,
            t1.device_id
        FROM (SELECT DISTINCT dt_param AS dt, SAFE_CAST(ab_unique_id AS INT64) AS ab_unique_id, device_id
              FROM refer_base_data, UNNEST(event_ab_infos) AS ab_unique_id
              WHERE TRIM(COALESCE(ab_unique_id, '')) != '') t1
        LEFT JOIN srpproduct-dc37e.favie_dw.dim_gem_user_ab_config_view t2
        ON t1.ab_unique_id = t2.unique_id
        
        UNION ALL
        
        SELECT DISTINCT dt_param AS dt, 'replica' AS user_group, last_device_id AS device_id
        FROM srpproduct-dc37e.favie_dw.dim_gem_user_replica_view t1
        LEFT JOIN (SELECT user_id, last_device_id FROM favie_dw.dim_favie_gensmo_user_account_full_1d) t2
        ON t1.user_id = t2.user_id
    )

    SELECT 
        t1.dt,
        t1.user_group,
        t1.device_id
    FROM user_groups t1 
    WHERE NOT EXISTS (
        SELECT 1 FROM internal_user t2 
        WHERE t1.device_id = t2.last_device_id
    )