CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_dupe_account_view`
AS SELECT
        JSON_VALUE(to_json_string(data._id.`$oid`)) AS _id,
        JSON_VALUE(to_json_string(data.avatar.`$binary`)) AS avatar,
        JSON_VALUE(to_json_string(data.bio)) AS bio,
        TIMESTAMP_MILLIS(SAFE_CAST(JSON_VALUE(to_json_string(data.created_at.`$date`)) AS INT64)) AS created_at,
        TIMESTAMP_MILLIS(SAFE_CAST(JSON_VALUE(to_json_string(data.updated_at.`$date`)) AS INT64)) AS updated_at,
        JSON_VALUE(to_json_string(data.description)) AS description,
        JSON_VALUE(to_json_string(data.device_id)) AS device_id,
        JSON_VALUE(to_json_string(data.device_ids)) AS device_ids,
        JSON_VALUE(to_json_string(data.email.`$binary`)) AS email,
        JSON_VALUE(to_json_string(data.firebase_uid)) AS firebase_uid,
        JSON_VALUE(to_json_string(data.id)) AS id,
        JSON_VALUE(to_json_string(data.is_active)) AS is_active,
        JSON_VALUE(to_json_string(data.name.`$binary`)) AS name,
        JSON_VALUE(to_json_string(data.phone_number.`$binary`)) AS phone_number,
        COALESCE(JSON_VALUE(to_json_string(data.uid.`$numberLong`)), JSON_VALUE(to_json_string(data.uid))) AS uid

    FROM `srpproduct-dc37e.mongo_production.gem-sensitive_dupe_account`;