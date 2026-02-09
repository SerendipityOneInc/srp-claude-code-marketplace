CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_meta_all_creative_fivetran_inc_1d_view`
AS with image_data as (
select 
date as dt,
'Meta Ads' as source,
account_id,
account_name,
campaign_id,
campaign_name,
adset_id as ad_group_id,
adset_name as ad_group_name,
ad_id,
ad_name,
image_asset_id as creative_id  ,
image_asset_name as creative_name ,
'IMAGE' as creative_type,
impressions as impression,
clicks as click,
--这个reach 不对
reach  as conversion,
spend as cost,
--这里用来区分渠道
upper(account_name) as channel,
from 
`srpproduct-dc37e.fivetran_facebook_ads_full.image_asset_metrics`  
),

video_data as (
select 
date as dt,
'Meta Ads' as source,
account_id,
account_name,
campaign_id,
campaign_name,
adset_id as ad_group_id,
adset_name as ad_group_name,
ad_id,
ad_name,
video_asset_video_id as creative_id  ,
video_asset_video_name as creative_name ,
'VIDEO' as creative_type,
impressions as impression,
clicks as click,
--这个reach 不对
reach  as conversion,
spend as cost,
--这里用来区分渠道
upper(account_name) as channel,
from 
`srpproduct-dc37e.fivetran_facebook_ads_full.video_asset_metrics` a
)
, meta_union_data as (

select 
dt
,source
,account_id
,account_name
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
,sum(impression) as impression
,sum(click) as click
,sum(cost) as cost
,sum(conversion)  as conversion
,channel
from (
SELECT  dt
       ,cast(source as string) as source
       ,cast(account_id as string) as account_id
       ,cast(account_name as string) as account_name
       ,cast(campaign_id as string) as campaign_id
       ,cast(campaign_name as string) as campaign_name
       ,cast(ad_group_id as string) as ad_group_id
       ,cast(ad_group_name as string) as ad_group_name
       ,cast(ad_id as string) as ad_id
       ,cast(ad_name as string) as ad_name
       ,cast(creative_id as string) as creative_id
       ,cast(creative_name as string) as creative_name
       ,cast(creative_type as string) as creative_type
       ,cast(null as string) AS google_youtube_video_id
       ,cast(null as string) AS google_youtube_video_title
       ,impression
       ,click
       ,cost
       ,conversion
       ,channel

FROM image_data
union all 

SELECT  dt
       ,cast(source as string) as source
       ,cast(account_id as string) as account_id
       ,cast(account_name as string) as account_name
       ,cast(campaign_id as string) as campaign_id
       ,cast(campaign_name as string) as campaign_name
       ,cast(ad_group_id as string) as ad_group_id
       ,cast(ad_group_name as string) as ad_group_name
       ,cast(ad_id as string) as ad_id
       ,cast(ad_name as string) as ad_name
       ,cast(creative_id as string) as creative_id
       ,cast(creative_name as string) as creative_name
       ,cast(creative_type as string) as creative_type
       ,cast(null as string) AS google_youtube_video_id
       ,cast(null as string) AS google_youtube_video_title
       ,impression
       ,click
       ,cost
       ,conversion
       ,channel
FROM video_data
)

group by dt
,source
,account_id
,account_name
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
,channel

)
,
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
,a.channel
,b.platform
,b.app_name
,b.country_code
,b.ad_category
,b.account_put_type
,b.account_open_agency
,impression
,click
,cost
,conversion

from meta_union_data a
left join (select * from `favie_dw.dim_all_app_ad_full_1d_view` where source = 'Meta Ads') b
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
,case when b.cost is not null then safe_divide(b.cost,a.cost)*a.conversion else a.conversion end  as conversion
,case when b.cost is not null  then safe_divide(b.cost,a.cost) else 1 end as weight


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
where source = 'Meta Ads'
)a
FULL JOIN expand_dim_data b
ON a.dt = b.dt AND a.ad_id = b.ad_id AND a.ad_group_id = b.ad_group_id AND a.campaign_id = b.campaign_id;