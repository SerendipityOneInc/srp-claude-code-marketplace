CREATE VIEW `srpproduct-dc37e.favie_dw.dim_ad_google_creative_multiple_full_1d_view`
AS with base_data as (
SELECT  source
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
       ,creative_url 
       ,creative_name
       ,creative_type
       ,video_id
       ,video_name
       ,channel
FROM
(
	SELECT  source
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
	       ,creative_url
	       ,creative_name
	       ,creative_type
	       ,google_youtube_video_id as video_id
	       ,google_youtube_video_title as video_name
	       ,channel
	       ,ROW_NUMBER() OVER (PARTITION BY creative_id,ad_id ORDER BY  dt DESC ) AS rk 
	FROM `favie_dw.dwd_growth_ad_google_all_creative_fivetran_inc_1d_view`
)
WHERE rk = 1 )


select 
source
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


,creative_id as f_creative_id
,creative_name as f_creative_name
,creative_url as f_creative_url
,case when b.author_name is not null and  b.author_name not in ('Gensmo','VIDEO YT FIN','hong peng')  then 'KOL' 
when  lower(creative_type) like '%video%' then 'EXTERNAL_VIDEO'
when  lower(creative_type) like '%image%' then 'EXTERNAL_IMAGE'
when  lower(creative_type) not in ('video','image') and creative_url is not null then 'EXTERNAL_TEXT' end as f_creative_type
,case when b.author_name is not null and  b.author_name not in ('Gensmo','VIDEO YT FIN','hong peng')  then 'KOL'   else 'NON_KOL' end as f_creative_category 


,a.video_id
,a.video_name
,channel
, a.video_id as post_id



from base_data a 
left join `favie_dw.dim_ad_google_creative_youtube_video_info_full` b
on a.video_id = b.video_id;