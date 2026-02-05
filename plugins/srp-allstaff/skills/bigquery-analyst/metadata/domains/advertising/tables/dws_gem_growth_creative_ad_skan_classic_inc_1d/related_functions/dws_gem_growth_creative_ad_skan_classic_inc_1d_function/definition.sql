SELECT
coalesce(b.dt,a.dt) as dt
,coalesce(b.source,a.source) as source
,coalesce(b.platform,a.platform) as platform
,coalesce(b.app_name,a.app_name) as app_name
,coalesce(b.account_id,a.account_id) as account_id
,coalesce(b.account_name,a.account_name) as account_name
,coalesce(b.campaign_id,a.campaign_id) as campaign_id
,coalesce(b.campaign_name,a.campaign_name) as campaign_name
,coalesce(b.ad_group_id,a.ad_group_id) as ad_group_id
,coalesce(b.ad_group_name,a.ad_group_name) as ad_group_name
,coalesce(b.ad_id,a.ad_id) as ad_id
,coalesce(b.ad_name,a.ad_name) as ad_name
,coalesce(b.country_code,a.country_code) as country_code
,coalesce(b.ad_category,a.ad_category) as ad_category
,coalesce(b.account_put_type,a.account_put_type) as account_put_type  
,coalesce(b.account_open_agency,a.account_open_agency) as account_open_agency
,coalesce(attribution_method,'BOTH') as attribution_method


, coalesce(creative_id,'AD') as creative_id
, coalesce(creative_name,'AD') as creative_name
, coalesce(b.creative_type,'AD') as creative_type


,coalesce(f_creative_id,'AD')   as f_creative_id
,coalesce(f_creative_name,'AD') as f_creative_name
,coalesce(f_creative_url,'AD')  as f_creative_url
,coalesce(f_creative_type,'AD') as f_creative_type


,coalesce(b.tag_source,'UNKNOWN') as tag_source
,coalesce(b.creative_language_tag,'UNKNOWN') as creative_language_tag
,coalesce(b.creative_func_tag,'UNKNOWN') as creative_func_tag
,coalesce(b.creative_source_tag,'UNKNOWN') as creative_source_tag
,coalesce(b.creative_race_tag,'UNKNOWN') as creative_race_tag
,coalesce(b.creative_gender_tag,'UNKNOWN') as creative_gender_tag
,coalesce(b.creative_created_at,Date('1999-01-01')) as creative_created_at

,b.google_youtube_video_id
,b.google_youtube_video_title
,coalesce(a.channel,'ON_LINE') as channel


,coalesce(b.impression,a.impression) as creative_impression
,coalesce(b.click,a.click) as creative_click
,coalesce(b.conversion,a.conversion) as creative_conversion 
,coalesce(b.cost,a.cost) as creative_cost
,coalesce(weight*a.impression,a.impression) as impression 
,coalesce(weight*a.click,a.click) as click 
,coalesce(weight*a.conversion,a.conversion) as conversion 
,coalesce(weight*a.cost,a.cost) as cost 
,coalesce(weight*install_cnt,install_cnt) as creative_install_cnt
,coalesce(weight*new_user_cnt,new_user_cnt) as creative_new_user_cnt
,coalesce(weight*d0_active_cnt,d0_active_cnt) as creative_d0_active_cnt
,coalesce(weight*d1_retention_cnt,d1_retention_cnt) as creative_d1_retention_cnt
,coalesce(weight*lt7_cnt,lt7_cnt) as creative_lt7_cnt
FROM (select * from `favie_dw.dws_gem_growth_ad_skan_and_classic_metrics_inc_1d` where dt = dt_param)a
left join (select * from `favie_dw.dwd_growth_ad_all_source_creative_with_tag_inc_1d_view` where dt = dt_param) b
on a.dt=b.dt and a.ad_id=b.ad_id and a.campaign_id=b.campaign_id and a.ad_group_id=b.ad_group_id