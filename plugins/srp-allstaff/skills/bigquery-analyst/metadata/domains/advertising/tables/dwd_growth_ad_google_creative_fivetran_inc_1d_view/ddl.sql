CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_google_creative_fivetran_inc_1d_view`
AS with google_data as (
SELECT  dt
		,'Google Ads' as source
       ,campaign_id
       ,campaign_name
       ,ad_group_id
       ,ad_group_name
       ,ad_id
       ,ad_name
       ,creative_id
       ,creative_name
       ,creative_type
       ,google_youtube_video_id
       ,google_youtube_video_title
       ,impression
       ,click
       ,cost
       ,conversion
       ,channel
FROM
(
	SELECT  date                                                                                                         AS dt
	       ,campaign_id
	       ,campaign_name
	       ,ad_group_id
	       ,ad_group_name
	       ,ad_id
	       ,ad_group_ad_ad_name                                                                                          AS ad_name
	       ,asset_id                                                                                                     AS creative_id
	       ,CASE WHEN lower(field_type) LIKE '%video%' THEN youtube_video_asset_youtube_video_title  ELSE asset_name END AS creative_name
	       ,field_type                                                                                                   AS creative_type
	       ,youtube_video_asset_youtube_video_id                                                                         AS google_youtube_video_id
	       ,youtube_video_asset_youtube_video_title                                                                      AS google_youtube_video_title
	       ,impressions                                                                                                  AS impression
	       ,clicks                                                                                                       AS click
	       ,cost_micros     /1000000                                                                                                AS cost
	       ,conversions                                                                                                  AS conversion
	       ,'google_inhouse_ads@215-954-7541'                                                                            AS channel
	FROM `srpproduct-dc37e.google_inhouse_ads.creative_metrics`
	UNION ALL
	SELECT  date                                                                                                         AS dt
	       ,campaign_id
	       ,campaign_name
	       ,ad_group_id
	       ,ad_group_name
	       ,ad_id
	       ,ad_group_ad_ad_name                                                                                          AS ad_name
	       ,asset_id                                                                                                     AS creative_id
	       ,CASE WHEN lower(field_type) LIKE '%video%' THEN youtube_video_asset_youtube_video_title  ELSE asset_name END AS creative_name
	       ,field_type                                                                                                   AS creative_type
	       ,youtube_video_asset_youtube_video_id                                                                         AS google_youtube_video_id
	       ,youtube_video_asset_youtube_video_title                                                                      AS google_youtube_video_title
	       ,impressions                                                                                                  AS impression
	       ,clicks                                                                                                       AS click
	       ,cost_micros /1000000                                                                                                    AS cost
	       ,conversions                                                                                                  AS conversion
	       ,'google_ads_yingliang@932-950-3721'                                                                          AS channel
	FROM srpproduct-dc37e.google_ads_yingliang.ad_group_ad_asset_view_2
	UNION ALL
	SELECT  date                                                                                                         AS dt
	       ,campaign_id
	       ,campaign_name
	       ,ad_group_id
	       ,ad_group_name
	       ,ad_id
	       ,ad_name
	       ,asset_id                                                                                                     AS creative_id
	       ,CASE WHEN lower(field_type) LIKE '%video%' THEN youtube_video_asset_youtube_video_title  ELSE asset_name END AS creative_name
	       ,field_type                                                                                                   AS creative_type
	       ,youtube_video_asset_youtube_video_id                                                                         AS google_youtube_video_id
	       ,youtube_video_asset_youtube_video_title                                                                      AS google_youtube_video_title
	       ,impressions                                                                                                  AS impression
	       ,clicks                                                                                                       AS click
	       ,cost_micros/1000000                                                                                                    AS cost
	       ,conversions                                                                                                  AS conversion
	       ,'google_ads_gensmo02ios@321-229-2944'                                                                        AS channel
	FROM srpproduct-dc37e.google_ads_gensmo02ios.creative_metrics
	UNION ALL
	SELECT  date                                                                                                         AS dt
	       ,campaign_id
	       ,campaign_name
	       ,ad_group_id
	       ,ad_group_name
	       ,ad_id
	       ,ad_name
	       ,asset_id                                                                                                     AS creative_id
	       ,CASE WHEN lower(field_type) LIKE '%video%' THEN youtube_video_asset_youtube_video_title  ELSE asset_name END AS creative_name
	       ,field_type                                                                                                   AS creative_type
	       ,youtube_video_asset_youtube_video_id                                                                         AS google_youtube_video_id
	       ,youtube_video_asset_youtube_video_title                                                                      AS google_youtube_video_title
	       ,impressions                                                                                                  AS impression
	       ,clicks                                                                                                       AS click
	       ,cost_micros/1000000                                                                                                     AS cost
	       ,conversions                                                                                                  AS conversion
	       ,'appsflyer_google03@3798377807'                                                                              AS channel
	FROM srpproduct-dc37e.appsflyer_google03.creative_metrics
	UNION ALL
	SELECT  date                                                                                                         AS dt
	       ,campaign_id
	       ,campaign_name
	       ,ad_group_id
	       ,ad_group_name
	       ,ad_id
	       ,ad_name                                                                                                      AS ad_name
	       ,asset_id                                                                                                     AS creative_id
	       ,CASE WHEN lower(field_type) LIKE '%video%' THEN youtube_video_asset_youtube_video_title  ELSE asset_name END AS creative_name
	       ,field_type                                                                                                   AS creative_type
	       ,youtube_video_asset_youtube_video_id                                                                         AS google_youtube_video_id
	       ,youtube_video_asset_youtube_video_title                                                                      AS google_youtube_video_title
	       ,impressions                                                                                                  AS impression
	       ,clicks                                                                                                       AS click
	       ,cost_micros /1000000                                                                                                    AS cost
	       ,conversions                                                                                                  AS conversion
	       ,'google_yla_03@979-157-6593'                                                                                 AS channel
	FROM srpproduct-dc37e.google_yla_03.creative_metrics
) 

),
mapping_google_data  as (

       SELECT  dt
       ,cast(source as string) as source
       ,cast(null as string) AS account_id
       ,cast(null as string) AS account_name
       ,cast(campaign_id as string) AS campaign_id
       ,cast(campaign_name as string) AS campaign_name
       ,cast(ad_group_id as string) AS ad_group_id
       ,cast(ad_group_name as string) AS ad_group_name
       ,cast(ad_id as string) AS ad_id
       ,cast(ad_name as string) AS ad_name
       ,cast(creative_id as string) AS creative_id
       ,cast(creative_name as string) AS creative_name
       ,creative_type
       ,cast(google_youtube_video_id as string) AS google_youtube_video_id
       ,cast(google_youtube_video_title as string) AS google_youtube_video_title
       ,impression
       ,click
       ,cost
       ,conversion
       ,channel
FROM google_data
)



SELECT
a.dt
,a.source
,a.platform
,a.app_name
,a.account_id
,a.account_name
,a.campaign_id
,a.campaign_name
,a.ad_group_id
,a.ad_group_name
,a.ad_id
,a.ad_name
,a.country_code
,a.ad_category
,a.account_put_type
,a.account_open_agency
,coalesce(b.creative_id,a.ad_id) as creative_id
,coalesce(b.creative_name,a.ad_name) as creative_name
,coalesce(b.creative_type,'FROM_AD') as creative_type
,google_youtube_video_id
,google_youtube_video_title
,coalesce(upper(b.account_name),upper(a.account_name)) as channel
,coalesce(b.impression,a.impression) as impression
,coalesce(b.click,coalesce(a.click,0)) as click
,coalesce(b.cost,a.cost) as cost
,coalesce(b.conversion,a.conversion) as conversion
,coalesce(safe_divide(b.conversion,sum(b.conversion) over (partition by  b.dt,b.ad_id ) ),1) as weight
FROM
(
SELECT
dt
,source
,platform
,app_name
,account_id
,account_name
,campaign_id
,campaign_name
,ad_group_id
,ad_group_name
,ad_id
,ad_name
,country_code
,ad_category
,account_put_type
,account_open_agency
,impression
,click
,conversion
,cost
FROM `favie_dw.dwd_growth_ad_total_by_source_inc_1d_view`
where source = 'Google Ads'
)a
FULl JOIN  mapping_google_data b
ON a.dt = b.dt AND a.ad_id = b.ad_id AND a.ad_group_id = b.ad_group_id AND a.campaign_id = b.campaign_id;