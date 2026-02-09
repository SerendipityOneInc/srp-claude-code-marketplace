CREATE VIEW `srpproduct-dc37e.favie_dw.dim_moodboard_feed_tasks_view`
AS SELECT
        json_value(to_json_string(data._id.`$oid`)) as _id,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at,
        safe_cast(json_value(to_json_string(data.cutout)) as boolean) as cutout,
        timestamp_millis(safe_cast(json_value(to_json_string(data.deleted_at.`$date`)) as int64)) as deleted_at,
        json_value(to_json_string(data.gender)) as gender,
        json_value(to_json_string(data.query)) as query,
        json_value(to_json_string(data.route)) as route,
        json_value(to_json_string(data.status)) as status,
        json_value(to_json_string(data.task_id)) as task_id,
        json_value(to_json_string(data.user_id)) as user_id,
        json_value(to_json_string(data.creator)) as creator,
        json_value(to_json_string(data.publisher)) as publisher,
        safe_cast(json_value(to_json_string(data.user_image_height)) as int64) as user_image_height,
        json_value(to_json_string(data.user_image_url.`$binary`)) as user_image_url,
        safe_cast(json_value(to_json_string(data.user_image_width)) as int64) as user_image_width
    FROM `srpproduct-dc37e.mongo_production.copilot_moodboard_feed_tasks`;