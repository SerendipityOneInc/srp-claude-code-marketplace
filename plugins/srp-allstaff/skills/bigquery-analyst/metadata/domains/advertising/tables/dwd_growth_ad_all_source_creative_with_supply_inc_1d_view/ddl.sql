CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_all_source_creative_with_supply_inc_1d_view`
AS select 
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
,f_creative_id
,f_creative_name
,f_creative_url
,f_creative_type
,overflow_seq
,sum(impression) as impression
,sum(click) as click
,sum(cost) as cost
,sum(conversion) as conversion
,sum(weight) as weight
,max(creative_id ) as creative_id
,max(creative_name) as creative_name
,max(creative_type) as creative_type
,max(google_youtube_video_id ) as google_youtube_video_id
,max(google_youtube_video_title) as google_youtube_video_title
,max(channel) as channel
,min(creative_created_at) as creative_created_at

from (
select 
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
,a.creative_id
,a.creative_name
,a.creative_type
,a.google_youtube_video_id
,a.google_youtube_video_title
,a.channel
,a.impression
,a.click
,a.cost
,a.conversion
,a.weight
,a.creative_created_at
,coalesce(b.f_creative_id,'UNKNOWN')    as f_creative_id
,coalesce(b.f_creative_name,'UNKNOWN')  as f_creative_name
,coalesce(b.f_creative_url,'UNKNOWN')   as f_creative_url
,coalesce(b.f_creative_type,'UNKNOWN')  as f_creative_type
,coalesce(b.overflow_seq,1) as overflow_seq

from `favie_dw.dwd_growth_ad_all_source_creative_inc_1d_view` a
left join `favie_dw.dim_ad_all_source_creative_multiple_full_1d_view` b 
on  a.ad_id=b.ad_id and a.creative_id=b.creative_id
)
group by 
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
,f_creative_id
,f_creative_name
,f_creative_url
,f_creative_type
,overflow_seq;