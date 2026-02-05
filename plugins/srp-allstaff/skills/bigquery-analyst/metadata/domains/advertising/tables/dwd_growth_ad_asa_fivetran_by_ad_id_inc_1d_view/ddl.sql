CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_asa_fivetran_by_ad_id_inc_1d_view`
AS SELECT  dt
       ,'Apple Search Ads'              AS source
       ,'IOS'                           AS platform
       ,'Gensmo'                        AS app_name
       ,'8632560'                       AS account_id
       ,'Hby_SERENDIPITY_Gensmo'        AS account_name
       ,cast(a.campaign_id AS string )  AS campaign_id
       ,cast(d.name AS string) 			AS campaign_name
       ,cast(a.ad_group_id AS string )           AS ad_group_id
       ,cast(c.name AS string )           AS ad_group_name
       , CASE WHEN a.ad_id != -1 THEN cast(a.ad_id AS string) ELSE cast (null AS string ) END AS ad_id
       ,cast (b.name AS string)           AS ad_name
       ,'US' as country_code
       ,impressions                      AS impression
       ,taps                          AS click
       ,cost                           AS cost
       ,total_installs as conversion
       
FROM
(
	SELECT  ad_group_id  
	       ,ad_id        
	       ,campaign_id 
	       ,creative_id
	       ,Date(date)                    AS dt
	       ,avg_cpm_amount
	       ,avg_cpm_currency
	       ,avg_cpt_amount
	       ,avg_cpt_currency
	       ,impressions
	       ,local_spend_amount            AS cost
	       ,local_spend_currency
	       ,tap_install_cpi_amount
	       ,tap_install_cpi_currency
	       ,taps
	       ,total_avg_cpi_amount
	       ,total_avg_cpi_currency
	       ,tap_install_rate
	       ,tap_installs
	       ,tap_new_downloads
	       ,tap_redownloads
	       ,total_install_rate
	       ,total_installs
	       ,total_new_downloads
	       ,total_redownloads
	       ,tap_through_rate
	       ,view_installs
	       ,view_new_downloads
	       ,view_redownloads
	       ,display_status
	       ,language
	       ,_fivetran_synced
	FROM srpproduct-dc37e.apple_search_ads.ad_level_report
) a
LEFT JOIN
(
	select id
	       ,modification_time
	       ,org_id
	       ,campaign_id
	       ,ad_group_id
	       ,creative_id
	       ,name
	       ,status
	       ,serving_status
	       ,deleted
	       ,creation_time
	       ,creative_type
	from (
	SELECT  id
	       ,modification_time
	       ,org_id
	       ,campaign_id
	       ,ad_group_id
	       ,creative_id
	       ,name
	       ,status
	       ,serving_status
	       ,deleted
	       ,creation_time
	       ,creative_type
		   ,ROW_NUMBER() over  (partition by id order by modification_time desc  ) as rk 
	FROM `srpproduct-dc37e.apple_search_ads.ad_history` ) t1 
	where rk=1 
	
) b
ON a.ad_id = b.id 
LEFT JOIN
(
	select id
,modification_time
,campaign_id
,name
,storefronts
,cpa_goal_amount
,cpa_goal_currency
,default_cpc_bid_amount
,default_cpc_bid_currency
,default_bid_amount
,default_bid_currency
,start_time
,end_time
,deleted
,status
,serving_status
,display_status
,payment_model
,pricing_model
,serving_state_reasons
,automated_keywords_opt_in
,organization_id
	from (
	SELECT  id
,modification_time
,campaign_id
,name
,storefronts
,cpa_goal_amount
,cpa_goal_currency
,default_cpc_bid_amount
,default_cpc_bid_currency
,default_bid_amount
,default_bid_currency
,start_time
,end_time
,deleted
,status
,serving_status
,display_status
,payment_model
,pricing_model
,serving_state_reasons
,automated_keywords_opt_in
,organization_id

,ROW_NUMBER() over 	(partition  by id  order by modification_time desc) as rk 
	FROM `srpproduct-dc37e.apple_search_ads.ad_group_history`
	) t1
	where rk=1

) c
ON a.ad_group_id = c.id 
LEFT JOIN
(
	select 
id
,modification_time
,name
,daily_budget_amount
,daily_budget_currency
,budget_amount
,budget_currency
,adam_id
,budget_orders
,payment_model
,loc_invoice_detail_client_name
,loc_invoice_detail_order_number
,loc_invoice_detail_buyer_name
,loc_invoice_detail_buyer_email
,start_time
,end_time
,creation_time
,status
,serving_status
,ad_channel_type
,billing_event
,display_status
,serving_state_reasons
,supply_sources
,deleted
,organization_id
	from (
	SELECT  
id
,modification_time
,name
,daily_budget_amount
,daily_budget_currency
,budget_amount
,budget_currency
,adam_id
,budget_orders
,payment_model
,loc_invoice_detail_client_name
,loc_invoice_detail_order_number
,loc_invoice_detail_buyer_name
,loc_invoice_detail_buyer_email
,start_time
,end_time
,creation_time
,status
,serving_status
,ad_channel_type
,billing_event
,display_status
,serving_state_reasons
,supply_sources
,deleted
,organization_id

,ROW_NUMBER () over (partition by id order by modification_time desc) as rk 
	FROM `srpproduct-dc37e.apple_search_ads.campaign_history` ) t1 
	where rk=1
)d
ON a.campaign_id = d.id 
LEFT JOIN
(
	SELECT  campaign_id
	       ,if( SUM(case WHEN country_or_region = 'US' THEN 1 else 0 end ) = 1 ,'US','NONE_US' ) AS country_code
	FROM `srpproduct-dc37e.apple_search_ads.country_or_region_history`
	GROUP BY  campaign_id
)e
ON a.campaign_id = e.campaign_id 

union all




--decofy 


SELECT  dt
       ,'Apple Search Ads'              AS source
       ,'IOS'                           AS platform
       ,'Decofy'                        AS app_name
       ,'8963270'                       AS account_id
       ,'Hby_SERENDIPITY_Decofy'        AS account_name
       ,cast(a.campaign_id AS string )  AS campaign_id
       ,cast(d.name AS string) AS campaign_name
       ,cast(a.ad_group_id AS string )           AS ad_group_id
       ,cast(c.name AS string )           AS ad_group_name
       , CASE WHEN a.ad_id != -1 THEN cast(a.ad_id AS string) ELSE cast (null AS string ) END AS ad_id
       ,cast (null AS string)           AS ad_name
       ,'US' as country_code 
       ,impressions                     AS impression
       ,taps                          AS click
       ,cost                           AS cost
       ,total_installs as conversion
       
FROM
(
	SELECT  ad_group_id  
	       ,ad_id        
	       ,campaign_id 
	       ,creative_id
	       ,Date(date)                    AS dt
	       ,avg_cpm_amount
	       ,avg_cpm_currency
	       ,avg_cpt_amount
	       ,avg_cpt_currency
	       ,impressions
	       ,local_spend_amount            AS cost
	       ,local_spend_currency
	       ,tap_install_cpi_amount
	       ,tap_install_cpi_currency
	       ,taps
	       ,total_avg_cpi_amount
	       ,total_avg_cpi_currency
	       ,tap_install_rate
	       ,tap_installs
	       ,tap_new_downloads
	       ,tap_redownloads
	       ,total_install_rate
	       ,total_installs
	       ,total_new_downloads
	       ,total_redownloads
	       ,tap_through_rate
	       ,view_installs
	       ,view_new_downloads
	       ,view_redownloads
	       ,display_status
	       ,language
	       ,_fivetran_synced
	FROM srpproduct-dc37e.apple_search_ads_decofy.ad_level_report
) a
LEFT JOIN
(
	select id
,modification_time
,campaign_id
,name
,storefronts
,cpa_goal_amount
,cpa_goal_currency
,default_cpc_bid_amount
,default_cpc_bid_currency
,default_bid_amount
,default_bid_currency
,start_time
,end_time
,deleted
,status
,serving_status
,display_status
,payment_model
,pricing_model
,serving_state_reasons
,automated_keywords_opt_in
,organization_id
	from (
	SELECT  id
,modification_time
,campaign_id
,name
,storefronts
,cpa_goal_amount
,cpa_goal_currency
,default_cpc_bid_amount
,default_cpc_bid_currency
,default_bid_amount
,default_bid_currency
,start_time
,end_time
,deleted
,status
,serving_status
,display_status
,payment_model
,pricing_model
,serving_state_reasons
,automated_keywords_opt_in
,organization_id

,ROW_NUMBER() over 	(partition  by id  order by modification_time desc) as rk 
	FROM `srpproduct-dc37e.apple_search_ads_decofy.ad_group_history`
	) t1
	where rk=1

) c
ON a.ad_group_id = c.id 
LEFT JOIN
(
	select 
id
,modification_time
,name
,daily_budget_amount
,daily_budget_currency
,budget_amount
,budget_currency
,adam_id
,budget_orders
,payment_model
,loc_invoice_detail_client_name
,loc_invoice_detail_order_number
,loc_invoice_detail_buyer_name
,loc_invoice_detail_buyer_email
,start_time
,end_time
,creation_time
,status
,serving_status
,ad_channel_type
,billing_event
,display_status
,serving_state_reasons
,supply_sources
,deleted
,organization_id
	from (
	SELECT  
id
,modification_time
,name
,daily_budget_amount
,daily_budget_currency
,budget_amount
,budget_currency
,adam_id
,budget_orders
,payment_model
,loc_invoice_detail_client_name
,loc_invoice_detail_order_number
,loc_invoice_detail_buyer_name
,loc_invoice_detail_buyer_email
,start_time
,end_time
,creation_time
,status
,serving_status
,ad_channel_type
,billing_event
,display_status
,serving_state_reasons
,supply_sources
,deleted
,organization_id

,ROW_NUMBER () over (partition by id order by modification_time desc) as rk 
	FROM `srpproduct-dc37e.apple_search_ads_decofy.campaign_history` ) t1 
	where rk=1
)d
ON a.campaign_id = d.id 
LEFT JOIN
(
	SELECT  campaign_id
	       ,if( SUM(case WHEN country_or_region = 'US' THEN 1 else 0 end ) = 1 ,'US','NONE_US' ) AS country_code
	FROM `srpproduct-dc37e.apple_search_ads_decofy.country_or_region_history`
	GROUP BY  campaign_id
)e
ON a.campaign_id = e.campaign_id;