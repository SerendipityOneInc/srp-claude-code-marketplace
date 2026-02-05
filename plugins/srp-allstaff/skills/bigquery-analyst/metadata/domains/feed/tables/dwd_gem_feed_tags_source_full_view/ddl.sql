CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_source_full_view`
AS with llm_realtime_full_data as (
            select
                  dt,
                  -- hour,
                  process_time,
                  "secondary" as tag_level,
                  moodboard_id,
                  style,
                  occasion,
                  color,
                  weather,
                  temperature,
                  age,
                  gender,
                  body_size,
                  body_shape,
                  height,
                  row_number() over (partition by moodboard_id order by process_time desc) as rn
            from favie_dw.dwd_gensmo_realtime_feed_tag_full_1d_view
      ),
      
      llm_data_all as (
            select 
                  dt,
                  tag_level,
                  moodboard_id,
                  style,
                  occasion,
                  color,
                  weather,
                  temperature,
                  age,
                  gender,
                  body_size,
                  body_shape,
                  height,
                  2 as source
            FROM favie_dw.dwd_gensmo_manual_feed_tag_inc_1d
            where dt is not null
            union all 
            select 
                  dt,
                  "secondary" as tag_level,
                  moodboard_id,
                  style,
                  occasion,
                  color,
                  weather,
                  temperature,
                  age,
                  gender,
                  body_size,
                  body_shape,
                  height,
                  1 as source
            from favie_dw.dwd_gensmo_batch_feed_tag_full_1d
            where dt is not null and dt = (select max(dt) from favie_dw.dwd_gensmo_batch_feed_tag_full_1d where dt is not null)
            union all
            select
                  dt,
                  tag_level,
                  moodboard_id,
                  style,
                  occasion,
                  color,
                  weather,
                  temperature,
                  age,
                  gender,
                  body_size,
                  body_shape,
                  height,
                  0 as source
            from llm_realtime_full_data
            where rn = 1
      ),

      llm_data_first_value AS (
            SELECT 
                  moodboard_id,
                  tag_level,
                  FIRST_VALUE(style) OVER (PARTITION BY moodboard_id ORDER BY IF(style IS NOT NULL, 0, 1), IF(tag_level='secondary', 0, 1) , dt DESC,source desc) AS style,
                  FIRST_VALUE(occasion) OVER (PARTITION BY moodboard_id ORDER BY IF(occasion IS NOT NULL, 0, 1), IF(tag_level='secondary', 0, 1) , dt DESC,source desc) AS occasion,
                  FIRST_VALUE(color) OVER (PARTITION BY moodboard_id ORDER BY IF(color IS NOT NULL, 0, 1), IF(tag_level='primary', 0, 1) , dt DESC,source desc) AS color,
                  FIRST_VALUE(weather) OVER (PARTITION BY moodboard_id ORDER BY IF(weather IS NOT NULL, 0, 1), IF(tag_level='primary', 0, 1) , dt DESC,source desc) AS weather,
                  FIRST_VALUE(temperature) OVER (PARTITION BY moodboard_id ORDER BY IF(temperature IS NOT NULL, 0, 1), IF(tag_level='primary', 0, 1) , dt DESC,source desc) AS temperature,
                  FIRST_VALUE(age) OVER (PARTITION BY moodboard_id ORDER BY IF(age IS NOT NULL, 0, 1), IF(tag_level='primary', 0, 1) , dt DESC,source desc) AS age,
                  FIRST_VALUE(gender) OVER (PARTITION BY moodboard_id ORDER BY IF(gender IS NOT NULL, 0, 1), IF(tag_level='primary', 0, 1) , dt DESC,source desc) AS gender,
                  FIRST_VALUE(body_size) OVER (PARTITION BY moodboard_id ORDER BY IF(body_size IS NOT NULL, 0, 1), IF(tag_level='secondary', 0, 1) , dt DESC,source desc) AS body_size,
                  FIRST_VALUE(body_shape) OVER (PARTITION BY moodboard_id ORDER BY IF(body_shape IS NOT NULL, 0, 1), IF(tag_level='secondary', 0, 1) , dt DESC,source desc) AS body_shape,
                  FIRST_VALUE(height) OVER (PARTITION BY moodboard_id ORDER BY IF(height IS NOT NULL, 0, 1), IF(tag_level='secondary', 0, 1) , dt DESC,source desc) AS height,
                  row_number() OVER (PARTITION BY moodboard_id ORDER BY dt DESC) AS rn
            FROM llm_data_all
      ),

      llm_data_with_image_url as (    
            select 
                  t1.moodboard_id,
                  t1.style,
                  t1.occasion,
                  t1.color,
                  t1.weather,
                  t1.temperature,
                  t1.gender,
                  t1.age,
                  t1.body_size,
                  t1.body_shape,
                  t1.height,
                  t2.moodboard_image_url
            from (select * from llm_data_first_value where rn = 1) t1 
            left outer join favie_dw.dim_favie_gensmo_feed_item_view t2
            on t1.moodboard_id = t2.moodboard_id
      )
      select 
            moodboard_id,
            moodboard_image_url,
            style,
            occasion,
            color,
            weather,
            temperature,
            gender,
            age,
            body_size,
            body_shape,
            height
      from llm_data_with_image_url
      where moodboard_image_url is not null;