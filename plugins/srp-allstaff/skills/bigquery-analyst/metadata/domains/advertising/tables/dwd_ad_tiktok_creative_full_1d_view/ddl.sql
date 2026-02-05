CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_ad_tiktok_creative_full_1d_view`
AS with creative_data as (
SELECT  source
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
       ,a.channel
       ,cast(coalesce(b.video_id,e.video_id)  as string )                  AS video_id
       ,cast(coalesce(b.material_id,d.material_id) as string )             AS material_id
       ,cast(coalesce(b.video_name,e.video_name) as string )               AS video_name
       ,cast(coalesce(b.video_url,e.video_url)    as string )             AS video_url
       ,cast(coalesce(b.video_expire_time,e.video_expire_time) as string ) AS video_expire_time
	   ,coalesce(b.create_at,e.create_at) as video_create_at
	   ,coalesce(b.updated_at,e.updated_at) as video_updated_at
       ,cast(c.post_id as string ) AS post_id
	  ,c.create_at as kol_ad_create_at
	   ,c.updated_at as kol_ad_updated_at
	  
       ,cast(d.image_id as string ) AS image_id
       ,cast(d.image_name as string ) AS image_name
       ,cast(d.image_url as string ) AS image_url
	    ,d.created_at as image_created_at
	   ,d.updated_at as image_updated_at
	  
       ,a.conversion
       ,a.cost
       
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
	       ,creative_name
	       ,creative_type
	       ,channel
         ,sum(conversion) as conversion
         ,sum(cost) as cost
	FROM `favie_dw.dwd_growth_ad_tiktok_all_creative_fivetran_inc_1d_view`
	GROUP BY  source
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
	         ,channel
) a
LEFT JOIN
(
	SELECT  *
	FROM
	(
		SELECT  preview_url                   AS video_url
		       ,Date(preview_url_expire_time) AS video_expire_time
		       ,material_id
		       ,video_id
		       ,file_name                     AS video_name
           ,create_time as create_at
           ,updated_at  as updated_at
		       ,ROW_NUMBER() OVER (PARTITION BY material_id ORDER BY  CASE WHEN preview_url is not null THEN 1 else 0 end ,Date(preview_url_expire_time) DESC ,( create_time) asc ,( updated_at)  desc  ) AS rk
		FROM `srpproduct-dc37e.fivetran_tiktok_ads.video_history`
	)
	WHERE rk = 1 
) b
ON b.material_id = a.creative_id
LEFT JOIN
(
	SELECT  ad_id
	       ,MAX(tiktok_item_id) AS post_id
         ,max(updated_at) as updated_at
         ,min(create_time) as create_at
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.ad_history`
	WHERE ad_id is not null
	GROUP BY  ad_id
)c
ON cast(a.ad_id AS string) = cast(c.ad_id AS string)
LEFT JOIN
(
	SELECT  material_id
	       ,MAX(image_url) AS image_url
	       ,MAX(file_name) AS image_name
	       ,MAX(image_id)  AS image_id
         ,max(updated_at) as updated_at
         ,min(created_at) as created_at
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_history`
	WHERE material_id is not null
	GROUP BY  material_id
) d
ON a.creative_id = d.material_id
LEFT JOIN
(
	SELECT  *
	FROM
	(
		SELECT  ad_id
		       ,preview_url                                                                                                                               AS video_url
		       ,t1.video_id
		       ,material_id
		       ,file_name                                                                                                                                 AS video_name
		       ,Date(preview_url_expire_time)                                                                                                             AS video_expire_time
			   ,t2.create_time as create_at
               ,t2.updated_at  as updated_at
		       ,ROW_NUMBER() OVER (PARTITION BY ad_id ORDER BY  CASE WHEN preview_url is not null THEN 1 else 0 end ,Date(preview_url_expire_time) DESC ,Date( t2.create_time) asc ,Date( t2.updated_at)  desc ) AS rk
		FROM `srpproduct-dc37e.fivetran_tiktok_ads.ad_history` t1
		JOIN `srpproduct-dc37e.fivetran_tiktok_ads.video_history` t2
		ON t1.video_id = t2.video_id
	)
	WHERE rk = 1
	AND ad_id is not null 
)e
ON cast(a.ad_id AS string) = cast(e.ad_id AS string) 
)



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
       ,creative_name
       ,creative_type
       ,channel
       ,video_id
       ,material_id
       ,video_name
       ,video_url
       ,video_expire_time
       ,post_id
       ,image_id
       ,image_name
       ,image_url
       ,conversion
       ,cost
       ,external_creative_id
       ,internal_creative_url
       ,external_website_creative_url
	   ,video_create_at
	   ,video_updated_at
	   ,kol_ad_create_at
	   ,kol_ad_updated_at
	   ,image_created_at
	   ,image_updated_at
	   ,internal_creative_id
       ,coalesce(internal_creative_url,video_url,external_website_creative_url,image_url) AS creative_url
	   ,case when internal_creative_url is not null  and lower(creative_type) = 'video' then 'INTENAL_VIDEO_LIBRARY'
	   when internal_creative_url is not null  and lower(creative_type) = 'image' then 'INTENAL_IMAGE_LIBRARY'
	   when video_url is not null  then 'EXTERNAL_VIDEO'
	   when image_url is not null then 'EXTERNAL_IMAGE'
	   when external_website_creative_url is not null then 'KOL_VIDEO'
	   else 'UNKNOWN' end as creative_source
FROM
(
	SELECT  a.source
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
	       ,a.channel
	       ,a.video_id
	       ,a.material_id
	       ,a.video_name
	       ,a.video_url
	       ,a.video_expire_time
	       ,a.post_id as post_id
	       ,a.image_id
	       ,a.image_name
	       ,a.image_url
	       ,a.conversion
	       ,a.cost
	       ,b.external_creative_id
		   ,a.video_create_at
		   ,a.video_updated_at
		   ,a.kol_ad_create_at
		   ,a.kol_ad_updated_at
		   ,a.image_created_at
		   ,a.image_updated_at
	       ,CASE WHEN format IN ('jpeg','mp4','png') THEN concat('https://pub-7faa04a50308437f90b3a69eac4ca3da.r2.dev/',internal_creative_id,'.',format)  ELSE null END AS internal_creative_url
	       ,concat('https://www.tiktok.com/@_/video/',post_id) AS external_website_creative_url
		   ,internal_creative_id
	FROM creative_data a
	LEFT JOIN
	(
		SELECT  external_creative_id,max(external_creative_id),max(internal_creative_id) as internal_creative_id ,max(format) as format
		FROM `favie_dw.dim_ad_all_app_creative_full_1d`
		WHERE dt = (
		SELECT  MAX(dt)
		FROM `favie_dw.dim_ad_all_app_creative_full_1d`)
    and source='Meta'
    group by external_creative_id
	) b
	ON a.video_id = b.external_creative_id or a.image_id = b.external_creative_id
);