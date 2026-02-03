CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_tiktok_all_creative_fivetran_inc_1d_view`
AS with image_data as (
SELECT 
Date(stat_time_day) as dt,
'Tiktok Ads' as source,
campaign_id,
campaign_name,
adgroup_id as ad_group_id,
adgroup_name as ad_group_name,
ad_id,
ad_name,
image_id as creative_id,
'IMAGE' as creative_type,
impressions as impression,
clicks as click,
conversion,
spend as cost
 FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_asset_metrics`
),

video_data as (

SELECT 
Date(stat_time_day) as dt,
'Tiktok Ads' as source,
campaign_id,
campaign_name,
adgroup_id as ad_group_id,
adgroup_name as ad_group_name,
ad_id,
ad_name,
video_material_id as creative_id,
'VIDEO' as creative_type,
impressions as impression,
clicks as click,
conversion,
spend as cost
 FROM `srpproduct-dc37e.fivetran_tiktok_ads.creative_metrics`
),

tiktok_union_data as (

select 
dt
,a.source
,b.account_id
,b.account_name
,coalesce(a.campaign_id,b.campaign_id) as campaign_id
,coalesce(a.campaign_name,b.campaign_name) as campaign_name
,coalesce(a.ad_group_id,b.ad_group_id) as ad_group_id
,coalesce(a.ad_group_name,b.ad_group_name) as ad_group_name
,a.ad_id
,a.ad_name
,a.creative_id
,c.creative_name
,a.creative_type
,a.google_youtube_video_id
,a.google_youtube_video_title
,sum(impression) as impression
,sum(click) as click
,sum(cost) as cost
,sum(conversion) as conversion
,channel
from (
SELECT  dt
       ,source
       ,cast(null AS string)          AS account_id
       ,cast(null AS string)          AS account_name
       ,cast(campaign_id AS string)   AS campaign_id
       ,cast(campaign_name AS string) AS campaign_name
       ,cast(ad_group_id AS string)   AS ad_group_id
       ,cast(ad_group_name AS string) AS ad_group_name
       ,cast(ad_id AS string)         AS ad_id
       ,ad_name
       ,cast(creative_id AS string)   AS creative_id
       ,cast(null AS string)          AS creative_name
       ,cast(creative_type AS string) AS creative_type
       ,cast(null AS string)          AS google_youtube_video_id
       ,cast(null AS string)          AS google_youtube_video_title
       ,impression
       ,click
       ,cost
       ,conversion
       ,upper(source)                 AS channel
FROM image_data
UNION ALL
SELECT  dt
       ,source
       ,cast(null AS string)          AS account_id
       ,cast(null AS string)          AS account_name
       ,cast(campaign_id AS string)   AS campaign_id
       ,cast(campaign_name AS string) AS campaign_name
       ,cast(ad_group_id AS string)   AS ad_group_id
       ,cast(ad_group_name AS string) AS ad_group_name
       ,cast(ad_id AS string)         AS ad_id
       ,ad_name
       ,cast(creative_id AS string)   AS creative_id
       ,cast(null AS string)          AS creative_name
       ,cast(creative_type AS string) AS creative_type
       ,cast(null AS string)          AS google_youtube_video_id
       ,cast(null AS string)          AS google_youtube_video_title
       ,impression
       ,click
       ,cost
       ,conversion
       ,upper(source)                 AS channel
FROM video_data

) a
left join  (select * from `favie_dw.dim_all_app_ad_full_1d_view` where source='Tiktok Ads' ) b
on a.source=b.source and a.ad_id=b.ad_id and a.ad_id !=upper(a.source)
left join (select material_id,max(file_name) as creative_name from `fivetran_tiktok_ads.video_history` group by material_id) c
on a.creative_id=c.material_id 
group by
dt
,a.source
,b.account_id
,b.account_name
,coalesce(a.campaign_id,b.campaign_id) 
,coalesce(a.campaign_name,b.campaign_name) 
,coalesce(a.ad_group_id,b.ad_group_id) 
,coalesce(a.ad_group_name,b.ad_group_name)
,a.ad_id
,a.ad_name
,a.creative_id
,c.creative_name
,a.creative_type
,a.google_youtube_video_id
,a.google_youtube_video_title
,channel
),
expand_dim_data as (
       select 

 a.dt
,a.source
,a.account_id
,a.account_name
,a.campaign_id
,a.campaign_name
,a.ad_group_id
,a.ad_group_name
,a.ad_id
,a.ad_name
,a.creative_id
,a.creative_name
,a.creative_type
,a.google_youtube_video_id
,a.google_youtube_video_title
,a.impression
,a.click
,a.cost
,a.conversion
,a.channel
,b.platform
,b.app_name
,b.country_code
,b.ad_category
,b.account_put_type
,b.account_open_agency
       from 
       tiktok_union_data a 
       left join (select * from `favie_dw.dim_all_app_ad_full_1d_view` where source = 'Tiktok Ads') b
       on cast(a.ad_id as string) = b.ad_id and cast(a.ad_group_id as string) = b.ad_group_id and cast(a.campaign_id as string) = b.campaign_id
)




SELECT
coalesce(a.dt,b.dt) as dt
,coalesce(a.source,b.source) as source
,coalesce(a.platform,b.platform) as platform
,coalesce(a.app_name,b.app_name) as app_name
,coalesce(a.account_id,b.account_id) as account_id
,coalesce(a.account_name,b.account_name) as account_name
,coalesce(a.campaign_id,b.campaign_id) as campaign_id
,coalesce(a.campaign_name,b.campaign_name) as campaign_name
,coalesce(a.ad_group_id,b.ad_group_id) as ad_group_id
,coalesce(a.ad_group_name,b.ad_group_name) as ad_group_name
,coalesce(a.ad_id,b.ad_id) as ad_id
,coalesce(a.ad_name,b.ad_name) as ad_name
,coalesce(a.country_code,b.country_code) as country_code
,coalesce(a.ad_category,b.ad_category) as ad_category
,coalesce(a.account_put_type,b.account_put_type) as account_put_type
,coalesce(a.account_open_agency,b.account_open_agency) as account_open_agency
,coalesce(b.creative_id,'UNKNOWN') as creative_id
,coalesce(b.creative_name,'UNKNOWN') as creative_name
,coalesce(b.creative_type,'AD') as creative_type
,coalesce(upper(b.account_name),upper(a.account_name)) as channel
,coalesce(b.impression,a.impression) as impression
,coalesce(b.click,coalesce(a.click,0)) as click
,coalesce(b.cost,a.cost) as cost
,coalesce(b.conversion,a.conversion) as conversion
,case when sum(b.conversion) over (partition by  b.dt,b.ad_id )  != 0
then coalesce(safe_divide(b.conversion, sum(b.conversion) over (partition by  b.dt,b.ad_id ) )  ,1) 
 else coalesce(safe_divide(b.cost, sum(b.cost) over (partition by  b.dt,b.ad_id ) )  ,1) end as weight
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
where source = 'Tiktok Ads'
)a
FULl JOIN  expand_dim_data b
ON a.dt = b.dt AND a.ad_id = b.ad_id AND a.ad_group_id = b.ad_group_id AND a.campaign_id = b.campaign_id;