CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_growth_ad_all_source_creative_with_tag_inc_1d_view`
AS SELECT  a.dt
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
       ,a.f_creative_id
       ,a.f_creative_name
       ,a.f_creative_url
       ,a.f_creative_type
       ,a.creative_created_at
       ,a.overflow_seq
       ,a.creative_id
       ,a.creative_name
       ,a.creative_type
       ,a.google_youtube_video_id
       ,a.google_youtube_video_title
       ,a.channel
       
       ,c.tag_source
       ,c.creative_language_tag
       ,c.creative_func_tag
       ,c.creative_source_tag
       ,c.creative_race_tag
       ,c.creative_gender_tag
       
       ,a.impression
       ,a.click
       ,a.cost
       ,a.conversion
       ,a.weight
FROM `favie_dw.dwd_growth_ad_all_source_creative_with_supply_inc_1d_view` a
LEFT JOIN `favie_dw.dim_ad_all_source_history_creative_tag_full_view` b
ON a.f_creative_id = b.f_creative_id
left join `favie_dw.dim_ad_all_source_creative_unique_full_1d_view` c
on a.ad_id=c.ad_id and a.f_creative_id=c.f_creative_id;