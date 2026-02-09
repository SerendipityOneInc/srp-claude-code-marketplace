CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_tiktok_fivetran_campaign_geo_inc_1d_view`
AS SELECT  DATE(stat_time_day)                                                                   AS dt
       ,'Tiktok Ads'                                                                              AS source
       ,CASE WHEN lower(b.campaign_name ) LIKE '%ios%' THEN 'IOS'
             WHEN lower(b.campaign_name ) LIKE '%android%' THEN 'Android'  ELSE 'UNKNOWN' END AS platform
       ,CASE WHEN LOWER(c.advertiser_name) LIKE 'gensmo%' THEN 'Gensmo'
             WHEN LOWER(c.advertiser_name) LIKE 'decofy%' THEN 'Decofy'  ELSE 'UNKNOWN' END   AS app_name
       ,cast(b.advertiser_id AS string)                                                       AS account_id
       ,cast(c.advertiser_name AS string)                                                     AS account_name
       ,cast(b.campaign_id AS string )                                                        AS campaign_id
       ,cast(b.campaign_name AS string)                                                       AS campaign_name
       ,cast(null AS string )                                                                 AS ad_group_id
       ,cast(null AS string )                                                                 AS ad_group_name
       ,cast(null AS string )                                                                 AS ad_id
       ,cast (null AS string)                                                                 AS ad_name
       ,country_code
       ,impressions                                                                           AS impression
       ,clicks                                                                                AS click
       ,spend                                                                                 AS cost
       ,conversion
       ,likes
FROM `srpproduct-dc37e.fivetran_tiktok_ads.campaign_country_report` a
LEFT JOIN
(
	SELECT  campaign_id
	       ,campaign_name
	       ,advertiser_id
	FROM srpproduct-dc37e.fivetran_tiktok_ads.campaign_history
	GROUP BY  campaign_id
	         ,campaign_name
	         ,advertiser_id
) b
ON a.campaign_id = b.campaign_id
LEFT JOIN
(
	SELECT  id   AS advertiser_id
	       ,name AS advertiser_name
	FROM srpproduct-dc37e.fivetran_tiktok_ads.advertiser
	GROUP BY  id
	         ,name
)c
ON b.advertiser_id = c.advertiser_id;