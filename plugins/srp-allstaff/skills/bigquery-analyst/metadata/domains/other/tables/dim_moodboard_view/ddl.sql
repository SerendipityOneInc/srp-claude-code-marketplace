CREATE VIEW `srpproduct-dc37e.favie_dw.dim_moodboard_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_time.`$date`)) as int64)) as created_time,
        timestamp_millis(safe_cast(json_value(to_json_string(data.update_time.`$date`)) as int64)) as update_time,
        timestamp_millis(safe_cast(json_value(to_json_string(data.publish_time.`$date`)) as int64)) as publish_time,
        json_value(to_json_string(data.moodboard_id)) as moodboard_id,
        safe_cast(json_value(to_json_string(data.moodboard_index)) as int64) as moodboard_index,
        json_value(to_json_string(data.task_id)) as task_id,
        json_value(to_json_string(data.status)) as `status`,
        json_value(to_json_string(data.description)) as `description`,
        coalesce(safe_cast(json_value(to_json_string(data.is_feed)) as boolean),false) as `is_feed`,
        coalesce(safe_cast(json_value(to_json_string(data.is_try_on)) as boolean),false) as `is_try_on`,
        json_value(to_json_string(data.gender)) as gender,
        json_value(to_json_string(data.hashtags)) as hashtags,
        safe_cast(json_value(to_json_string(data.height)) as int64) as height,
        safe_cast(json_value(to_json_string(data.width)) as int64) as width,

        json_extract_array(to_json_string(data.search_product_list)) as search_product_list,
        json_extract_array(to_json_string(data.moodboards.products)) as moodboard_products,

        json_value(to_json_string(data.image)) as `image`,
        json_value(to_json_string(data.user_image_tag)) as user_image_tag,

        json_value(to_json_string(data.image_url.`$binary`)) as `image_url`,
        json_value(to_json_string(data.image_description)) as `image_description`,
        safe_cast(json_value(to_json_string(data.image_height)) as int64) as image_height,
        safe_cast(json_value(to_json_string(data.image_width)) as int64) as image_width,

        safe_cast(json_value(to_json_string(data.liked_count)) as int64) as liked_count,
        safe_cast(json_value(to_json_string(data.remix)) as int64) as remix,
        safe_cast(json_value(to_json_string(data.saved_count)) as int64) as saved_count,
        safe_cast(json_value(to_json_string(data.shared_count)) as int64) as shared_count,
        json_value(to_json_string(data.score)) as score,
        json_value(to_json_string(data.intention)) as intention,
        to_json_string(data.moodboards) as moodboards,
        json_value(to_json_string(data.query)) as query,
        json_value(to_json_string(data.reasoning)) as reasoning,
        json_value(to_json_string(data.publisher)) as publisher,
        JSON_EXTRACT_ARRAY(to_json_string(data.cover_image_list)) as cover_image_list,
        json_value(to_json_string(data.created_user_id)) as created_user_id,
        safe_cast(json_value(to_json_string(data.is_onboard)) as bool ) as is_onboard,
        json_value(to_json_string(data.moderation_status)) as moderation_status

    FROM `srpproduct-dc37e.mongo_production.copilot_moodboard`;