CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_all_source_creative_inc_1d_view`
AS with base_data as (
select 
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
,creative_id
,creative_name
,creative_type
,google_youtube_video_id
,google_youtube_video_title
,channel
,impression
,click
,cost
,conversion
,weight
from (
select 
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
,creative_id
,creative_name
,creative_type
,google_youtube_video_id
,google_youtube_video_title
,channel
,impression
,click
,cost
,conversion
,weight
from favie_dw.dwd_growth_ad_google_all_creative_fivetran_inc_1d_view

union all 
select 

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
,creative_id
,creative_name
,creative_type
,cast(null as string ) as google_youtube_video_id
,cast(null as string ) as google_youtube_video_title
,channel
,impression
,click
,cost
,conversion
,weight

from 
`favie_dw.dwd_growth_ad_meta_all_creative_fivetran_inc_1d_view`

union all 
select 

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
,creative_id
,creative_name
,creative_type
,cast(null as string ) as google_youtube_video_id
,cast(null as string ) as google_youtube_video_title
,channel
,impression
,click
,cost
,conversion
,weight
from 
`favie_dw.dwd_growth_ad_tiktok_all_creative_fivetran_inc_1d_view`
)
)
select 
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
,creative_id
,creative_name
,creative_type
,google_youtube_video_id
,google_youtube_video_title
,channel
,impression
,click
,cost
,conversion
,weight
,min(dt) over (partition by if(coalesce(creative_id,'UNKNOWN')='UNKNOWN',ad_id,creative_id) ) as creative_created_at

from base_data;