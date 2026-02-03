SELECT  dt
         ,'Tiktok'                                                                 AS source
         ,CASE WHEN LOWER(b.name) LIKE 'gensmo%' THEN 'Gensmo'
               WHEN LOWER(b.name) LIKE 'decofy%' THEN 'Decofy'  ELSE 'UNKNOWN' END AS app_name
         ,advertiser_id                                                            AS account_id
         ,b.name                                                                   AS account_name
         ,image_id                                                                 AS external_creative_id
         ,file_name                                                                AS external_creative_name
         ,image_url                                                                AS external_creative_url
         ,'image'                                                                  AS creative_type
         ,CAST(NULL AS STRING)                                                     AS internal_creative_id
         ,format
         ,height
         ,width
         ,size
         ,updated_at
         ,created_at
         ,CAST(NULL AS STRING)                                                     AS upload_r2_process_at
  FROM
  (
    SELECT  Date(created_at)                                             AS dt
           ,image_id
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
           ,ROW_NUMBER() OVER (PARTITION BY image_id ORDER BY created_at ASC ) AS rk
           ,MAX(updated_at) OVER (PARTITION BY image_id )                AS updated_at
    FROM `srpproduct-dc37e.fivetran_tiktok_ads.image_history`
    WHERE image_url IS NOT NULL
    AND image_id IS NOT NULL 
  ) a
  LEFT JOIN `srpproduct-dc37e.fivetran_tiktok_ads.advertiser` b
  ON CAST(a.advertiser_id AS STRING) = CAST(b.id AS STRING)
  WHERE rk = 1 
  AND dt = dt_param