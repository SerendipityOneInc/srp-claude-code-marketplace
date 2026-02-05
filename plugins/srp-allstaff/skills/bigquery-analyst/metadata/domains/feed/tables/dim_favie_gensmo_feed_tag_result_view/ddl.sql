CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_tag_result_view`
AS with moodboard_tag_test_result as (
    select 
      moodboard_id,
      moodboard_image_url,
      moodboard_tag,
      products
    from favie_dw.dim_favie_gensmo_feed_test_result,unnest(moodboard_tags) as moodboard_tag
  ),

  moodboard_tag_test_result_with_rank as (
    select 
      moodboard_id,
      moodboard_image_url,
      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Style",0,1)) as Style_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Style",0,1)) as Style_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Occasion",0,1)) as Occasion_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Occasion",0,1)) as Occasion_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Weather",0,1)) as Weather_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Weather",0,1)) as Weather_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Temperature",0,1)) as Temperature_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Temperature",0,1)) as Temperature_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Color",0,1)) as Color_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Color",0,1)) as Color_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Gender",0,1)) as Gender_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Gender",0,1)) as Gender_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Age",0,1)) as Age_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Age",0,1)) as Age_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Body Shape",0,1)) as Body_Shape_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Body Shape",0,1)) as Body_Shape_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Body Size",0,1)) as Body_Size_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Body Size",0,1)) as Body_Size_secondary,

      first_value(moodboard_tag.Primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Height",0,1)) as Height_primary,
      first_value(moodboard_tag.Secondary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Height",0,1)) as Height_secondary,

      products,
      
      row_number()over(partition by moodboard_id) as rn
    from moodboard_tag_test_result
  )

  select 
    *
  from moodboard_tag_test_result_with_rank
  where rn = 1;