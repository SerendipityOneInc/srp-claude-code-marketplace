CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_report_full_view`
AS with llm_data_result as (
            SELECT 
                  moodboard_id,

                  moodboard_image_url,

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
            FROM favie_dw.dwd_gem_feed_tags_source_full_view 
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
      from llm_data_result;