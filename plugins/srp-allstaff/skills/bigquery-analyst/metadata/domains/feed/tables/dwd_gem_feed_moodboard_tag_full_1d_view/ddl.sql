CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_feed_moodboard_tag_full_1d_view`
AS with moodboard_tag_source_data as (
    select 
      dt,
      message_time as process_time,
      moodboard_id,
      moodboard_image_url,
      product_ids_json as product_ids,
      products_json as products,
      json_extract_array(moodboard_tags_json) as moodboard_tags
    from favie_dw.dwd_gensmo_feed_tag_full_1d
    where dt is not null and dt = (select max(dt) from favie_dw.dwd_gensmo_feed_tag_full_1d where dt is not null)
  ),
  moodboard_tag_data_expload_tags as (
    select 
      dt,
      process_time,
      moodboard_id,
      moodboard_image_url,
      product_ids,
      products,
      moodboard_tag
    from moodboard_tag_source_data,unnest(moodboard_tags) as moodboard_tag
  ),
  moodboard_tag_data as (
    select 
      dt,
      process_time,
      moodboard_id,
      moodboard_image_url,
      product_ids,
      products,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Style',moodboard_tag,null)) as style,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Occasion',moodboard_tag,null)) as occasion,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Color',moodboard_tag,null)) as color,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Weather',moodboard_tag,null)) as weather,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Temperature',moodboard_tag,null)) as temperature,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Age',moodboard_tag,null)) as age,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Gender',moodboard_tag,null)) as gender,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Body Size',moodboard_tag,null)) as body_size,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Body Shape',moodboard_tag,null)) as body_shape,
      max(if(json_extract_scalar(moodboard_tag,'$.Category')='Height',moodboard_tag,null)) as height
    from moodboard_tag_data_expload_tags
    group by dt,process_time,moodboard_id,moodboard_image_url,product_ids,products
  )

  select 
    dt,
    process_time,
    moodboard_id,
    moodboard_image_url,
    product_ids,
    products,
    concat('[',style,']') as style,
    concat('[',occasion,']') as occasion,
    concat('[',color,']') as color,
    concat('[',weather,']') as weather,
    concat('[',temperature,']') as temperature,
    concat('[',age,']') as age,
    concat('[',gender,']') as gender,
    concat('[',body_size,']') as body_size,
    concat('[',body_shape,']') as body_shape,
    concat('[',height,']') as height
  from moodboard_tag_data;