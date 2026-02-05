CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_meta_fivetran_creative_id_inc_1d_view`
AS select 
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
-- video_asset_id 这个id 不是creative id,但是两个相似的视频可能对应的是同一个id
video_asset_video_id as creative_id    ,
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
`srpproduct-dc37e.fivetran_facebook_ads_full.video_asset_metrics` a;