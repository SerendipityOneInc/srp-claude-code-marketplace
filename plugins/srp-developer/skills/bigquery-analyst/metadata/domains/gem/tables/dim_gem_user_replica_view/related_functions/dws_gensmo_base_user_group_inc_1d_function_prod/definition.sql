WITH refer_base_data AS (
        SELECT 
            dt,
            device_id,
            refer,
            ap_name,
            event_name,
            COALESCE(event_method, 'unknown') AS event_method,
            COALESCE(event_action_type, 'unknown') AS event_action_type,
            app_version,
            event_timestamp,
            event_ab_infos,
            event_version,
            event_items
        FROM srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND event_version IS NOT NULL
            AND event_version = '1.0.0'
            and app_version not like '%internal%'
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
            and app_version not like '%internal%'
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

    common_user_group_base AS (
        SELECT
            dt,
            device_id,

            MAX(CASE WHEN 
                (ap_name = 'ap_avatar_generate_btn'
                OR (ap_name = 'ap_confirm_btn' AND refer IN ('select_model','avatar_confirm')))
                THEN 1 ELSE 0 END) AS ua_avatar_complete,

            MAX(CASE WHEN 
                refer = 'feed_detail' AND event_method = 'page_view'
                THEN 1 ELSE 0 END) AS ua_feed_detail_view,

            MAX(CASE WHEN 
                event_action_type IN ('collage_gen_complete','product_search_complete')
                THEN 1 ELSE 0 END) AS ua_search_complete,

            MAX(CASE WHEN 
                event_action_type = 'collage_gen_complete'
                THEN 1 ELSE 0 END) AS ua_collage_gen_complete,

            MAX(CASE WHEN 
                event_action_type = 'product_search_complete'
                THEN 1 ELSE 0 END) AS ua_product_search_complete,

            MAX(CASE WHEN 
                event_action_type = 'try_on_complete'
                AND (
                    NOT EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_complete_status')
                    OR EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_complete_status' AND e.item_name IN ('completed','success'))
                )
                THEN 1 ELSE 0 END) AS ua_try_on_complete,

            MAX(CASE WHEN 
                event_action_type='try_on_complete'
                AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_complete_status' AND e.item_name NOT IN ('completed','success'))
                AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_type' AND e.item_name='try_on_scene')
                AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_scenario_collage')
                THEN 1 ELSE 0 END) AS ua_try_on_regular_complete,

            MAX(CASE WHEN 
                (
                    event_action_type='try_on_complete'
                    AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_complete_status' AND e.item_name NOT IN ('completed','success'))
                    AND (
                        EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_type' AND e.item_name='try_on_scene')
                        OR EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_scenario_collage')
                    )
                )
                or 
                (
                    event_action_type = 'vibe_gen_complete'
                )
                THEN 1 ELSE 0 END) AS ua_try_on_scene_complete,

            MAX(CASE WHEN refer IN ('home_v3','home','feed') AND event_method = 'page_view' THEN 1 ELSE 0 END) AS ua_home_view,

            MAX(CASE WHEN 
                refer='home_v3' AND ap_name='ap_input_box'
                THEN 1 ELSE 0 END) AS ua_home_initialize_search,

            MAX(CASE WHEN
                refer='home_v3' AND ap_name IN ('ap_generate_btn','ap_send_message_btn','ap_outer_send_message_btn')
                THEN 1 ELSE 0 END) AS ua_home_send_query,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point'
                AND (
                    EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name='Image Search' or e.item_id = '10004'))
                    OR (
                    EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND e.item_name='Find Dupes')
                    AND CAST(REGEXP_EXTRACT(app_version,'^(\\d+)') AS INT)*100
                        + CAST(REGEXP_EXTRACT(app_version,'^\\d+\\.(\\d+)') AS INT) < 304
                    )
                )
                THEN 1 ELSE 0 END) AS ua_home_image_search_click,

            MAX(CASE WHEN 
                refer='dupes' AND ap_name='ap_product_list' AND event_name='view_item_list'
                THEN 1 ELSE 0 END) AS ua_image_search_result_view,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point' and event_method='click'
                AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name='Style an item' or e.item_id = '10003'))
                THEN 1 ELSE 0 END) AS ua_home_styling_click,

            MAX(CASE WHEN 
                ap_name in ('bd_search_attached_photo','bd_styling_attached_photo') AND event_method = 'auto_trigger'
                THEN 1 ELSE 0 END) AS ua_styling_search_trigger,

            MAX(CASE WHEN 
                refer IN ('feed','home') AND event_method = 'page_view' 
                THEN 1 ELSE 0 END) AS ua_feed_view,

            MAX(CASE WHEN 
                refer='brand' AND event_method='page_view'
                THEN 1 ELSE 0 END) AS ua_brand_view,

            MAX(CASE WHEN 
                refer='brand_detail' AND event_method='page_view'
                THEN 1 ELSE 0 END) AS ua_brand_detail_view,

            MAX(CASE WHEN 
                (
                    ap_name='ap_key_entry_point' and event_method='click'
                    AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND e.item_id = '10005')
                )
                or (
                    ap_name = 'ap_navibar_savyo' and event_method='click'
                )
                THEN 1 ELSE 0 END) AS ua_savyo_view,

            MAX(CASE WHEN 
                refer='profile' AND event_method='page_view'
                THEN 1 ELSE 0 END) AS ua_profile_view,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point' and event_method='click'
                AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name IN ('Virtual Try On','Daily Try-On') or e.item_id = '10001'))
                THEN 1 ELSE 0 END) AS ua_home_try_on_click,

            MAX(CASE WHEN 
                refer='try_on_lite' AND event_action_type='try_on_request'
                THEN 1 ELSE 0 END) AS ua_try_on_lite_request,

            MAX(CASE WHEN 
                event_action_type='try_on_complete'
                AND refer='try_on_lite'
                AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_type' AND e.item_name='try_on_scene')
                AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_scenario_collage')
                AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_complete_status' AND e.item_name NOT IN ('completed','success'))
                THEN 1 ELSE 0 END) AS ua_try_on_lite_regular_complete,

            MAX(CASE WHEN 
                (
                    event_action_type='try_on_complete'
                    AND refer='try_on_lite'
                    AND (
                        EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_type' AND e.item_name='try_on_scene')
                        OR EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_scenario_collage')
                    )
                    AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='try_on_complete_status' AND e.item_name NOT IN ('completed','success'))
                )
                or 
                (
                    event_action_type = 'vibe_gen_complete'
                    AND refer='try_on_lite'
                )
                THEN 1 ELSE 0 END) AS ua_try_on_lite_scene_complete,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point' and event_method='click'
                AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name='Outfit of the Day' or e.item_id = '20001'))
                THEN 1 ELSE 0 END) AS ua_home_ootd_click,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point' and event_method='click'
                AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name IN ('Couple Try On','Couple Try-On') or e.item_id = '10002'))
                THEN 1 ELSE 0 END) AS ua_home_group_photo_click,

            MAX(CASE WHEN 
                event_action_type = 'group_photo_gen_complete'
                THEN 1 ELSE 0 END) AS ua_group_photo_gen_complete,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point' and event_method='click'
                AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name='Xmas Gift List Planner' or e.item_id = '10006'))
                THEN 1 ELSE 0 END) AS ua_home_gift_click,

            MAX(CASE WHEN 
                ap_name='ap_key_entry_point' and event_method='click'
                AND CAST(REGEXP_EXTRACT(app_version,'^(\\d+)') AS INT)*100
                    + CAST(REGEXP_EXTRACT(app_version,'^\\d+\\.(\\d+)') AS INT) >= 304
                AND EXISTS(SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type='key_entry_feature' AND (e.item_name='Find Dupes' or e.item_id = '10005'))
                THEN 1 ELSE 0 END) AS ua_home_dupes_click,

            MAX(CASE WHEN 
                event_action_type='save' AND refer!='open_collage'
                THEN 1 ELSE 0 END) AS ua_save,

            MAX(CASE WHEN 
                refer IN ('home_v3','navibar') AND event_method='click'
                THEN 1 ELSE 0 END) AS ua_home_v3_click,

            MAX(CASE WHEN 
                event_action_type in (
                    'collage_gen_complete'
                    ,'try_on_complete'
                    ,'group_photo_gen_complete'
                    ,'product_search_complete'
                    ,'avatar_gen_complete'
                    ,'video_gen_complete'
                    ,'message_gen_complete'
                    ,'vibe_gen_complete'
                )
                or (refer = 'feed_detail' and event_method = 'page_view')
                or (refer='dupes' AND ap_name='ap_product_list' AND event_name='view_item_list')
                THEN 1 ELSE 0 END) AS ua_any_key_feature_complete,

            MAX(CASE WHEN event_action_type = 'try_on_trigger'
                    AND refer = 'try_on_lite'
                    AND ap_name = 'ap_try_on_lite_inspo'
                THEN 1 ELSE 0 END) AS ua_operation_try_on_trigger,

            MAX(CASE WHEN event_action_type = 'try_on_trigger'
                    AND refer = 'try_on_lite'
                    AND ap_name = 'bd_try_on_attached_photo'
                THEN 1 ELSE 0 END) AS ua_upload_try_on_trigger,

            MAX(CASE WHEN refer IN ('product_detail', 'pseudo_product_detail', 'product_search_detail', 'product_detail_from_search')
                    AND event_name = 'select_item'
                    AND event_method = 'page_view'
                THEN 1 ELSE 0 END) AS ua_product_detail_view,

            MAX(CASE WHEN event_action_type = 'product_external_jump' 
                THEN 1 ELSE 0 END) AS ua_product_external_jump,

            MAX(CASE WHEN event_action_type = 'save' 
                and EXISTS (select 1 from unnest(event_items) e where e.item_type = 'product') 
                THEN 1 ELSE 0 END) AS ua_product_save,

            MAX(CASE WHEN event_action_type = 'save' 
                and EXISTS (select 1 from unnest(event_items) e where e.item_type = 'collage_gen_task') 
                THEN 1 ELSE 0 END) AS ua_collage_save,

            MAX(CASE WHEN event_action_type = 'save' 
                and EXISTS (select 1 from unnest(event_items) e where e.item_type = 'try_on_task') 
                THEN 1 ELSE 0 END) AS ua_try_on_save,

            MAX(CASE WHEN
                    event_action_type in ('try_on_trigger')
                    THEN 1 ELSE 0 END) AS ua_try_on_trigger,

            MAX(CASE WHEN refer='try_on_lite'
            and event_action_type = 'dupe_search_trigger'
                then 1 else 0 end) as ua_daily_tryon_find,    

            MAX(CASE WHEN event_action_type = 'video_gen_complete'
                THEN 1 ELSE 0 END) AS ua_video_gen_complete,

            MAX(CASE WHEN event_action_type = 'top_up_complete'
                THEN 1 ELSE 0 END) AS ua_top_up_complete,

            MAX(CASE WHEN event_action_type = 'task_redeem_complete'
                THEN 1 ELSE 0 END) AS ua_task_redeem_complete,

            MAX(CASE WHEN refer = 'out_of_credits_popup' and event_method = 'page_view'
                THEN 1 ELSE 0 END) AS ua_hit_credit_limit,

            MAX(CASE WHEN ap_name in ('ap_series_slot', 'ap_series_item_slot') and event_method = 'click'
                THEN 1 ELSE 0 END) AS ua_series_slot_click,

            MAX(CASE WHEN event_action_type = 'message_gen_complete' 
                THEN 1 ELSE 0 END) AS ua_message_gen_complete,

            MAX(CASE WHEN event_action_type = 'message_gen_complete' 
                and exists(select 1 from unnest(event_items) e where e.item_type = 'message_feature' and e.item_name = 'ootd')
                THEN 1 ELSE 0 END) AS ua_ootd_message_gen_complete,

        FROM refer_base_data
        GROUP BY dt, device_id
    ),

    common_user_group as (
      SELECT
            dt,
            device_id,
            metric_name AS user_group
      FROM common_user_group_base
      CROSS JOIN UNNEST([
            STRUCT('ua_avatar_complete' as metric_name, ua_avatar_complete as metric_value),
            STRUCT('ua_feed_detail_view', ua_feed_detail_view),
            STRUCT('ua_search_complete', ua_search_complete),
            STRUCT('ua_collage_gen_complete', ua_collage_gen_complete),
            STRUCT('ua_product_search_complete', ua_product_search_complete),
            STRUCT('ua_try_on_complete', ua_try_on_complete),
            STRUCT('ua_try_on_regular_complete', ua_try_on_regular_complete),
            STRUCT('ua_try_on_scene_complete', ua_try_on_scene_complete),
            STRUCT('ua_home_view', ua_home_view),
            STRUCT('ua_home_initialize_search', ua_home_initialize_search),
            STRUCT('ua_home_send_query', ua_home_send_query),
            STRUCT('ua_home_image_search_click', ua_home_image_search_click),
            STRUCT('ua_image_search_result_view', ua_image_search_result_view),
            STRUCT('ua_home_styling_click', ua_home_styling_click),
            STRUCT('ua_styling_search_trigger', ua_styling_search_trigger),
            STRUCT('ua_feed_view', ua_feed_view),
            STRUCT('ua_brand_view', ua_brand_view),
            STRUCT('ua_brand_detail_view', ua_brand_detail_view),
            STRUCT('ua_home_try_on_click', ua_home_try_on_click),
            STRUCT('ua_try_on_lite_request', ua_try_on_lite_request),
            STRUCT('ua_try_on_lite_regular_complete', ua_try_on_lite_regular_complete),
            STRUCT('ua_try_on_lite_scene_complete', ua_try_on_lite_scene_complete),
            STRUCT('ua_home_ootd_click', ua_home_ootd_click),
            STRUCT('ua_home_group_photo_click', ua_home_group_photo_click),
            STRUCT('ua_group_photo_gen_complete', ua_group_photo_gen_complete),
            STRUCT('ua_home_gift_click', ua_home_gift_click),
            STRUCT('ua_home_dupes_click', ua_home_dupes_click),
            STRUCT('ua_save', ua_save),
            STRUCT('ua_home_v3_click', ua_home_v3_click),
            STRUCT('ua_any_key_feature_complete', ua_any_key_feature_complete),
            STRUCT('ua_operation_try_on_trigger', ua_operation_try_on_trigger),
            STRUCT('ua_upload_try_on_trigger', ua_upload_try_on_trigger),
            STRUCT('ua_product_detail_view', ua_product_detail_view),
            STRUCT('ua_product_external_jump', ua_product_external_jump),
            STRUCT('ua_product_save', ua_product_save),
            STRUCT('ua_collage_save', ua_collage_save),
            STRUCT('ua_try_on_save', ua_try_on_save),
            STRUCT('ua_try_on_trigger', ua_try_on_trigger),
            struct('ua_daily_tryon_find',ua_daily_tryon_find),
            struct('ua_video_gen_complete',ua_video_gen_complete),
            struct('ua_top_up_complete',ua_top_up_complete),
            struct('ua_task_redeem_complete',ua_task_redeem_complete),
            struct('ua_hit_credit_limit',ua_hit_credit_limit),
            struct('ua_series_slot_click',ua_series_slot_click),
            struct('ua_savyo_view',ua_savyo_view),
            struct('ua_profile_view',ua_profile_view),
            struct('ua_message_gen_complete',ua_message_gen_complete),
            struct('ua_ootd_message_gen_complete',ua_ootd_message_gen_complete)
      ])
      WHERE metric_value = 1
      ORDER BY dt, device_id, user_group
    ),

    try_on_avatar_task_base as (
        select 
            dt,
            device_id,
            countif(user_model_type = "use_default_model") as default_model_cnt,
            countif(user_model_type = "custom_model") as custom_model_cnt,
        from(
            select 
                dt_param as dt,
                t1.created_user_id,
                t2.device_id,
                case when t1.use_default_model is not null and t1.use_default_model = true then "use_default_model" else "custom_model" end as user_model_type,
            from (select * from srpproduct-dc37e.favie_dw.dim_try_on_user_task_view where date(created_time) = dt_param) t1
            left join `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function`(dt_param) t2
            on t1.created_user_id = t2.user_id
            where t1.status = 'completed'
                and t1.tryon_router is null
                and t2.device_id is not null 
        )
        group by dt,device_id
    ),

    try_on_avatar_user_group_base AS (
        select 
            dt,
            device_id,
            -- home related user groups
            MAX(CASE WHEN custom_model_cnt>0 THEN 1 ELSE 0 END) AS custom_avatar_try_on_user,
            MAX(CASE WHEN custom_model_cnt>0 and default_model_cnt=0 THEN 1 ELSE 0 END) AS only_custom_avatar_try_on_user,
            MAX(CASE WHEN default_model_cnt>0 and custom_model_cnt=0 THEN 1 ELSE 0 END) AS only_default_avatar_try_on_user_account,
        from try_on_avatar_task_base
        group by dt, device_id
    ),

    try_on_avatar_user_group AS (
        SELECT
            dt,
            device_id,
            metric_name AS user_group
            FROM try_on_avatar_user_group_base
            CROSS JOIN UNNEST([
                    -- avatar related user groups
                    STRUCT('custom_avatar_try_on_user' AS metric_name, custom_avatar_try_on_user AS metric_value),
                    STRUCT('only_custom_avatar_try_on_user', only_custom_avatar_try_on_user),
                    STRUCT('only_default_avatar_try_on_user_account', only_default_avatar_try_on_user_account)
                ]
            )
            WHERE metric_value = 1
            ORDER BY dt, device_id, user_group
    ),

    post_activity_base AS (
        select 
            dt_param as dt,
            device_id,
            sum(data_value) as post_count
        from favie_dw.dws_gensmo_refer_general_metrics_inc_1d
        where dt = dt_param
            and data_name = 'refer_ap_click_cnt'
            and event_action_type = 'post'
            and data_value is not null
        group by device_id
    ),

    post_user_group_base AS (
        select 
            dt,
            device_id,
            -- post related user groups
            MAX(CASE WHEN post_count = 1 THEN 1 ELSE 0 END) AS poster,
            MAX(CASE WHEN post_count > 1 THEN 1 ELSE 0 END) AS creator
        from post_activity_base
        group by dt, device_id
    ),

    post_user_group AS (
        SELECT
            dt,
            device_id,
            metric_name AS user_group
            FROM post_user_group_base
            CROSS JOIN UNNEST([
                    -- post related user groups
                    STRUCT('poster' AS metric_name, poster AS metric_value),
                    STRUCT('creator', creator)
                ]
            )
            WHERE metric_value = 1
            ORDER BY dt, device_id, user_group
    ),

    user_other_groups AS (        
        -- 包含通用用户组
        select 
            distinct dt as dt, user_group, device_id
        from common_user_group

        UNION ALL

        -- 包含试穿头像用户组
        select 
            distinct dt as dt, user_group, device_id
        from try_on_avatar_user_group

        UNION ALL

        -- 包含发布活动用户组
        select 
            distinct dt as dt, user_group, device_id
        from post_user_group

        UNION ALL

        SELECT DISTINCT t1.dt, 
            'ab_' || t1.project || '@' || t1.router || '@' || t1.unique_id AS user_group,
            t1.device_id
        FROM ab_base t1
        LEFT JOIN ab_valid t2
        ON t1.project = t2.project and t1.dt = t2.dt
        where t2.project is not null

        UNION ALL

        SELECT 
            DISTINCT dt_param AS dt, 'have_custom_avatar' AS user_group, 
            t2.device_id
        FROM srpproduct-dc37e.favie_dw.dim_gem_user_replica_view t1
        LEFT JOIN favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function(dt_param)  t2
        ON t1.user_id = t2.user_id
    )

    SELECT 
        dt,
        user_group,
        device_id
    FROM user_other_groups