CREATE VIEW `srpproduct-dc37e.favie_dw.dim_ad_meta_creative_multiple_full_1d_view`
AS with ad_level_video_data as (

--不会产生笛卡尔积
SELECT  a.id             AS ad_id
       ,a.ad_set_id      AS ad_group_id
       ,a.campaign_id    AS campaign_id
       ,a.creative_id    AS creative_id
       ,a.created_time   AS ad_created_at
       ,b.video_video_id AS video_id
	   ,c.source as video_url
	   ,c.title as video_name
	   ,c.updated_time as video_updated_at
	   ,c.created_time as video_created_at
--这个ad_history是实际上是ad*creative id 粒度
FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_history` a
 JOIN
(
	--一个video id 严格代表了一个视频
	--但是一个video id 会对应多个 creative id
	SELECT  id
	       ,video_video_id AS video_video_id
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.creative_history`
	where id is not null  and video_video_id is not null 
	GROUP BY  1,2
) b
ON a.creative_id = b.id
LEFT JOIN
(
	SELECT  id
	       ,source
	       ,title
				 ,max(updated_time) as updated_time
				 ,min(created_time) as created_time
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_video_history`
	where id is not null 
	GROUP BY  id
	         ,source
	         ,title
) c
ON cast(b.video_video_id AS string) = cast (c.id AS string)
where a.id is not null 
),
agg_ad_level_video_data as (
--产出了ad id -creative id -video id 的对应关系
--一个ad id 会有多个 video id
--一个video id 严格代表了一个视频
--但是一个video id 会对应多个 creative id
SELECT  ad_id
		,video_id
		 ,max(creative_id) as creative_id
       ,MIN(ad_created_at)    AS ad_created_at
       ,MAX(video_url)        AS video_url
       ,MAX(video_name)       AS video_name
       ,MAX(video_updated_at) AS video_updated_at
       ,MIN(video_created_at) AS video_created_at
FROM ad_level_video_data
WHERE video_id is not null
GROUP BY  1,2
)
, 
ad_level_image_data as (

	
SELECT  a.id             AS ad_id
       ,a.ad_set_id      AS ad_group_id
       ,a.campaign_id    AS campaign_id
       ,a.creative_id    AS creative_id
       ,a.created_time   AS ad_created_time
       ,coalesce(b.image_url,c.image_url) as image_url
       ,c.image_name
       ,c.image_id
      ,c.image_created_at
       ,c.image_updated_at
	   ,c.image_hash
      
FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_history` a
 JOIN
(
	--一个image_id 代表了一个图片
	--反过来 ,一个image id 会对应多个 多个 creative id
	SELECT  id
	       ,image_hash
           ,max(image_url) as image_url
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.creative_history`
	where id is not null 
        and image_hash is not null 
       group by 1,2
) b
ON a.creative_id = b.id
LEFT JOIN
(
	--只要一个图片
	SELECT  image_hash
		,image_name
		,image_id
		,image_url
		,image_updated_at
		,image_created_at
	FROM
	(
		SELECT  `hash`                                                                   AS image_hash
			,name                                                                     AS image_name
			,id                                                                       AS image_id
			,url                                                                      AS image_url
			,updated_time                                                             AS image_updated_at
			,created_time                                                             AS image_created_at
			,ROW_NUMBER() OVER (PARTITION BY `hash` ORDER BY  updated_time DESC ) AS rk
		FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_image_history`
		WHERE `hash` is not null 
	)
	WHERE rk = 1
)c
ON b.image_hash = c.image_hash
WHERE a.id is not null 
),
agg_ad_level_image_data as (
--产出了ad id -creative id -image id 的对应关系
--一个ad id 可能会有多个 image_id,导致ad cost变大,
--同时一个 image id 也会对应 多个ad id 
--image_id 和image hash 是严格一一对应的
SELECT  ad_id
       ,max(creative_id) as creative_id
	--    ,image_hash
	   ,image_id
       ,MAX(ad_created_time) AS ad_created_time
       ,MAX(image_url)        AS image_url
       ,MAX(image_name)       AS image_name
       ,MAX(image_created_at) AS image_created_at
       ,MAX(image_updated_at) AS image_updated_at
FROM ad_level_image_data
GROUP BY  ad_id
	--    ,image_hash
	   ,image_id
)
,

