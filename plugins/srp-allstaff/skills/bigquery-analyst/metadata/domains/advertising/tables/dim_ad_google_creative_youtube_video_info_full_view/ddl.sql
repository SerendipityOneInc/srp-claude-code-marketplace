CREATE VIEW `srpproduct-dc37e.favie_dw.dim_ad_google_creative_youtube_video_info_full_view`
AS SELECT  video_id
       , video_name 
       ,concat('https://www.youtube.com/watch?v=',video_id) as video_url
       ,cast(null as string) as author_name
       ,cast(null as string) as video_created_at
       ,cast(null as timestamp) as processed_at
FROM `favie_dw.dim_ad_google_creative_multiple_full_1d_view`
WHERE f_creative_type = 'EXTERNAL_VIDEO'
and video_id is not null and video_id not in ('','UNKNOWN')
GROUP BY  video_id
         ,video_name;