CREATE VIEW `srpproduct-dc37e.favie_dw.dim_ad_all_source_creative_unique_full_1d_view`
AS with base_data as (
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
	       ,channel
	       ,creative_id
	       ,creative_name
	       ,creative_type
	       ,f_creative_id
	       ,f_creative_name
	       ,f_creative_url
	       ,f_creative_type
		   ,f_creative_category
	       ,external_website_creative_url
	       ,format
	       ,video_id
	       ,video_url
	       ,video_name
	       ,video_updated_at
	       ,video_created_at
	       ,image_id
	       ,image_url
	       ,image_name
	       ,image_created_at
	       ,image_updated_at
	       ,internal_creative_id
	       ,internal_creative_url
	       ,post_id
	       ,external_creative_id
	       ,video_expire_time
           ,overflow_seq
from (
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
	       ,channel
	       ,creative_id
	       ,creative_name
	       ,creative_type
	       ,f_creative_id
	       ,f_creative_name
	       ,f_creative_url
	       ,f_creative_type
		   ,f_creative_category
	       ,external_website_creative_url
	       ,format
	       ,video_id
	       ,video_url
	       ,video_name
	       ,video_updated_at
	       ,video_created_at
	       ,image_id
	       ,image_url
	       ,image_name
	       ,image_created_at
	       ,image_updated_at
	       ,internal_creative_id
	       ,internal_creative_url
	       ,post_id
	       ,external_creative_id
	       ,video_expire_time
           ,overflow_seq
          ,row_number() over (partition by ad_id,f_creative_id order by case when creative_id is not null then 1 else 0 end desc ) as rk
from `favie_dw.dim_ad_all_source_creative_multiple_full_1d_view`
)
where rk=1
)



	select 
		 a.source
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
	    ,a.channel
	    ,a.creative_id
	    ,a.creative_name
	    ,a.creative_type
	    ,a.f_creative_id
	    ,a.f_creative_name
	    ,a.f_creative_url
	    ,a.f_creative_type
		,a.f_creative_category
	    ,a.external_website_creative_url
	    ,a.format
	    ,a.video_id
	    ,a.video_url
	    ,a.video_name
	    ,a.video_updated_at
	    ,a.video_created_at
	    ,a.image_id
	    ,a.image_url
	    ,a.image_name
	    ,a.image_created_at
	    ,a.image_updated_at
	    ,a.internal_creative_id
	    ,a.internal_creative_url
	    ,
		 case when a.source='Meta Ads' then coalesce(REGEXP_EXTRACT(a.ad_name, r'post[-_]?id[-_]+([^_]+)'),REGEXP_EXTRACT(a.ad_name, r'post[-_]+([^_]+)'),a.post_id) 
		 else a.post_id end as post_id 
	    ,a.external_creative_id
	    ,a.video_expire_time
        ,a.overflow_seq
		,CASE WHEN b.language is not null THEN b.language  ELSE REGEXP_EXTRACT(lower(if(coalesce(a.f_creative_name,'UNKNOWN')='UNKNOWN',coalesce(a.ad_name,'UNKNOWN'),a.f_creative_name)),r'[_]+language[_]+([^_]+)(?:_|$)') END AS creative_language_tag
        ,case when b.language is not null  then 'HISTORY_MANUAL_TAG' else 'NON_HISTORY_MANUAL_TAG' end as tag_source
        ,CASE WHEN b.func is not null THEN b.func  ELSE REGEXP_EXTRACT(lower(if(coalesce(a.f_creative_name,'UNKNOWN')='UNKNOWN',coalesce(a.ad_name,'UNKNOWN'),a.f_creative_name)),r'[_]+func[_]+([^_]+)(?:_|$)') END       AS creative_func_tag
        ,REGEXP_EXTRACT(lower(if(coalesce(a.f_creative_name,'UNKNOWN')='UNKNOWN',coalesce(a.ad_name,'UNKNOWN'),a.f_creative_name)),r'[_]+source[_]+([^_]+)(?:_|$)') AS creative_source_tag
        ,CASE WHEN b.race is not null THEN b.race  ELSE REGEXP_EXTRACT(lower(if(coalesce(a.f_creative_name,'UNKNOWN')='UNKNOWN',coalesce(a.ad_name,'UNKNOWN'),a.f_creative_name)),r'[_]+race[_]+([^_]+)(?:_|$)') END       AS creative_race_tag
        ,CASE WHEN b.gender is not null THEN b.gender  ELSE REGEXP_EXTRACT(lower(if(coalesce(a.f_creative_name,'UNKNOWN')='UNKNOWN',coalesce(a.ad_name,'UNKNOWN'),a.f_creative_name)),r'[_]+gender[_]+([^_]+)(?:_|$)') END AS creative_gender_tag
		from base_data a
		left join `favie_dw.dim_ad_all_source_history_creative_tag_full_view` b
		on  a.f_creative_id = b.f_creative_id;