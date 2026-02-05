CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gem_feed_tag_check_view`
AS with moodboard_tag_data as (
        select  
            json_extract_scalar(tag_value,"$.moodboard_id") as moodboard_id,
            json_extract_scalar(moodboard_tag,"$.Category") as category,
            json_extract_array(moodboard_tag,'$.Candidates') as candidates
        from favie_dw.dwd_gem_feed_tags_interface_full_view,unnest(json_extract_array(tag_value,'$.moodboard_tags')) as moodboard_tag
    ),

    moodboard_tag_data_explode as (
        select 
            moodboard_id,
            coalesce(trim(category),"") as category,
            coalesce(trim(json_extract_scalar(candidate,"$.Primary")),"") as primary,
            coalesce(trim(json_extract_scalar(candidate,"$.Secondary")),"") as secondary
        from moodboard_tag_data,unnest(candidates) as candidate
    ),

    moodboard_tag_define as (
        select 
            coalesce(trim(string_field_0),"") as category_define,
            coalesce(trim(string_field_1),"") as primary_define,
            coalesce(trim(string_field_2),"") as secondary_define
        from favie_tmp.favie_feed_tag_definition
    )

    select 
        t1.moodboard_id,
        t1.category,
        t1.primary as primary,
        t1.secondary as secondary,
        t2.category_define,
        t2.primary_define,
        t2.secondary_define
    from moodboard_tag_data_explode t1
    left join moodboard_tag_define t2
    on t1.category = t2.category_define
    and t1.primary = t2.primary_define
    and t1.secondary = t2.secondary_define;