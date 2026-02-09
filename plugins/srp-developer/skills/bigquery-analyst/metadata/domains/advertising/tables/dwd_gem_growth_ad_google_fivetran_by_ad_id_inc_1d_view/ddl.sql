CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_growth_ad_google_fivetran_by_ad_id_inc_1d_view`
AS SELECT 
       dt
      ,'Google Ads'                        AS source
      ,platform
      ,app_name
      ,cast(customer_id AS string) AS account_id
      ,account_name             AS account_name
      ,cast(campaign_id AS string) AS campaign_id
      ,campaign_name            AS campaign_name
      ,cast(ad_group_id AS string) AS ad_group_id
      ,ad_group_name            AS ad_group_name
      ,cast(ad_id AS string)    AS ad_id
      ,ad_name                     AS ad_name
      ,country_code
      ,impressions              AS impression
      ,clicks                   AS click
      ,spend                    AS cost
      ,conversions              AS conversion
      -- Additional Google Ads specific fields
      ,customer_id
      ,_fivetran_id
      ,campaign_base_campaign
      ,interactions
      ,interaction_event_types
      ,device
      ,active_view_impressions
      ,active_view_measurable_impressions
      ,cost_per_conversion
      ,active_view_measurability
      ,conversions_value
      ,geo_target_name
      ,geo_target_canonical_name
      ,geo_target_type
      ,geo_bid_modifier
      ,ad_network_type
      ,active_view_viewability
      ,view_through_conversions
      ,video_views
      ,active_view_measurable_cost_micros
      ,ad_group_base_ad_group
      ,_fivetran_synced
      ,channel

FROM (

select 
        a.dt
       ,a.customer_id
       ,a._fivetran_id
       ,a.campaign_base_campaign
       ,a.conversions
       ,a.interactions
       ,a.interaction_event_types
       ,a.campaign_id  
       ,a.device
       ,a.active_view_impressions
       ,a.clicks
       ,a.active_view_measurable_impressions
       ,a.cost_per_conversion
       ,a.active_view_measurability
       ,a.conversions_value
       ,COALESCE(geo_info.country_code, 'US') as country_code
       ,geo_info.geo_target_name
       ,geo_info.geo_target_canonical_name
       ,geo_info.geo_target_type
       ,geo_crit.bid_modifier as geo_bid_modifier
       ,a.ad_id 
       ,a.ad_network_type
       ,a.impressions
       ,a.active_view_viewability
       ,a.view_through_conversions
       ,a.ad_group_id  
       ,a.video_views
       ,a.active_view_measurable_cost_micros
       ,a.ad_group_base_ad_group
       ,a.spend
       ,a._fivetran_synced
       ,a.channel
       ,b.ad_name 
       ,c.ad_group_name
       ,d.campaign_name
       ,e.account_name
       ,case when lower(e.account_name) like '%gensmo%' then 'Gensmo' 
       when lower(e.account_name) like '%decofy%' then 'Decofy'  
       else 'UNKNOWN' end as app_name
       ,case when lower(d.campaign_name) like '%ios%' then 'IOS'
       when lower(d.campaign_name) like '%android%' then 'Android' 
       else 'UNKNOWN' end as platform

from (
SELECT  customer_id
       ,date                         AS dt
       ,_fivetran_id
       ,campaign_base_campaign
       ,conversions
       ,interactions
       ,interaction_event_types
       ,campaign_id  
       ,device
       ,active_view_impressions
       ,clicks
       ,active_view_measurable_impressions
       ,cost_per_conversion
       ,active_view_measurability
       ,conversions_value
       ,ad_id 
       ,ad_network_type
       ,impressions
       ,active_view_viewability
       ,view_through_conversions
       ,ad_group_id  
       ,video_views
       ,active_view_measurable_cost_micros
       ,ad_group_base_ad_group
       ,cost_micros/1000000          AS spend
       ,_fivetran_synced
       ,'GOOGLE_01' as  channel
FROM google_ads_yingliang.ad_stats ) a

left join (
       SELECT  ad_group_id
       ,id
       ,updated_at
       ,action_items
       ,ad_strength
       ,added_by_google_ads
       ,device_preference
       ,display_url
       ,final_url_suffix
       ,final_app_urls
       ,final_mobile_urls
       ,final_urls
       ,name as ad_name
       ,policy_summary_approval_status
       ,policy_summary_review_status
       ,status
       ,system_managed_resource_source
       ,tracking_url_template
       ,type
       ,url_collections
FROM
(
	SELECT  ad_group_id
	       ,id
	       ,updated_at
	       ,action_items
	       ,ad_strength
	       ,added_by_google_ads
	       ,device_preference
	       ,display_url
	       ,final_url_suffix
	       ,final_app_urls
	       ,final_mobile_urls
	       ,final_urls
	       ,name
	       ,policy_summary_approval_status
	       ,policy_summary_review_status
	       ,status
	       ,system_managed_resource_source
	       ,tracking_url_template
	       ,type
	       ,url_collections
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY  updated_at DESC ) AS rk
	FROM srpproduct-dc37e.google_ads_yingliang.ad_history
)t1
WHERE rk = 1
) b

on a.ad_id=b.id 

left join (
       SELECT  id
       ,campaign_id
       ,updated_at
       ,name as ad_group_name
       ,status as ad_group_status
       ,type as ad_group_type
       ,base_ad_group_id
       ,ad_rotation_mode
       ,campaign_name
       ,display_custom_bid_dimension
       ,explorer_auto_optimizer_setting_opt_in
       ,final_url_suffix as ad_group_final_url_suffix
       ,target_restrictions
       ,tracking_url_template as ad_group_tracking_url_template
FROM
(
	SELECT  id
	       ,campaign_id
	       ,updated_at
	       ,name
	       ,status
	       ,type
	       ,base_ad_group_id
	       ,ad_rotation_mode
	       ,campaign_name
	       ,display_custom_bid_dimension
	       ,explorer_auto_optimizer_setting_opt_in
	       ,final_url_suffix
	       ,target_restrictions
	       ,tracking_url_template
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_yingliang.ad_group_history
)t2
WHERE rk = 1
) c

on a.ad_group_id=c.id 

left join (
       SELECT  id
       ,customer_id
       ,updated_at
       ,name as campaign_name
       ,status as campaign_status
       ,advertising_channel_type
       ,advertising_channel_subtype
       ,ad_serving_optimization_status
       ,start_date
       ,end_date
       ,serving_status
       ,optimization_score
       ,payment_mode
       ,experiment_type
       ,base_campaign_id
       ,final_url_suffix as campaign_final_url_suffix
       ,frequency_caps
       ,tracking_url_template as campaign_tracking_url_template
       ,vanity_pharma_display_url_mode
       ,vanity_pharma_text
       ,video_brand_safety_suitability
FROM
(
	SELECT  id
	       ,customer_id
	       ,updated_at
	       ,name
	       ,status
	       ,advertising_channel_type
	       ,advertising_channel_subtype
	       ,ad_serving_optimization_status
	       ,start_date
	       ,end_date
	       ,serving_status
	       ,optimization_score
	       ,payment_mode
	       ,experiment_type
	       ,base_campaign_id
	       ,final_url_suffix
	       ,frequency_caps
	       ,tracking_url_template
	       ,vanity_pharma_display_url_mode
	       ,vanity_pharma_text
	       ,video_brand_safety_suitability
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_yingliang.campaign_history
)t3
WHERE rk = 1
) d

on a.campaign_id=d.id 

left join (
       SELECT  id
       ,updated_at
       ,descriptive_name as account_name
       ,currency_code
       ,time_zone
       ,optimization_score
       ,auto_tagging_enabled
       ,pay_per_conversion_eligibility_failure_reasons
       ,manager_customer_id
       ,final_url_suffix as account_final_url_suffix
       ,hidden
       ,manager
       ,test_account
       ,tracking_url_template as account_tracking_url_template
FROM
(
	SELECT  id
	       ,updated_at
	       ,descriptive_name
	       ,currency_code
	       ,time_zone
	       ,optimization_score
	       ,auto_tagging_enabled
	       ,pay_per_conversion_eligibility_failure_reasons
	       ,manager_customer_id
	       ,final_url_suffix
	       ,hidden
	       ,manager
	       ,test_account
	       ,tracking_url_template
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_yingliang.account_history
)t4
WHERE rk = 1
) e

on a.customer_id=e.id

-- Add geographic targeting left join for first dataset
left join (
       SELECT  campaign_id
       ,geo_target_constant_id
       ,negative
       ,bid_modifier
       ,status as geo_status
FROM
(
	SELECT  campaign_id
	       ,geo_target_constant_id
	       ,negative
	       ,bid_modifier
	       ,status
	       ,ROW_NUMBER() OVER (PARTITION BY campaign_id, geo_target_constant_id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_yingliang.campaign_criterion_history
	WHERE geo_target_constant_id IS NOT NULL
	  AND type = 'LOCATION'
	  AND negative = false
)t5
WHERE rk = 1
) geo_crit

on a.campaign_id=geo_crit.campaign_id

left join (
       SELECT  id
       ,name as geo_target_name
       ,canonical_name as geo_target_canonical_name
       ,country_code
       ,target_type as geo_target_type
       ,status as geo_target_status
       FROM srpproduct-dc37e.google_ads_yingliang.geo_target
) geo_info

on geo_crit.geo_target_constant_id=geo_info.id

union all 


select 
        a.dt
       ,a.customer_id
       ,a._fivetran_id
       ,a.campaign_base_campaign
       ,a.conversions
       ,a.interactions
       ,a.interaction_event_types
       ,a.campaign_id  
       ,a.device
       ,a.active_view_impressions
       ,a.clicks
       ,a.active_view_measurable_impressions
       ,a.cost_per_conversion
       ,a.active_view_measurability
       ,a.conversions_value
       ,COALESCE(geo_info.country_code, 'US') as country_code
       ,geo_info.geo_target_name
       ,geo_info.geo_target_canonical_name
       ,geo_info.geo_target_type
       ,geo_crit.bid_modifier as geo_bid_modifier
       ,a.ad_id 
       ,a.ad_network_type
       ,a.impressions
       ,a.active_view_viewability
       ,a.view_through_conversions
       ,a.ad_group_id  
       ,a.video_views
       ,a.active_view_measurable_cost_micros
       ,a.ad_group_base_ad_group
       ,a.spend
       ,a._fivetran_synced
       ,a.channel
       ,b.name
       ,c.ad_group_name
       ,d.campaign_name
       ,e.account_name
       ,case when lower(e.account_name) like '%gensmo%' then 'Gensmo' 
       when lower(e.account_name) like '%decofy%' then 'Decofy'  
       else 'UNKNOWN' end as app_name
       ,case when lower(d.campaign_name) like '%ios%' then 'IOS'
       when lower(d.campaign_name) like '%android%' then 'Android' 
       else 'UNKNOWN' end as platform

from (
SELECT  customer_id
       ,date                         AS dt
       ,_fivetran_id
       ,campaign_base_campaign
       ,conversions
       ,interactions
       ,interaction_event_types
       ,campaign_id 
       ,device
       ,active_view_impressions
       ,clicks
       ,active_view_measurable_impressions
       ,cost_per_conversion
       ,active_view_measurability
       ,conversions_value
       ,ad_id
       ,ad_network_type
       ,impressions
       ,active_view_viewability
       ,view_through_conversions
       ,ad_group_id 
       ,video_views
       ,active_view_measurable_cost_micros
       ,ad_group_base_ad_group
       ,cost_micros/1000000          AS spend
       ,_fivetran_synced
       ,'GOOGLE_02' as  channel
FROM google_ads_gensmo02ios.ad_stats ) a

left join (
       SELECT  ad_group_id
       ,id
       ,updated_at
       ,action_items
       ,ad_strength
       ,added_by_google_ads
       ,device_preference
       ,display_url
       ,final_url_suffix
       ,final_app_urls
       ,final_mobile_urls
       ,final_urls
       ,name
       ,policy_summary_approval_status
       ,policy_summary_review_status
       ,status
       ,system_managed_resource_source
       ,tracking_url_template
       ,type
       ,url_collections
FROM
(
	SELECT  ad_group_id
	       ,id
	       ,updated_at
	       ,action_items
	       ,ad_strength
	       ,added_by_google_ads
	       ,device_preference
	       ,display_url
	       ,final_url_suffix
	       ,final_app_urls
	       ,final_mobile_urls
	       ,final_urls
	       ,name
	       ,policy_summary_approval_status
	       ,policy_summary_review_status
	       ,status
	       ,system_managed_resource_source
	       ,tracking_url_template
	       ,type
	       ,url_collections
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY  updated_at DESC ) AS rk
	FROM srpproduct-dc37e.google_ads_gensmo02ios.ad_history
)t6
WHERE rk = 1
) b

on a.ad_id=b.id 

left join (
       SELECT  id
       ,campaign_id
       ,updated_at
       ,name as ad_group_name
       ,status as ad_group_status
       ,type as ad_group_type
       ,base_ad_group_id
       ,ad_rotation_mode
       ,campaign_name
       ,display_custom_bid_dimension
       ,explorer_auto_optimizer_setting_opt_in
       ,final_url_suffix as ad_group_final_url_suffix
       ,target_restrictions
       ,tracking_url_template as ad_group_tracking_url_template
FROM
(
	SELECT  id
	       ,campaign_id
	       ,updated_at
	       ,name
	       ,status
	       ,type
	       ,base_ad_group_id
	       ,ad_rotation_mode
	       ,campaign_name
	       ,display_custom_bid_dimension
	       ,explorer_auto_optimizer_setting_opt_in
	       ,final_url_suffix
	       ,target_restrictions
	       ,tracking_url_template
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_gensmo02ios.ad_group_history
)t7
WHERE rk = 1
) c

on a.ad_group_id=c.id 

left join (
       SELECT  id
       ,customer_id
       ,updated_at
       ,name as campaign_name
       ,status as campaign_status
       ,advertising_channel_type
       ,advertising_channel_subtype
       ,ad_serving_optimization_status
       ,start_date
       ,end_date
       ,serving_status
       ,optimization_score
       ,payment_mode
       ,experiment_type
       ,base_campaign_id
       ,final_url_suffix as campaign_final_url_suffix
       ,frequency_caps
       ,tracking_url_template as campaign_tracking_url_template
       ,vanity_pharma_display_url_mode
       ,vanity_pharma_text
       ,video_brand_safety_suitability
FROM
(
	SELECT  id
	       ,customer_id
	       ,updated_at
	       ,name
	       ,status
	       ,advertising_channel_type
	       ,advertising_channel_subtype
	       ,ad_serving_optimization_status
	       ,start_date
	       ,end_date
	       ,serving_status
	       ,optimization_score
	       ,payment_mode
	       ,experiment_type
	       ,base_campaign_id
	       ,final_url_suffix
	       ,frequency_caps
	       ,tracking_url_template
	       ,vanity_pharma_display_url_mode
	       ,vanity_pharma_text
	       ,video_brand_safety_suitability
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_gensmo02ios.campaign_history
)t8
WHERE rk = 1
) d

on a.campaign_id=d.id 

left join (
       SELECT  id
       ,updated_at
       ,descriptive_name as account_name
       ,currency_code
       ,time_zone
       ,optimization_score
       ,auto_tagging_enabled
       ,pay_per_conversion_eligibility_failure_reasons
       ,manager_customer_id
       ,final_url_suffix as account_final_url_suffix
       ,hidden
       ,manager
       ,test_account
       ,tracking_url_template as account_tracking_url_template
FROM
(
	SELECT  id
	       ,updated_at
	       ,descriptive_name
	       ,currency_code
	       ,time_zone
	       ,optimization_score
	       ,auto_tagging_enabled
	       ,pay_per_conversion_eligibility_failure_reasons
	       ,manager_customer_id
	       ,final_url_suffix
	       ,hidden
	       ,manager
	       ,test_account
	       ,tracking_url_template
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_gensmo02ios.account_history
)t9
WHERE rk = 1
) e

on a.customer_id=e.id

-- Add geographic targeting left join for second dataset
left join (
       SELECT  campaign_id
       ,geo_target_constant_id
       ,negative
       ,bid_modifier
       ,status as geo_status
FROM
(
	SELECT  campaign_id
	       ,geo_target_constant_id
	       ,negative
	       ,bid_modifier
	       ,status
	       ,ROW_NUMBER() OVER (PARTITION BY campaign_id, geo_target_constant_id ORDER BY updated_at DESC) AS rk
	FROM srpproduct-dc37e.google_ads_gensmo02ios.campaign_criterion_history
	WHERE geo_target_constant_id IS NOT NULL
	  AND type = 'LOCATION'
	  AND negative = false
)t10
WHERE rk = 1
) geo_crit

on a.campaign_id=geo_crit.campaign_id

left join (
       SELECT  id
       ,name as geo_target_name
       ,canonical_name as geo_target_canonical_name
       ,country_code
       ,target_type as geo_target_type
       ,status as geo_target_status
       FROM srpproduct-dc37e.google_ads_gensmo02ios.geo_target
) geo_info

on geo_crit.geo_target_constant_id=geo_info.id

);