CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_genmso_user_recap_frequency_rank`
AS SELECT  
        a.user_id
        ,dt
        ,platform
        ,geo_country_name
        ,active_cnt
        ,app_open_cnt
        ,app_foreground_cnt
        ,app_exit_cnt
        ,avatar_create_cnt
        ,search_cnt
        ,try_on_cnt
        ,try_on_scene_cnt
        ,feed_detail_view_cnt
        ,feed_detail_view_item_list_cnt
        ,dupe_search_trigger_cnt
        ,dupe_result_view_cnt
FROM
(
	SELECT  user_id
	       ,dt
	       ,platform
               ,geo_country_name
	       ,COUNT(1) AS active_cnt
	       ,SUM(CASE WHEN event_method = 'app_launch' THEN 1 ELSE 0 END) AS app_open_cnt
	       ,SUM(CASE WHEN event_method = 'app_foreground' THEN 1 ELSE 0 END) AS app_foreground_cnt
	       ,SUM(CASE WHEN event_method = 'app_background' THEN 1 ELSE 0 END) AS app_exit_cnt
	       ,SUM(CASE WHEN refer = 'avatar_manage' AND ap_name = 'ap_create_new_avatar_btn' AND event_name = 'select_item' AND event_method = 'click' THEN 1 ELSE 0 END) AS avatar_create_cnt
	       ,SUM(CASE WHEN event_action_type = 'collage_gen_complete' THEN 1 ELSE 0 END) AS search_cnt
	       ,SUM(CASE WHEN event_action_type = 'try_on_complete' 
	            AND NOT EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type = 'try_on_complete_status' AND e.item_name NOT IN ('completed','success')) 
	            AND NOT EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type = 'try_on_type' AND e.item_name = 'try_on_scene')
	            AND NOT EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type = 'try_on_scenario_collage') THEN 1 ELSE 0 END) AS try_on_cnt
	       ,SUM(CASE WHEN event_action_type = 'try_on_complete' 
	            AND NOT EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type = 'try_on_complete_status' AND e.item_name NOT IN ('completed','success')) 
	            AND (EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type = 'try_on_type' AND e.item_name = 'try_on_scene')
	                 OR EXISTS (SELECT 1 FROM UNNEST(event_items) e WHERE e.item_type = 'try_on_scenario_collage')) THEN 1 ELSE 0 END) AS try_on_scene_cnt
	       ,SUM(CASE WHEN refer = 'feed_detail' AND event_method = 'page_view' THEN 1 ELSE 0 END) AS feed_detail_view_cnt
	       ,SUM(CASE WHEN refer = 'feed_detail' AND event_name = 'view_item_list' THEN 1 ELSE 0 END) AS feed_detail_view_item_list_cnt
	       ,SUM(CASE WHEN (event_action_type = 'dupe_search_trigger' AND ap_name = 'ap_shop_bag_btn') 
	                   OR (event_action_type = 'image_upload_success' AND ap_name = 'bd_dupes_attached_photo') THEN 1 ELSE 0 END) AS dupe_search_trigger_cnt
	       ,SUM(CASE WHEN refer = 'dupes' AND ap_name = 'ap_product_list' AND event_name = 'view_item_list' THEN 1 ELSE 0 END) AS dupe_result_view_cnt
	FROM favie_dw.dwd_favie_gensmo_events_inc_1d
	WHERE event_version = '1.0.0'
	AND event_timestamp is not null
	AND event_timestamp != TIMESTAMP('1970-01-01 00:00:00 UTC')
	AND user_id != 'unknown'
	AND user_id is not null
	GROUP BY  user_id
	         ,dt
	         ,platform
                 ,geo_country_name
)a;