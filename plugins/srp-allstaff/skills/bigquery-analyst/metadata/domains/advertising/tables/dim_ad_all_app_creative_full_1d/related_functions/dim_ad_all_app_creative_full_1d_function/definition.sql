SELECT  dt_param as dt
	   ,a.source
       ,CASE WHEN LOWER(coalesce(b.name,c.name)) LIKE '%gensmo%' THEN 'Gensmo'
             WHEN LOWER(coalesce(b.name,c.name)) LIKE '%decofy%' THEN 'Decofy' 
			 when lower(coalesce(b.name,c.name)) like '%savyo%' then 'Savyo'  ELSE 'UNKNOWN' END AS app_name
       ,account_id
       ,b.name                                                                   AS account_name
       ,external_creative_id
       ,external_creative_name
       ,external_creative_url
       ,external_creative_cover_url
       ,creative_type
	   ,cast(null as string) as creative_status  -- 创意状态, NORMAL,EXPIRED,UNKNOWN
       ,internal_creative_id
       ,format
       ,height
       ,width
       ,size
       ,creative_video_duration
       ,creative_allowed_placements
       ,creative_video_bit_rate
       ,updated_at
       ,created_at
       ,upload_r2_process_at
	   
FROM
(
	SELECT  'Tiktok'              AS source
	       ,MAX(advertiser_id)    AS account_id
	       ,image_id              AS external_creative_id
	       ,MAX(file_name)        AS external_creative_name
	       ,max(image_url)        AS external_creative_url
	       ,cast(null AS string)  AS external_creative_cover_url
	       ,'image'               AS creative_type
	       ,cast (null AS string) AS internal_creative_id
	       ,MAX(format)           AS format
	       ,MAX(height)           AS height
	       ,MAX(width)            AS width
	       ,MAX(size)             AS size
	       ,cast(null AS float64) AS creative_video_duration
	       ,cast(null AS string)  AS creative_allowed_placements
	       ,cast(null AS float64) AS creative_video_bit_rate
	       ,MAX(updated_at)       AS updated_at
	       ,MAX(created_at)       AS created_at
	       ,cast(null AS string)  AS upload_r2_process_at
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_history`
	WHERE image_url is not null
	AND image_id is not null
	GROUP BY  image_id
	
	UNION ALL
	SELECT  'Tiktok'                AS source
	       ,MAX(advertiser_id)      AS account_id
	       ,video_id           		AS external_creative_id
	       ,MAX(file_name)          AS external_creative_name
	       ,MAX(preview_url)        AS external_creative_url
	       ,MAX(video_cover_url)    AS external_creative_cover_url
	       ,'video'                 AS creative_type
	       ,cast (null AS string)   AS internal_creative_id
	       ,MAX(format)             AS format
	       ,MAX(height)             AS height
	       ,MAX(width)              AS width
	       ,MAX(size)               AS size
	       ,MAX(duration)           AS creative_video_duration
	       ,MAX(allowed_placements) AS creative_allowed_placements
	       ,MAX(bit_rate)           AS creative_video_bit_rate
	       ,MAX(updated_at)         AS updated_at
	       ,MAX(TIMESTAMP(create_time))        AS created_at
	       ,cast(null AS string)    AS upload_r2_process_at
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.video_history`
	WHERE video_id is not null
	AND preview_url is not null
	GROUP BY  video_id
    
	UNION ALL
	
	
    -- Meta图片素材
	SELECT  'Meta'                AS source
	       ,CAST(MAX(account_id) AS STRING)    AS account_id
	       ,id                      AS external_creative_id
	       ,MAX(name)               AS external_creative_name
	       ,MAX(url)                AS external_creative_url  -- 可下载的图片URL
	       ,cast(null AS string)    AS external_creative_cover_url
	       ,'image'                 AS creative_type
	       ,cast (null AS string)   AS internal_creative_id
	       ,cast(null AS string)    AS format
	       ,MAX(height)             AS height
	       ,MAX(width)              AS width
	       ,cast(null AS int64)     AS size
	       ,cast(null AS float64)   AS creative_video_duration
	       ,cast(null AS string)    AS creative_allowed_placements
	       ,cast(null AS float64)   AS creative_video_bit_rate
	       ,MAX(updated_time)       AS updated_at
	       ,MAX(created_time)       AS created_at
	       ,cast(null AS string)    AS upload_r2_process_at
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_image_history`
	WHERE url is not null
	AND id is not null
	
	GROUP BY id
	
	UNION ALL
	
    -- Meta视频素材  
	SELECT  'Meta'                  AS source
	       ,CAST(MAX(account_id) AS STRING)      AS account_id
	       ,id           		    AS external_creative_id
	       ,MAX(title)              AS external_creative_name
	       ,MAX(source)             AS external_creative_url  -- 可下载的视频URL!
	       ,MAX(trim(picture,'"'))            AS external_creative_cover_url
	       ,'video'                 AS creative_type
	       ,cast (null AS string)   AS internal_creative_id
	       ,MAX(format)             AS format
	       ,CAST(JSON_EXTRACT_SCALAR(MAX(format), '$[0].height') AS INT64) AS height
	       ,CAST(JSON_EXTRACT_SCALAR(MAX(format), '$[0].width') AS INT64)  AS width
	       ,cast(null AS int64)     AS size
	       ,MAX(length)             AS creative_video_duration
	       ,cast(null AS string)    AS creative_allowed_placements
	       ,cast(null AS float64)   AS creative_video_bit_rate
	       ,MAX(updated_time)       AS updated_at
	       ,MAX(created_time)       AS created_at
	       ,cast(null AS string)    AS upload_r2_process_at
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.ad_video_history`
	WHERE source is not null
	AND id is not null
	
	GROUP BY id

) a 
LEFT JOIN
(
	SELECT  id
	       ,name
		   ,'Tiktok'              AS source
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.advertiser`
	GROUP BY  id
	         ,name
) b
ON a.account_id = cast(b.id as string) and a.source = b.source

LEFT JOIN  (
	SELECT  id
	       ,name
		   ,'Meta'              AS source
	FROM `srpproduct-dc37e.fivetran_facebook_ads_full.account_history`
	GROUP BY  id
	         ,name
) c
ON a.account_id = cast(c.id as string)  and a.source = c.source