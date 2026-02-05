CREATE VIEW `srpproduct-dc37e.favie_dw.dim_feed_tag_test_data_view`
AS select 
    string_field_0 as moodboard_id,
    -- string_field_1 as moodboard_image_url,
    -- string_field_2 as moodboard_type,
    -- string_field_3 as quality,
    string_field_3 as style_one,
    string_field_4 as style_two,
    string_field_5 as occasion_one,
    string_field_6 as occasion_two,
    string_field_7 as color,
    string_field_8 as weather,
    string_field_9 as temperature,
    -- string_field_10 as gender,
    string_field_10 as age,
    string_field_11 as body_shape,
    string_field_12 as body_size,
    string_field_13 as height,
    string_field_14 as tagger
  from favie_dw.dim_feed_tag_test_data_google_sheet;