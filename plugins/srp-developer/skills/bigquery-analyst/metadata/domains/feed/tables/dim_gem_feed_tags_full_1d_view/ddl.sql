CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_feed_tags_full_1d_view`
AS with llm_data as (
      SELECT 
            dt,
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
      window primary_window as (
            partition by dt,moodboard_id order by if(tag_level = "primary",0,1)
      ),
      secondary_window as (
            partition by dt,moodboard_id order by if(tag_level = "secondary",0,1)
      )
  )
  select 
    dt,
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
  where rn = 1;