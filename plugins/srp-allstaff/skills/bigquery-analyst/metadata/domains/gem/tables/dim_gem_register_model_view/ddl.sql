CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_register_model_view`
AS SELECT
        JSON_VALUE(to_json_string(data._id.`$oid`)) AS _id,
        TIMESTAMP_MILLIS(SAFE_CAST(JSON_VALUE(to_json_string(data.created_time.`$date`)) AS INT64)) AS created_time,
        JSON_VALUE(to_json_string(data.created_timestamp)) AS created_timestamp,
        JSON_VALUE(to_json_string(data.model_id)) AS model_id,
        JSON_VALUE(to_json_string(data.model_url.`$binary`)) AS model_url,
        JSON_VALUE(to_json_string(data.caption_prompt.`$binary`)) AS caption_prompt,
        JSON_VALUE(to_json_string(data.original_model_id)) AS original_model_id,
        JSON_VALUE(to_json_string(data.original_model_url)) AS original_model_url,
        JSON_VALUE(to_json_string(data.preference.age_group)) AS age_group,
        JSON_VALUE(to_json_string(data.preference.gender)) AS gender,
        JSON_VALUE(to_json_string(data.preference.glasses)) AS glasses,
        JSON_VALUE(to_json_string(data.preference.race)) AS race,
        JSON_VALUE(to_json_string(data.user_id)) AS user_id,
        JSON_VALUE(to_json_string(data.user_image_url.`$binary`)) AS user_image_url,
        JSON_VALUE(to_json_string(data.underwear_avatar_url.`$binary`)) AS underwear_avatar_url
    FROM `srpproduct-dc37e.mongo_production.gem-sensitive_gem_register_model`;