CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gem_feed_tags_full_1d_view`
AS select 
            dt,
            moodboard_id,
            moodboard_image_url,  
            ARRAY_TO_STRING(style_one_tags,"\n") as style_1,
            ARRAY_TO_STRING(style_two_tags,"\n") as style_2,
            ARRAY_TO_STRING(occasion_one_tags,"\n") as occasion_1,
            ARRAY_TO_STRING(occasion_two_tags,"\n") as occasion_2,
            ARRAY_TO_STRING(color_tags,"\n") as color,
            ARRAY_TO_STRING(weather_tags,"\n") as weather,
            ARRAY_TO_STRING(temperature_tags,"\n") as temperature,
            ARRAY_TO_STRING(gender_tags,"\n") as gender,
            ARRAY_TO_STRING(age_tags,"\n") as age,
            ARRAY_TO_STRING(body_size_tags,"\n") as body_size,
            ARRAY_TO_STRING(body_shape_tags,"\n") as body_shape,
            ARRAY_TO_STRING(height_tags,"\n") as height,
            tagger
      from favie_dw.dwd_gem_feed_tags_full_1d_view;