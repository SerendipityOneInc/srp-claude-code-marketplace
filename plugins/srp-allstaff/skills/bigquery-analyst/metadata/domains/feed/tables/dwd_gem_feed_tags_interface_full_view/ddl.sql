CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_feed_tags_interface_full_view`
AS with  llm_data_parsed_array AS ( 
            select 
                  moodboard_id,
                  moodboard_image_url,
                  favie_dw.parse_feed_tag(style,'Style') as style,
                  favie_dw.parse_feed_tag(occasion,'Occasion') as occasion,
                  favie_dw.parse_feed_tag(color,'Color') as color,
                  favie_dw.parse_feed_tag(weather,'Weather') as weather,
                  favie_dw.parse_feed_tag(temperature,'Temperature') as temperature,
                  favie_dw.parse_feed_tag(gender,'Gender') as gender,
                  favie_dw.parse_feed_tag(age,'Age') as age,
                  favie_dw.parse_feed_tag(body_size,'Body Size') as body_size,
                  favie_dw.parse_feed_tag(body_shape,'Body Shape') as body_shape,
                  favie_dw.parse_feed_tag(height,'Height') as height
            from favie_dw.dwd_gem_feed_tags_source_full_view 
      )

      select
            moodboard_id,
            to_json_string(
                  struct(
                        moodboard_id,
                        moodboard_image_url,
                        array_concat(
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
                        ) as moodboard_tags
                  )
            ) as tag_value 
      from llm_data_parsed_array;