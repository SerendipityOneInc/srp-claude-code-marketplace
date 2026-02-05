CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_full_view`
AS with llm_data_all as (
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
                  height
            FROM favie_algo.dwd_gem_feed_tags_full_1d
            where dt is not null
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
                  height
            from favie_algo.dwd_gem_feed_tags_inc_1d
            where dt is not null
      ),

      llm_data_first_value AS (
            SELECT 
                  moodboard_id,
                  ARRAY_AGG(style ORDER BY if(style is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS style,
                  ARRAY_AGG(occasion ORDER BY if(occasion is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS occasion,
                  ARRAY_AGG(color ORDER BY if(color is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS color,
                  ARRAY_AGG(weather ORDER BY if(weather is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS weather,
                  ARRAY_AGG(temperature ORDER BY if(temperature is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS temperature,
                  ARRAY_AGG(age ORDER BY if(age is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS age,
                  ARRAY_AGG(gender ORDER BY if(gender is null,0,1) desc,if(gender='primary',0,1) desc, dt DESC)[OFFSET(0)] AS gender,
                  ARRAY_AGG(body_size ORDER BY if(body_size is null,0,1) desc,if(body_size='primary',0,1) desc, dt DESC)[OFFSET(0)] AS body_size,
                  ARRAY_AGG(body_shape ORDER BY if(body_shape is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS body_shape,
                  ARRAY_AGG(height ORDER BY if(height is null,0,1) desc,if(tag_level='primary',0,1) desc, dt DESC)[OFFSET(0)] AS height
            FROM llm_data_all
            GROUP BY moodboard_id
      ),
      llm_data_result as (
            SELECT 
                  moodboard_id,

                  -- 从 style 字段提取 Primary 和 Secondary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(style, '$[0].Candidates')) AS json_candidate
                  ) AS style_1,

                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(style, '$[0].Candidates')) AS json_candidate
                  ) AS style_2,

                  -- 从 occasion 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(occasion, '$[0].Candidates')) AS json_candidate
                  ) AS occasion_1,

                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(occasion, '$[0].Candidates')) AS json_candidate
                  ) AS occasion_2,

                  -- 从 color 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(color, '$[0].Candidates')) AS json_candidate
                  ) AS color,

                  -- 从 weather 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(weather, '$[0].Candidates')) AS json_candidate
                  ) AS weather,

                  -- 从 temperature 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(temperature, '$[0].Candidates')) AS json_candidate
                  ) AS temperature,

                  -- 从 age 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(age, '$[0].Candidates')) AS json_candidate
                  ) AS age,

                  -- 从 gender 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(gender, '$[0].Candidates')) AS json_candidate
                  ) AS gender,

                  -- 从 body_size 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(body_size, '$[0].Candidates')) AS json_candidate
                  ) AS body_size,

                  -- 从 body_shape 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(body_shape, '$[0].Candidates')) AS json_candidate
                  ) AS body_shape,

                  -- 从 height 字段提取 Primary 标签
                  ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(height, '$[0].Candidates')) AS json_candidate
                  ) AS height
            FROM llm_data_first_value
      ),
      llm_data_with_image_url as (    
            select 
                  t1.moodboard_id,
                  t1.style_1,
                  t1.style_2,
                  t1.occasion_1,
                  t1.occasion_2,
                  t1.color,
                  t1.weather,
                  t1.temperature,
                  t1.gender,
                  t1.age,
                  t1.body_size,
                  t1.body_shape,
                  t1.height,
                  t2.moodboard_image_url
            from llm_data_result t1 
            left outer join favie_dw.dim_favie_gensmo_feed_item_view t2
            on t1.moodboard_id = t2.moodboard_id
      )
      select 
            moodboard_id,
            moodboard_image_url,
            style_1,
            style_2,
            occasion_1,
            occasion_2,
            color,
            weather,
            temperature,
            gender,
            age,
            body_size,
            body_shape,
            height
      from llm_data_with_image_url;