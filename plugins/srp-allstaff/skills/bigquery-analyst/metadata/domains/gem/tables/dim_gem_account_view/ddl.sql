CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_account_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.id)) as id,
        COALESCE(json_value(to_json_string(data.uid.`$numberLong`)), json_value(to_json_string(data.uid))) as uid,
        json_value(to_json_string(data.device_id)) as device_id,
        ARRAY(SELECT json_value(item) FROM UNNEST(json_extract_array(to_json_string(data.device_ids))) as item) as device_ids,
        json_value(to_json_string(data.name.`$binary`)) as name,
        json_value(to_json_string(data.email.`$binary`)) as email,
        json_value(to_json_string(data.phone_number.`$binary`)) as phone_number,
        json_value(to_json_string(data.description)) as description,
        json_value(to_json_string(data.firebase_uid)) as firebase_uid,
        safe_cast(json_value(to_json_string(data.is_active)) as bool) as is_active,
        json_value(to_json_string(data.bio)) as bio,
        json_value(to_json_string(data.avatar.`$binary`)) as avatar,
        json_value(to_json_string(data.is_bot)) as is_bot,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at
    FROM `srpproduct-dc37e.mongo_production.gem-sensitive_gem_account`;