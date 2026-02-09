CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_growth_ad_tiktok_fivetran_ad_geo_inc_1d_view`
AS SELECT  
cast(a.ad_id as string ) ad_id 
,country_code
,DATE(stat_time_day) AS dt
,cast(b.adgroup_id as string ) as ad_group_id
,cast(b.campaign_id   as string    )as campaign_id
,a._fivetran_synced
,conversion
,spend
,clicks
,cost_per_landing_page_view
,likes
,profile_visits_rate
,cost_per_result
,result_rate
,follows
,total_landing_page_view
,result
,real_time_conversion
,aeo_type
,real_time_result
,comments
,cost_per_conversion
,cpc
,clicks_on_music_disc
,real_time_cost_per_conversion
,landing_page_view_rate
,real_time_conversion_rate
,ctr
,shares
,profile_visits
,real_time_result_rate
,impressions
,real_time_cost_per_result
,cpm
,conversion_rate
FROM srpproduct-dc37e.fivetran_tiktok_ads.ad_country_report a 
left join (select ad_id,adgroup_id,campaign_id from srpproduct-dc37e.fivetran_tiktok_ads.ad_history group by ad_id,adgroup_id,campaign_id ) b 
on a.ad_id=b.ad_id;