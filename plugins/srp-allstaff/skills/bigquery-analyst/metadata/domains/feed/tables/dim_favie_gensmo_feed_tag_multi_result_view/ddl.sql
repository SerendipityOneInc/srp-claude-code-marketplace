CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_tag_multi_result_view`
AS with moodboard_tags_test_result as (
    select 
      moodboard_id,
      moodboard_image_url,
      moodboard_tag,
      products
    from favie_dw.dim_favie_gensmo_feed_test_multi_result,unnest(moodboard_tags) as moodboard_tag
  ),

  moodboard_tags_test_result_with_rank as (
    select 
      moodboard_id,
      moodboard_image_url,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Style",0,1)) as style_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Occasion",0,1)) as occasion_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Color",0,1)) as color_candidates,

      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Weather",0,1)) as weather_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Temperature",0,1)) as temperature_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Gender",0,1)) as gender_candidates,

      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Age",0,1)) as age_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Body Shape",0,1)) as body_shape_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Body Size",0,1)) as body_size_candidates,
      first_value(moodboard_tag.candidates) over(partition by moodboard_id order by if(moodboard_tag.Category = "Height",0,1)) as height_candidates,

      products,
      
      row_number()over(partition by moodboard_id) as rn
    from moodboard_tags_test_result
  )


  select 
    *
  from moodboard_tags_test_result_with_rank
  where rn = 1;