CREATE VIEW `srpproduct-dc37e.favie_dw.dw_ad_all_source_creative_multiple_full_1d_view`
AS SELECT  
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
       ,creative_id
       ,creative_name
       ,creative_type
       ,creative_url
       ,channel
       ,creative_source
       
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
       ,cast(null as string) as post_id
       
       -- TikTok 特有字段
       ,cast(null as string) as external_creative_id
       ,cast(null as TIMESTAMP ) as kol_ad_create_at
       ,cast(null as TIMESTAMP) as kol_ad_updated_at
       ,cast(null as string) as material_id
       ,cast(null as string) as video_expire_time
       ,creative_uuid
       
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
       ,creative_id
       ,creative_name
       ,creative_type
       ,creative_url
       ,channel
       ,creative_source
       
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
       ,cast(null as TIMESTAMP) as kol_ad_create_at
       ,cast(null as TIMESTAMP) as kol_ad_updated_at
       ,cast(null as string) as material_id
       ,cast(null as string) as video_expire_time
       ,creative_uuid
       
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
       ,creative_id
       ,creative_name
       ,creative_type
       ,creative_url
       ,channel
       ,creative_source
       
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
       ,kol_ad_create_at
       ,kol_ad_updated_at
       ,material_id
       ,video_expire_time
       
       , creative_uuid
FROM `favie_dw.dim_ad_tiktok_creative_multiple_full_1d_view`;