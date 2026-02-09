CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_tiktok_image_fivetran_inc_1d_view`
AS SELECT 
Date(stat_time_day) as dt,
'Tiktok Ads' as source,
campaign_id,
campaign_name,
adgroup_id as ad_group_id,
adgroup_name as ad_group_name,
ad_id,
ad_name,
image_id as creative_id,
'image' as creative_type,
impressions as impression,
clicks as click,
conversion,
spend as cost
 FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_asset_metrics`;