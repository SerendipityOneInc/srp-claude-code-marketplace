CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_user_behavior_wide_inc_1d_view`
AS SELECT  task_id --new
       ,sku_id 
       ,search_query_type -- new 
       --,registered_status -- new
       --,created_date       AS user_created_date -- new
       --,updated_date       AS user_updated_date -- new
       --,geos  as user_history_geos -- new
       --,last_continent -- new
       --,last_sub_continent -- new
       --,last_country -- new
       --,last_region -- new
       --,last_metro -- new
       --,last_city -- new
       ,event_name
       ,event_date
       ,stream_id
       ,is_active_user
       ,user_pseudo_id
       ,event_time
       ,event_timestamp
       ,operating_system
       ,items
       ,timestamp_offset
       ,ga_app_version
       ,country
       ,city
       ,region
       ,metro
       ,sub_continent
       ,continent
       ,geo
       ,engagement_time_sec
       ,a.user_id          AS user_id
       ,item_id
       ,number
       ,a.round            AS round
       ,refer
       ,if_preference
       ,utm_source
       ,query_id
       ,app_version
       ,platform
       ,engagement_platform
       ,click_src
       ,input_type
       ,item_list_name
       ,action_type
       ,search_term
       ,method
       ,creative_name
       ,promotion_name
       ,item_name
       ,user_type
       ,gensmo_active_id
       ,ga_session_id
       ,a.query_session_id AS query_session_id
       ,ab_infos
       ,item_list_id
       ,a.dt               AS dt
FROM
(
	SELECT  event_name
	       ,event_date
	       ,stream_id
	       ,is_active_user
	       ,user_pseudo_id
	       ,event_time
	       ,event_timestamp
	       ,operating_system
	       ,items
	       ,timestamp_offset
	       ,ga_app_version
	       ,country
	       ,city
	       ,region
	       ,metro
	       ,sub_continent
	       ,continent
	       ,geo
	       ,engagement_time_sec
	       ,user_id
	       ,item_id
	       ,number
	       ,round
	       ,refer
	       ,if_preference
	       ,utm_source
	       ,query_id
	       ,app_version
	       ,platform
	       ,engagement_platform
	       ,click_src
	       ,input_type
	       ,item_list_name
	       ,action_type
	       ,search_term
	       ,method
	       ,creative_name
	       ,promotion_name
	       ,item_name
	       ,user_type
	       ,gensmo_active_id
	       ,ga_session_id
	       ,query_session_id
	       ,ab_infos
	       ,item_list_id
	       ,dt
	       ,sku_id
	       ,search_query_type
	FROM `favie_dw.dwd_gem_base_user_behavior_inc_1d_view`
   
) a
LEFT JOIN
(
	SELECT  item_list_id AS task_id
	       ,query_session_id
	       ,round
	FROM
	(
		SELECT  item_list_id
		       ,query_session_id
		       ,round
		       ,ROW_NUMBER() over(PARTITION BY query_session_id,round ) AS rw
		FROM `favie_dw.dwd_gem_base_user_behavior_inc_1d_view`
		WHERE item_list_name = 'collage_list'
		AND event_name = 'view_item_list'
		AND item_list_id IS NOT NULL
	)
	WHERE rw = 1 
) b
--round这个数在collage粒度上没有上报,所以为了能有数据,这里不需要关联round
ON a.query_session_id = b.query_session_id;