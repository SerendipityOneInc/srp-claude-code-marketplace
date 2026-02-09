CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_tiktok_fivetran_ad_id_inc_1d_view`
AS SELECT  Date(a.stat_time_day)                                                                                               AS dt
       ,'Tiktok Ads'                                                                                                     AS source
       ,CASE WHEN LOWER(d.campaign_name) LIKE '%ios%' THEN 'IOS'
             WHEN LOWER(d.campaign_name) LIKE '%android%' THEN 'ANDROID'  ELSE 'UNKNOWN' END                          AS platform
       ,CASE WHEN LOWER(e.name) LIKE '%gensmo%' THEN 'Gensmo'
             WHEN LOWER(e.name) LIKE '%decofy%' THEN 'Decofy'
			 when lower(e.name) like '%savyo%' then 'Savyo'  ELSE 'UNKNOWN' END                                     AS app_name
       ,cast(b.advertiser_id AS string)                                                                               AS account_id
       ,e.name                                                                                                        AS account_name
       ,cast(b.campaign_id AS string)                                                                                 AS campaign_id
       ,d.campaign_name                                                                                               AS campaign_name
       ,cast(b.adgroup_id AS string)                                                                                  AS ad_group_id
       ,c.adgroup_name                                                                                                AS ad_group_name
       ,cast(a.ad_id AS string)                                                                                       AS ad_id
       ,b.ad_name                                                                                                     AS ad_name
	   ,case when b.tiktok_item_id is not null  then 'KOL' else 'NON_KOL' end 									      AS ad_category
	   ,tiktok_item_id
       ,CASE WHEN c.location IS NOT NULL THEN REGEXP_EXTRACT(c.location,r'\"([A-Z]{2})\"')
             WHEN e.promotion_area IS NOT NULL THEN REGEXP_EXTRACT(e.promotion_area,r'\"([A-Z]{2})\"')  ELSE 'US' END AS country_code
       ,a.impressions                                                                                                 AS impression
       ,a.clicks                                                                                                      AS click
       ,a.spend                                                                                                       AS cost
       ,COALESCE(a.conversion,0)                                                                                      AS conversion
FROM
(
	SELECT  total_onsite_on_web_detail_value
	       ,anchor_clicks
	       ,total_user_registration_value
	       ,total_on_web_add_to_wishlist_value
	       ,dpa_target_audience_type
	       ,value_per_onsite_on_web_detail
	       ,video_watched_2_s
	       ,user_registration
	       ,video_views_p_25
	       ,total_sales_lead
	       ,total_view_content
	       ,cost_per_vta_purchase
	       ,total_checkout_value
	       ,ctr
	       ,cta_purchase
	       ,cost_per_user_registration
	       ,cost_per_onsite_on_web_cart
	       ,skan_sales_lead
	       ,onsite_shopping_rate
	       ,value_per_complete_payment
	       ,cost_per_total_add_to_wishlist
	       ,result_rate
	       ,skan_total_sales_lead
	       ,secondary_goal_result_rate
	       ,value_per_onsite_shopping
	       ,cost_per_pageview
	       ,product_details_page_browse_rate
	       ,onsite_shopping
	       ,cost_per_onsite_shopping
	       ,purchase_rate
	       ,cost_per_web_event_add_to_cart
	       ,shares
	       ,result
	       ,onsite_on_web_cart
	       ,stat_time_day
	       ,value_per_on_web_add_to_wishlist
	       ,cost_per_onsite_initiate_checkout_count
	       ,pageview_rate
	       ,cost_per_cta_purchase
	       ,real_time_conversion
	       ,total_registration
	       ,cost_per_complete_payment
	       ,onsite_initiate_checkout_count_rate
	       ,add_to_wishlist
	       ,web_event_add_to_cart_rate
	       ,complete_payment_rate
	       ,complete_payment
	       ,total_pageview
	       ,total_onsite_on_web_cart_value
	       ,anchor_click_rate
	       ,cost_per_total_view_content
	       ,cost_per_download_start
	       ,duet_clicks
	       ,total_sales_lead_value
	       ,sound_usage_clicks
	       ,onsite_shopping_roas
	       ,cost_per_on_web_subscribe
	       ,cost_per_initiate_checkout
	       ,cta_registration
	       ,vta_app_install
	       ,real_time_result
	       ,cost_per_cta_registration
	       ,onsite_on_web_detail_rate
	       ,app_event_add_to_cart
	       ,onsite_on_web_cart_rate
	       ,total_onsite_shopping_value
	       ,cost_per_app_event_add_to_cart
	       ,on_web_add_to_wishlist_per_click
	       ,cost_per_total_app_event_add_to_cart
	       ,initiate_checkout_rate
	       ,cost_per_1000_reached
	       ,total_add_to_wishlist
	       ,tt_playlist_visit
	       ,profile_visits_rate
	       ,cost_per_add_to_wishlist
	       ,view_content_rate
	       ,cost_per_vta_conversion
	       ,average_video_play
	       ,ix_video_views_p_25
	       ,average_video_play_per_user
	       ,cost_per_product_details_page_browse
	       ,sales_lead
	       ,product_details_page_browse
	       ,engagement_rate
	       ,total_view_content_value
	       ,on_web_subscribe_per_click
	       ,cost_per_total_purchase
	       ,video_play_actions
	       ,value_per_user_registration
	       ,engagements
	       ,value_per_onsite_initiate_checkout_count
	       ,checkout
	       ,conversion
	       ,onsite_on_web_detail
	       ,total_product_details_page_browse_value
	       ,total_app_event_add_to_cart
	       ,purchase
	       ,cost_per_page_event_search
	       ,cost_per_total_checkout
	       ,on_web_subscribe
	       ,web_event_add_to_cart
	       ,skan_conversion
	       ,cost_per_secondary_goal_result
	       ,onsite_initiate_checkout_count
	       ,vta_purchase
	       ,clicks
	       ,add_to_wishlist_rate
	       ,real_time_cost_per_conversion
	       ,total_on_web_subscribe_value
	       ,value_per_checkout
	       ,value_per_total_view_content
	       ,value_per_on_web_subscribe
	       ,reach
	       ,ix_average_video_play
	       ,total_landing_page_view
	       ,value_per_web_event_add_to_cart
	       ,video_watched_6_s
	       ,total_download_start_value
	       ,cost_per_checkout
	       ,total_purchase
	       ,value_per_download_start
	       ,skan_cost_per_conversion
	       ,clicks_on_music_disc
	       ,clicks_on_hashtag_challenge
	       ,cta_app_install
	       ,download_start
	       ,ix_page_viewrate_avg
	       ,ad_id
	       ,ix_video_views_p_100
	       ,real_time_cost_per_result
	       ,total_page_event_search_value
	       ,registration
	       ,real_time_conversion_rate
	       ,value_per_onsite_on_web_cart
	       ,ix_page_duration_avg
	       ,app_event_add_to_cart_rate
	       ,user_registration_rate
	       ,value_per_total_add_to_wishlist
	       ,cost_per_result
	       ,initiate_checkout
	       ,avg_value_per_pageview
	       ,total_value_per_pageview
	       ,conversion_rate
	       ,cost_per_conversion
	       ,value_per_total_app_event_add_to_cart
	       ,total_initiate_checkout_value
	       ,view_content
	       ,checkout_rate
	       ,video_views_p_75
	       ,impressions
	       ,registration_rate
	       ,value_per_total_purchase
	       ,cost_per_view_content
	       ,value_per_product_details_page_browse
	       ,page_event_search_rate
	       ,value_per_initiate_checkout
	       ,ix_video_views_p_50
	       ,cost_per_purchase
	       ,cost_per_registration
	       ,secondary_goal_result
	       ,on_web_add_to_wishlist
	       ,ix_video_views
	       ,total_checkout
	       ,total_onsite_initiate_checkout_count_value
	       ,cpc
	       ,total_app_event_add_to_cart_value
	       ,cost_per_onsite_on_web_detail
	       ,likes
	       ,cpm
	       ,tt_playlist_visit_rate
	       ,ix_video_views_p_75
	       ,follows
	       ,total_purchase_value
	       ,cost_per_on_web_add_to_wishlist
	       ,value_per_page_event_search
	       ,total_add_to_wishlist_value
	       ,cta_conversion
	       ,vta_registration
	       ,page_event_search
	       ,cost_per_total_registration
	       ,skan_total_sales_lead_value
	       ,total_complete_payment_rate
	       ,video_views_p_50
	       ,spend
	       ,stitch_clicks
	       ,total_active_pay_roas
	       ,vta_conversion
	       ,comments
	       ,download_start_rate
	       ,cost_per_landing_page_view
	       ,video_views_p_100
	       ,real_time_result_rate
	       ,cost_per_vta_registration
	       ,total_web_event_add_to_cart_value
	       ,landing_page_view_rate
	       ,profile_visits
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.ad_report_daily`
) a
LEFT JOIN
(
	SELECT  ad_id
	       ,advertiser_id
	       ,adgroup_id
	       ,campaign_id
	       ,ad_name
	       ,create_time
	       ,updated_at
	       ,operation_status
	       ,secondary_status
		   ,tiktok_item_id
	FROM
	(
		SELECT  ad_id
		       ,advertiser_id
		       ,adgroup_id
		       ,campaign_id
		       ,ad_name
		       ,create_time
		       ,updated_at
		       ,operation_status
		       ,secondary_status
			   ,tiktok_item_id
		       ,ROW_NUMBER() OVER (PARTITION BY ad_id ORDER BY  updated_at DESC) AS rk
		FROM `srpproduct-dc37e.fivetran_tiktok_ads.ad_history`
	)t1
	WHERE rk = 1 
) b
ON a.ad_id = b.ad_id
LEFT JOIN
(
	SELECT  adgroup_id
	       ,advertiser_id
	       ,campaign_id
	       ,adgroup_name
	       ,create_time
	       ,updated_at
	       ,placement_type
	       ,optimization_goal
	       ,audience_type
	       ,gender
	       ,age_groups
	       ,languages
	       ,operating_systems
	       ,network_types
	       ,location
	       ,interest_category_v_2
	       ,action_categories
	       ,placements
	       ,keywords
	       ,video_actions
	       ,buying_type
	       ,budget
	       ,bid_price
	       ,bid_type
	       ,deep_bid_type
	       ,budget_mode
	       ,schedule_type
	       ,dayparting
	       ,pacing
	       ,billing_event
	       ,frequency
	       ,frequency_schedule
	       ,action_days
	       ,audience
	       ,excluded_audience
	       ,operation_status
	       ,secondary_status
	FROM
	(
		SELECT  adgroup_id
		       ,advertiser_id
		       ,campaign_id
		       ,adgroup_name
		       ,create_time
		       ,updated_at
		       ,placement_type
		       ,optimization_goal
		       ,audience_type
		       ,gender
		       ,age_groups
		       ,languages
		       ,operating_systems
		       ,network_types
		       ,location
		       ,interest_category_v_2
		       ,action_categories
		       ,placements
		       ,keywords
		       ,video_actions
		       ,buying_type
		       ,budget
		       ,bid_price
		       ,bid_type
		       ,deep_bid_type
		       ,budget_mode
		       ,schedule_type
		       ,dayparting
		       ,pacing
		       ,billing_event
		       ,frequency
		       ,frequency_schedule
		       ,action_days
		       ,audience
		       ,excluded_audience
		       ,operation_status
		       ,secondary_status
		       ,ROW_NUMBER() OVER (PARTITION BY adgroup_id ORDER BY  updated_at DESC) AS rk
		FROM srpproduct-dc37e.fivetran_tiktok_ads.adgroup_history
	)t2
	WHERE rk = 1 
) c
ON b.adgroup_id = c.adgroup_id
LEFT JOIN
(
	SELECT  campaign_id
	       ,advertiser_id
	       ,campaign_name
	       ,create_time
	       ,updated_at
	       ,campaign_type
	       ,objective_type
	       ,objective
	       ,budget_mode
	       ,budget
	       ,buying_type
	       ,bid_type
	       ,deep_bid_type
	       ,optimization_goal
	       ,is_search_campaign
	       ,is_smart_performance_campaign
	       ,app_id
	       ,is_advanced_dedicated_campaign
	       ,campaign_app_profile_page_state
	       ,rf_campaign_type
	       ,campaign_product_source
	       ,budget_optimize_on
	       ,roas_bid
	       ,rta_id
	       ,rta_product_selection_enabled
	       ,postback_window_mode
	       ,operation_status
	       ,secondary_status
	FROM
	(
		SELECT  campaign_id
		       ,advertiser_id
		       ,campaign_name
		       ,create_time
		       ,updated_at
		       ,campaign_type
		       ,objective_type
		       ,objective
		       ,budget_mode
		       ,budget
		       ,buying_type
		       ,bid_type
		       ,deep_bid_type
		       ,optimization_goal
		       ,is_search_campaign
		       ,is_smart_performance_campaign
		       ,app_id
		       ,is_advanced_dedicated_campaign
		       ,campaign_app_profile_page_state
		       ,rf_campaign_type
		       ,campaign_product_source
		       ,budget_optimize_on
		       ,roas_bid
		       ,rta_id
		       ,rta_product_selection_enabled
		       ,postback_window_mode
		       ,operation_status
		       ,secondary_status
		       ,ROW_NUMBER() OVER (PARTITION BY campaign_id ORDER BY  updated_at DESC) AS rk
		FROM srpproduct-dc37e.fivetran_tiktok_ads.campaign_history
	)t3
	WHERE rk = 1 
) d
ON b.campaign_id = d.campaign_id
LEFT JOIN
(
	SELECT  id
	       ,name
	       ,company
	       ,country
	       ,currency
	       ,industry
	       ,promotion_area
	       ,status
	       ,timezone
	       ,language
	       ,create_time
	       ,_fivetran_synced
	FROM
	(
		SELECT  id
		       ,name
		       ,company
		       ,country
		       ,currency
		       ,industry
		       ,promotion_area
		       ,status
		       ,timezone
		       ,language
		       ,create_time
		       ,_fivetran_synced
		       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY  _fivetran_synced DESC) AS rk
		FROM srpproduct-dc37e.fivetran_tiktok_ads.advertiser
	)t1
	WHERE rk = 1 
) e
ON b.advertiser_id = e.id;