CREATE VIEW `srpproduct-dc37e.favie_dw.dim_feed_tag_compare_data_view`
AS with manual_data as (
      select
            moodboard_id,
            split(REGEXP_REPLACE(style_one,r'[，]',','),',') as style_one_tags,
            split(REGEXP_REPLACE(style_two,r'[，]',','),',') as style_two_tags,
            split(REGEXP_REPLACE(occasion_one,r'[，]',','),',') as occasion_one_tags,
            split(REGEXP_REPLACE(occasion_two,r'[，]',','),',') as occasion_two_tags,
            split(REGEXP_REPLACE(color,r'[，]',','),',') as color_tags,
            split(REGEXP_REPLACE(weather,r'[，]',','),',') as weather_tags,
            split(REGEXP_REPLACE(temperature,r'[，]',','),',') as temperature_tags,
            split(REGEXP_REPLACE(age,r'[，]',','),',') as age_tags,
            cast(null as Array<String>) as gender_tags,
            split(REGEXP_REPLACE(body_size,r'[，]',','),',') as body_size_tags,
            split(REGEXP_REPLACE(body_shape,r'[，]',','),',') as body_shape_tags,
            split(REGEXP_REPLACE(height,r'[，]',','),',') as height_tags,
            tagger
      from favie_dw.dim_feed_tag_test_data
      ),

      llm_data as (
            SELECT 
                  moodboard_id,

                  -- 从 style 字段提取 Primary 和 Secondary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(style, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS style_one_tags,

                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(style, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS style_two_tags,

                  -- 从 occasion 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(occasion, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS occasion_one_tags,

                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(occasion, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS occasion_two_tags,

                  -- 从 color 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(color, '$[0].Candidates')) AS json_candidate
                  )) over primary_window AS color_tags,

                  -- 从 weather 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(weather, '$[0].Candidates')) AS json_candidate
                  )) over primary_window AS weather_tags,

                  -- 从 temperature 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(temperature, '$[0].Candidates')) AS json_candidate
                  )) over primary_window AS temperature_tags,

                  -- 从 age 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(age, '$[0].Candidates')) AS json_candidate
                  )) over primary_window AS age_tags,

                  -- 从 gender 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Primary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(gender, '$[0].Candidates')) AS json_candidate
                  )) over primary_window AS gender_tags,

                  -- 从 body_size 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(body_size, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS body_size_tags,

                  -- 从 body_shape 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(body_shape, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS body_shape_tags,

                  -- 从 height 字段提取 Primary 标签
                  first_value(ARRAY(SELECT DISTINCT JSON_VALUE(json_candidate, '$.Secondary')
                        FROM UNNEST(JSON_EXTRACT_ARRAY(height, '$[0].Candidates')) AS json_candidate
                  )) over secondary_window AS height_tags,

                  'llm' as tagger,
                  row_number() over primary_window as rn

            FROM favie_algo.dwd_gem_feed_tags_full_1d
            WHERE dt = '2025-06-05'
            window primary_window as (
                  partition by (moodboard_id) order by if(tag_level = "primary",0,1)
            ),
            secondary_window as (
                  partition by (moodboard_id) order by if(tag_level = "secondary",0,1)
            )
      ),

      all_data as (
            select 
                  moodboard_id,
                  style_one_tags,
                  style_two_tags,
                  occasion_one_tags,
                  occasion_two_tags,
                  color_tags,
                  weather_tags,
                  temperature_tags,
                  gender_tags,
                  age_tags,
                  body_size_tags,
                  body_shape_tags,
                  height_tags,
                  tagger
            from manual_data
            union all
            select 
                  moodboard_id,
                  style_one_tags,
                  style_two_tags,
                  occasion_one_tags,
                  occasion_two_tags,
                  color_tags,
                  weather_tags,
                  temperature_tags,
                  gender_tags,
                  age_tags,
                  body_size_tags,
                  body_shape_tags,
                  height_tags,
                  tagger
            from llm_data 
            where rn = 1
      ),

      all_data_with_image_url as (
            select
                  t1.moodboard_id,
                  t1.style_one_tags,
                  t1.style_two_tags,
                  t1.occasion_one_tags,
                  t1.occasion_two_tags,
                  t1.color_tags,
                  t1.weather_tags,
                  t1.temperature_tags,
                  t1.gender_tags,
                  t1.age_tags,
                  t1.body_size_tags,
                  t1.body_shape_tags,
                  t1.height_tags,
                  t1.tagger,
                  t2.moodboard_image_url            
            from all_data t1 
            left outer join favie_dw.dim_favie_gensmo_feed_item_view t2
            on t1.moodboard_id = t2.moodboard_id
      )

      select 
            moodboard_id,
            style_one_tags,
            style_two_tags,
            occasion_one_tags,
            occasion_two_tags,
            color_tags,
            weather_tags,
            temperature_tags,
            gender_tags,
            age_tags,
            body_size_tags,
            body_shape_tags,
            height_tags,
            tagger,
            moodboard_image_url
      from all_data_with_image_url;