CREATE VIEW `srpproduct-dc37e.favie_dw.dim_ad_all_source_creative_multiple_full_1d_view`
AS with union_data as (
-- Google 广告素材数据
SELECT  
        -- 基础字段 (21个共同字段)
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

       -- 素材字段
       ,creative_id
       ,creative_name
       ,creative_type
       

       -- 素材唯一id
       ,f_creative_id
       ,f_creative_name
       ,f_creative_url
       ,f_creative_type
       ,f_creative_category


       -- 视频/图片字段 (Google没有，需要填充NULL)
       ,cast(null as string) as external_website_creative_url
       ,cast(null as string) as format
       ,video_id
       ,cast(null as string) as video_url
       ,video_name
       ,cast(null as TIMESTAMP) as video_updated_at
       ,cast(null as TIMESTAMP) as video_created_at  -- Meta 和 TikTok 都有
       ,cast(null as string) as image_id
       ,cast(null as string) as image_url
       ,cast(null as string) as image_name
       ,cast(null as TIMESTAMP) as image_created_at
       ,cast(null as TIMESTAMP) as image_updated_at
       ,cast(null as string) as internal_creative_id
       ,cast(null as string) as internal_creative_url
       ,post_id
       
       -- TikTok 特有字段
       ,cast(null as string) as external_creative_id
       ,cast(null as string) as video_expire_time

      
FROM `favie_dw.dim_ad_google_creative_multiple_full_1d_view`

UNION ALL 

-- Meta 广告素材数据
SELECT 
       -- 基础字段 (21个共同字段)
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

       -- 素材字段
       ,creative_id
       ,creative_name
       ,creative_type

       --素材唯一id
       ,f_creative_id
       ,f_creative_name
       ,f_creative_url
       ,f_creative_type
       , case when f_creative_type  in (' UNKNOWN','ERROR') then 'UNKNOWN' 
       when f_creative_type = 'KOL' then 'KOL'
       else 'NON_KOL' end as f_creative_category

       -- 视频/图片字段
       ,external_website_creative_url
       ,format
       ,video_id
       ,video_url
       ,video_name
       ,video_updated_at
       ,video_created_at  -- Meta 有此字段
       ,image_id
       ,image_url
       ,image_name
       ,cast(image_created_at as TIMESTAMP) as image_created_at
       ,cast(image_updated_at as TIMESTAMP)  as image_updated_at
       ,internal_creative_id
       ,internal_creative_url
       ,post_id
       
       -- TikTok 特有字段 (Meta没有，需要填充NULL)
       ,external_creative_id
       ,cast(null as string) as video_expire_time
FROM `favie_dw.dim_ad_meta_creative_multiple_full_1d_view`


UNION ALL 

-- TikTok 广告素材数据
SELECT
       -- 基础字段 (21个共同字段)
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
       ,case when f_creative_type  in (' UNKNOWN','ERROR') then 'UNKNOWN' 
       when f_creative_type = 'KOL' then 'KOL'
       else 'NON_KOL' end as f_creative_category
       
       -- 视频/图片字段
       ,external_website_creative_url
       ,format
       ,video_id
       ,video_url
       ,video_name
       ,cast(video_updated_at as TIMESTAMP) as video_updated_at
       ,cast(video_created_at as TIMESTAMP)  as video_created_at -- TikTok 的 video_create_at 映射到 video_created_at
       ,image_id
       ,image_url
       ,image_name
       ,image_created_at
       ,image_updated_at
       ,internal_creative_id
       ,internal_creative_url
       ,post_id
       
       -- TikTok 特有字段
       ,external_creative_id
       ,video_expire_time
FROM `favie_dw.dim_ad_tiktok_creative_multiple_full_1d_view`  ) 


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
              ,row_number() over (partition by ad_id,creative_id   ) as overflow_seq
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
	       ,ROW_NUMBER() OVER (PARTITION BY ad_id,f_creative_id,creative_id order by case when creative_id is not null then 1 else 0 end desc ) AS rk
              
	FROM union_data
	WHERE f_creative_id is not null 
)
WHERE rk = 1;