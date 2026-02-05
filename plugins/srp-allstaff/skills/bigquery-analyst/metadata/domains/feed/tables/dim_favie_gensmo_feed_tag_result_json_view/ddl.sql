CREATE VIEW `srpproduct-dc37e.favie_dw.dim_favie_gensmo_feed_tag_result_json_view`
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
      first_value(concat(moodboard_tag.primary,' -> ',moodboard_tag.secondary)) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Style",0,1)) as Style,

      first_value(concat(moodboard_tag.primary,' -> ',moodboard_tag.secondary)) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Occasion",0,1)) as Occasion,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Weather",0,1)) as Weather,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Temperature",0,1)) as Temperature,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Color",0,1)) as Color,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Gender",0,1)) as Gender,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Age",0,1)) as Age,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Body Shape",0,1)) as Body_Shape,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Body Size",0,1)) as Body_Size,

      first_value(moodboard_tag.primary) over(partition by moodboard_id,moodboard_image_url order by if(moodboard_tag.Category = "Height",0,1)) as Height,

      products,
      
      row_number()over(partition by moodboard_id) as rn
    from moodboard_tag_test_result
  )

  select 
    moodboard_id,
    moodboard_image_url,
    concat(
      "Style : ",Style,"\n",
      "Occasion : ",Occasion,"\n",
      "Weather : ",Weather,"\n",
      "Temperature : ",Temperature,"\n",
      "Color : ",Color,"\n",
      "Gender : ",Gender,"\n",
      "Age : ",Age,"\n",
      "Body_Shape : ",Body_Shape,"\n",
      "Body_Size : ",Body_Size,"\n",
      "Height : ",Height,"\n"
    ) as moodboard_tags
  from moodboard_tag_test_result_with_rank
  where rn = 1;