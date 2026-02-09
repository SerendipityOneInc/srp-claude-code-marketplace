CREATE VIEW `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_tiktok_inc_1d_view`
AS SELECT  'Tiktok'                                                                 AS source
       ,CASE WHEN LOWER(b.name) LIKE 'gensmo%' THEN 'Gensmo'
             WHEN LOWER(b.name) LIKE 'decofy%' THEN 'Decofy'  ELSE 'UNKNOWN' END AS app_name
       ,advertiser_id
       ,b.name                                                                   AS advertiser_name
       ,displayable                                                              AS is_displayable
       ,image_id                                                                 AS creative_id
       ,'image'                                                                  AS creative_type
       ,updated_at
       ,created_at
       ,height
       ,size
       ,width
       ,format
       ,image_url
       ,file_name
       ,signature
       ,material_id
       
       ,dt
FROM
(
	SELECT
        Date(created_at) as dt
        ,image_id
	       ,updated_at
	       ,advertiser_id
	       ,height
	       ,size
	       ,width
	       ,image_url
	       ,file_name
	       ,signature
	       ,displayable
	       ,material_id
	       ,format
	       ,is_carousel_usable
	       ,created_at
	       ,_fivetran_synced
	       ,ROW_NUMBER() OVER (PARTITION BY image_url ORDER BY  created_at asc ) AS rk
         ,max(updated_at) OVER (PARTITION BY image_url )
	FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_history`
	WHERE image_url is not null
	AND image_id is not null
) a
LEFT JOIN `srpproduct-dc37e.fivetran_tiktok_ads.advertiser` b
ON cast(a.advertiser_id as string)= cast (b.id as string )
WHERE rk = 1;