without_use_creative_library_data as (

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
       ,a.channel
       --,coalesce(a.creative_id,cast(d.creative_id as string),cast(f.creative_id as string),cast(c.creative_id as string)) as f_creative_id
	   ,a.creative_id 				      as creative_id
	   ,cast(c.creative_id as string) as external_website_creative_id
	   ,cast(d.creative_id as string) as video_creative_id
	   ,cast(f.creative_id as string) as image_creative_id
       ,a.creative_name
       ,a.creative_type
       ,external_website_creative_url
       ,coalesce(cast(b.video_id as string),cast(d.video_id as string))                 AS video_id
       ,coalesce(b.video_url,d.video_url)               AS video_url
       ,coalesce(b.video_name,d.video_name)             AS video_name
       ,coalesce(b.video_updated_at,d.video_updated_at) AS video_updated_at
       ,coalesce(b.video_created_at,d.video_created_at) AS video_created_at
       ,coalesce(cast(e.image_id as string),cast(f.image_id as string))                 AS image_id
       ,coalesce(e.image_url,f.image_url)               AS image_url
       ,coalesce(e.image_name,f.image_name)             AS image_name
       ,coalesce(e.image_created_at,f.image_created_at) AS image_created_at
       ,coalesce(e.image_updated_at,f.image_updated_at) AS image_updated_at
FROM
(
select source
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
	       
from (
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
	       ,row_number() over (partition by creative_id,ad_id  order by dt desc )  as rk
	FROM `favie_dw.dwd_growth_ad_meta_all_creative_fivetran_inc_1d_view`

)
where rk=1 
) a
LEFT JOIN
( --可以关联 上

	SELECT  video_id
	,video_url
	,video_name
	,video_updated_at
	,video_created_at
		FROM
		(
			SELECT  id                                                               AS video_id
				,source                                                           AS video_url
				,title                                                            AS video_name
				,updated_time                                                     AS video_updated_at
				,created_time                                                     AS video_created_at
				,ROW_NUMBER() OVER (PARTITION BY id ORDER BY  updated_time DESC ) AS rk
			FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_video_history`
			WHERE id is not null 
		)
		WHERE rk = 1
) b
ON cast (a.creative_id AS string ) = cast(b.video_id AS string )
--拿 post 的url , 可能包含 kol 和 非kol
LEFT JOIN
( --一个 ad id 会对应多个instagram_permalink_url , 比如 ad id = 120230662399800629 , 看起来是一个视频, 但是不同帖子ur l

--一个ad id 会对应多个 creative id
--这里只取其中一个,相当于是把这个external_website_creative_url只算到某一个creative id 上面
	SELECT  a.id                           AS ad_id
			,MAX(creative_id) as creative_id
	       ,MAX(b.instagram_permalink_url) AS external_website_creative_url
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_history` a
	LEFT JOIN
	(
		SELECT  id
		       ,MAX(instagram_permalink_url) AS instagram_permalink_url
		FROM `srpproduct-dc37e.fivetran_facebook_ads_full.creative_history`
		GROUP BY  id
	) b
	ON a.creative_id = b.id
	GROUP BY  a.id
)c
ON cast(a.ad_id AS string) = cast(c.ad_id AS string)
--视频
LEFT JOIN agg_ad_level_video_data d
ON cast(a.ad_id AS string) = cast(d.ad_id AS string)
--图片
LEFT JOIN
( --这里关联会产生笛卡尔 积
	SELECT  name     AS image_name
	       ,MAX(url) AS image_url
	       ,MAX(id)  AS image_id
		   ,max(updated_time) as image_updated_at
           ,min(created_time) as image_created_at
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_image_history`
	GROUP BY  1
) e
ON a.creative_name = e.image_name
--这里会产生笛卡尔积, 意味着 ad id 会有多个 
LEFT JOIN agg_ad_level_image_data f
ON cast(a.ad_id AS string) = cast(f.ad_id AS string) 
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
       ,channel
       ,creative_id
	   ,coalesce(if(creative_id='UNKNOWN',null,creative_id),video_id,image_id,post_id) as f_creative_id
	   
       ,external_website_creative_id
       ,video_creative_id
       ,image_creative_id
       ,creative_name
	   ,coalesce(creative_name,video_name,image_name) as f_creative_name
       ,creative_type
	   ,CASE WHEN internal_creative_url is not null AND format IN ('mp4') THEN 'INTENAL_VIDEO_LIBRARY'
             WHEN internal_creative_url is not null AND format IN ('jpeg','jpg','png') THEN 'INTENAL_IMAGE_LIBRARY'
             WHEN internal_creative_url is null AND video_url is not null AND image_url is null THEN 'EXTERNAL_VIDEO'
             WHEN internal_creative_url is null AND video_url is null AND image_url is not null  THEN 'EXTERNAL_IMAGE'
             WHEN internal_creative_url is null AND video_url is not null AND image_url is not null THEN 'EXTERNAL_VIDEO_AND_IMAGE'
             WHEN internal_creative_url is null AND video_url is null AND image_url is null AND external_website_creative_url is not null THEN 'KOL'  
			 when internal_creative_url is null and video_url is null and image_url is null and external_website_creative_url is null then 'UNKNOWN' else 'ERROR' END AS f_creative_type
	   ,coalesce(internal_creative_url,video_url,image_url,external_website_creative_url) AS f_creative_url
       ,external_website_creative_url
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
       ,external_creative_id
       ,internal_creative_id
       ,internal_creative_url
       ,post_id
       ,format
      
       
FROM
(
	SELECT  z1.source
	       ,z1.platform
	       ,z1.app_name
	       ,z1.account_id
	       ,z1.account_name
	       ,z1.campaign_id
	       ,z1.campaign_name
	       ,z1.ad_group_id
	       ,z1.ad_group_name
	       ,z1.ad_id
	       ,z1.ad_name
	       ,z1.country_code
	       ,z1.ad_category
	       ,z1.account_put_type
	       ,z1.account_open_agency
	       ,z1.channel
	       ,z1.creative_id
	       ,z1.external_website_creative_id
	       ,z1.video_creative_id
	       ,z1.image_creative_id
	       ,z1.creative_name
	       ,z1.creative_type
	       ,z1.external_website_creative_url
	       ,z1.video_id
	       ,z1.video_url
	       ,z1.video_name
	       ,z1.video_updated_at
	       ,z1.video_created_at
	       ,z1.image_id
	       ,z1.image_url
	       ,z1.image_name
	       ,z1.image_created_at
	       ,z1.image_updated_at
	       
	       ,REGEXP_EXTRACT(external_website_creative_url,r'/([^/?#]+)/?$') AS post_id
	       ,z2.internal_creative_id
	       ,CASE WHEN format IN ('mp4','jpeg','jpg','png') AND internal_creative_id is not null THEN concat('https://pub-7faa04a50308437f90b3a69eac4ca3da.r2.dev/',internal_creative_id,'.',format)  ELSE null END AS internal_creative_url
	       ,format
	       ,external_creative_id
	FROM without_use_creative_library_data z1
	LEFT JOIN
	(
		SELECT  external_creative_id
		       ,MAX(external_creative_id)
		       ,MAX(internal_creative_id) AS internal_creative_id
		       ,MAX(case WHEN lower(creative_type) = 'video' AND internal_creative_id is not null THEN 'mp4' WHEN lower(creative_type) = 'image' AND internal_creative_id is not null THEN 'jpg' else format end ) AS format
		FROM `favie_dw.dim_ad_all_app_creative_full_1d`
		WHERE dt = (
		SELECT  MAX(dt)
		FROM `favie_dw.dim_ad_all_app_creative_full_1d`)
		GROUP BY  external_creative_id
	) z2
	ON cast(z1.image_id AS string) = z2.external_creative_id or cast(z1.video_id AS string) = z2.external_creative_id
);