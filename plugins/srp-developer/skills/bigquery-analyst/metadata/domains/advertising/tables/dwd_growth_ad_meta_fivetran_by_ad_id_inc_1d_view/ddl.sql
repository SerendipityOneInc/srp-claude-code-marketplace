CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_meta_fivetran_by_ad_id_inc_1d_view`
AS SELECT 
       dt
      ,'Meta Ads'                          AS source
      ,platform
      ,app_name
      ,cast(account_id AS string)          AS account_id
      ,account_name                        AS account_name
      ,cast(campaign_id AS string)         AS campaign_id
      ,campaign_name                       AS campaign_name
      ,cast(ad_set_id AS string)           AS ad_group_id
      ,ad_set_name                         AS ad_group_name
      ,cast(ad_id AS string)               AS ad_id
      ,ad_name                             AS ad_name
      ,CASE WHEN lower(ad_name) LIKE '%partnership%' AND lower(ad_name) NOT LIKE '%non-partnership%' THEN 'KOL' else 'NON_KOL' end    as ad_category
      ,country_code
      ,impressions                         AS impression
      ,clicks                              AS click
      ,spend                               AS cost
      ,COALESCE(conversions, 0)            AS conversion
      -- Additional Meta Ads specific fields
      ,_fivetran_id
      ,reach
      ,cost_per_inline_link_click
      ,cpc
      ,cpm
      ,ctr
      ,frequency
      ,inline_link_click_ctr
      ,geo_regions
      ,geo_cities
      ,geo_zips
      ,targeting_age_min
      ,targeting_age_max
      ,targeting_genders
      ,campaign_objective
      ,ad_set_optimization_goal
      ,ad_set_bid_strategy
      ,_fivetran_synced

FROM (

select 
        a.date                           AS dt
       ,a.account_id
       ,a._fivetran_id
       ,a.impressions
       ,a.inline_link_clicks             AS clicks
       ,a.reach
       ,a.cost_per_inline_link_click
       ,a.cpc
       ,a.cpm
       ,a.ctr
       ,a.frequency
       ,a.spend
       ,a.ad_name
       ,a.adset_name
       ,a.inline_link_click_ctr
       ,a._fivetran_synced
       ,a.ad_id
       ,b.ad_set_id
       ,b.campaign_id
       ,b.name                          AS ad_full_name
       ,c.name                          AS ad_set_name
       ,c.targeting_geo_locations_countries AS geo_countries
       ,c.targeting_geo_locations_regions   AS geo_regions
       ,c.targeting_geo_locations_cities    AS geo_cities
       ,c.targeting_geo_locations_zips      AS geo_zips
       ,c.targeting_age_min
       ,c.targeting_age_max
       ,c.targeting_genders
       ,c.optimization_goal             AS ad_set_optimization_goal
       ,c.bid_strategy                  AS ad_set_bid_strategy
       ,d.name                          AS campaign_name
       ,d.objective                     AS campaign_objective
       ,e.name                          AS account_name
       -- Add conversions from basic_ad_actions table
       ,f.conversions
       -- Extract country code from geo_countries (assuming US as default)
       ,CASE 
           WHEN c.targeting_geo_locations_countries IS NOT NULL 
           THEN REGEXP_EXTRACT(c.targeting_geo_locations_countries, r'\"([A-Z]{2})\"')
           ELSE 'US' 
        END AS country_code
       -- Determine app_name from account name
       ,CASE 
           WHEN LOWER(e.name) LIKE '%gensmo%' THEN 'Gensmo' 
           WHEN LOWER(e.name) LIKE '%decofy%' THEN 'Decofy'
           when lower(e.name) like '%savyo%' then 'Savyo'
           ELSE 'UNKNOWN' 
        END AS app_name
       -- Determine platform from campaign name
       ,CASE
           WHEN LOWER(d.name) LIKE '%ios%'  THEN 'iOS'
           WHEN LOWER(d.name) LIKE '%android%' THEN 'Android' 
           ELSE 'UNKNOWN'
        END AS platform
      
       

from (
SELECT  account_id
       ,date
       ,_fivetran_id
       ,ad_id
       ,impressions
       ,inline_link_clicks
       ,reach
       ,cost_per_inline_link_click
       ,cpc
       ,cpm
       ,ctr
       ,frequency
       ,spend
       ,ad_name
       ,adset_name
       ,inline_link_click_ctr
       ,_fivetran_synced
FROM  `srpproduct-dc37e.fivetran_facebook_ads_full.basic_ad`
) a

left join (
       SELECT  id
       ,ad_set_id
       ,campaign_id
       ,account_id
       ,name
       ,updated_time
       ,configured_status
       ,effective_status
       ,status
FROM
(
	SELECT  id
	       ,ad_set_id
	       ,campaign_id
	       ,account_id
	       ,name
	       ,updated_time
	       ,configured_status
	       ,effective_status
	       ,status
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_time DESC) AS rk
	FROM srpproduct-dc37e.fivetran_facebook_ads_full.ad_history
)t1
WHERE rk = 1
) b

on a.ad_id = cast(b.id as string )

left join (
       SELECT  id
       ,campaign_id
       ,account_id
       ,name
       ,updated_time
       ,targeting_geo_locations_countries
       ,targeting_geo_locations_regions
       ,targeting_geo_locations_cities
       ,targeting_geo_locations_zips
       ,targeting_age_min
       ,targeting_age_max
       ,targeting_genders
       ,optimization_goal
       ,bid_strategy
       ,configured_status
       ,effective_status
       ,status
       ,daily_budget
       ,lifetime_budget
FROM
(
	SELECT  id
	       ,campaign_id
	       ,account_id
	       ,name
	       ,updated_time
	       ,targeting_geo_locations_countries
	       ,targeting_geo_locations_regions
	       ,targeting_geo_locations_cities
	       ,targeting_geo_locations_zips
	       ,targeting_age_min
	       ,targeting_age_max
	       ,targeting_genders
	       ,optimization_goal
	       ,bid_strategy
	       ,configured_status
	       ,effective_status
	       ,status
	       ,daily_budget
	       ,lifetime_budget
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_time DESC) AS rk
	FROM srpproduct-dc37e.fivetran_facebook_ads_full.ad_set_history
)t2
WHERE rk = 1
) c

on b.ad_set_id = c.id

left join (
       SELECT  id
       ,account_id
       ,name
       ,updated_time
       ,objective
       ,buying_type
       ,configured_status
       ,effective_status
       ,status
       ,daily_budget
       ,lifetime_budget
       ,spend_cap
FROM
(
	SELECT  id
	       ,account_id
	       ,name
	       ,updated_time
	       ,objective
	       ,buying_type
	       ,configured_status
	       ,effective_status
	       ,status
	       ,daily_budget
	       ,lifetime_budget
	       ,spend_cap
	       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_time DESC) AS rk
	FROM srpproduct-dc37e.fivetran_facebook_ads_full.campaign_history
)t3
WHERE rk = 1
) d

on b.campaign_id = d.id

left join (
    select id
       ,name
       ,currency
       ,timezone_name
       ,business_name
       ,business_country_code
       ,account_status
       from (
       SELECT  id
       ,name
       ,currency
       ,timezone_name
       ,business_name
       ,business_country_code
       ,account_status
       ,_fivetran_synced
       ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY _fivetran_synced DESC) AS rk
FROM srpproduct-dc37e.fivetran_facebook_ads_full.account_history
       )t1 
       where rk=1
) e

on a.account_id = e.id

-- Join with conversions data from basic_ad_actions
left join (
    SELECT 
        ad_id
        ,date
        ,SUM(
            CASE 
                WHEN action_type IN ('mobile_app_install', 'omni_app_install') 
                THEN COALESCE(_1_d_view, 0)
                WHEN action_type IN ('lead', 'onsite_web_lead', 'offsite_conversion.fb_pixel_lead')
                THEN COALESCE(value, _7_d_click, 0)
                ELSE 0
            END
        ) AS conversions
    FROM `srpproduct-dc37e.fivetran_facebook_ads_full.basic_ad_actions`
    WHERE action_type IN (
        'mobile_app_install', 
        'omni_app_install', 
        'lead', 
        'onsite_web_lead', 
        'offsite_conversion.fb_pixel_lead'
    )
    GROUP BY ad_id, date
) f

on a.ad_id = f.ad_id AND a.date = f.date

);