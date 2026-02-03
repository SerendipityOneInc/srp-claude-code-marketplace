CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_reddit_fivetran_by_ad_id_inc_1d_view`
AS SELECT  Date(a.date)                                                                                                             AS dt
       ,'Reddit Ads'                                                                                                             AS source
       ,CASE WHEN lower(d.campaign_name) LIKE '%ios%' THEN 'IOS'
             WHEN lower(d.campaign_name) LIKE '%android%' THEN 'ANDROID'
             WHEN lower(d.campaign_name) LIKE '%web%' THEN 'WEB'  ELSE 'UNKNOWN' END                                             AS platform
       ,CASE WHEN lower(account_name) LIKE '%gensmo%' THEN 'Gensmo'
             WHEN lower(account_name) LIKE '%decofy%' THEN 'Decofy'
             WHEN lower(account_name) LIKE '%savyo%' THEN 'Savyo'  ELSE 'UNKNOWN' END                                            AS app_name
       ,CASE WHEN lower(account_name) LIKE '%inhouse%' OR lower(account_name) LIKE '%自投%' THEN 'INHOUSE'  ELSE 'NON_INHOUSE' END AS account_put_type
       ,CASE WHEN lower(account_name) LIKE '%yla%' THEN 'YING_LIANG'  ELSE 'YI_DIAN' END                                         AS account_open_agency
       ,'NON_KOL'                                                                                                                AS ad_category
       ,cast(b.account_id AS string)                                                                                             AS account_id
       ,cast(e.account_name AS string)                                                                                           AS account_name
       ,cast(b.campaign_id AS string)                                                                                            AS campaign_id
       ,cast(d.campaign_name AS string)                                                                                          AS campaign_name
       ,cast(b.ad_group_id AS string)                                                                                            AS ad_group_id
       ,cast(c.ad_group_name AS string)                                                                                          AS ad_group_name
       ,cast(b.ad_id AS string)                                                                                                  AS ad_id
       ,cast(b.ad_name AS string)                                                                                                AS ad_name
       ,'US'                                                                                                                     AS country_code
       ,impressions                                                                                                              AS impression
       ,clicks                                                                                                                   AS click
       ,spend/1000000                                                                                                            AS cost
       ,conversion_roas                                                                                                          AS conversion
FROM `srpproduct-dc37e.reddit_ads.ad_report` a
LEFT JOIN
(
	SELECT  id   AS ad_id
	       ,name AS ad_name
	       ,ad_group_id
	       ,campaign_id
	       ,account_id
	FROM `srpproduct-dc37e.reddit_ads.ad`
) b
ON a.ad_id = b.ad_id
LEFT JOIN
(
	SELECT  id   AS ad_group_id
	       ,name AS ad_group_name
	FROM `srpproduct-dc37e.reddit_ads.ad_group`
)c
ON b.ad_group_id = c.ad_group_id
LEFT JOIN
(
	SELECT  id   AS campaign_id
	       ,name AS campaign_name
	FROM `srpproduct-dc37e.reddit_ads.campaign`
)d
ON b.campaign_id = d.campaign_id
LEFT JOIN
(
	SELECT  id   AS account_id
	       ,name AS account_name
	FROM `srpproduct-dc37e.reddit_ads.business_account`
)e
ON b.account_id = e.account_id;