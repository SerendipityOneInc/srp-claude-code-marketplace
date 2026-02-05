CREATE VIEW `srpproduct-dc37e.favie_dw.dim_decofy_users_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.uid)) as uid,
        json_extract_array(to_json_string(data.device_ids)) as device_ids,
        json_value(to_json_string(data.email.`$binary`)) as email,
        json_value(to_json_string(data.username.`$binary`)) as username,
        json_value(to_json_string(data.avatar.`$binary`)) as avatar,
        json_value(to_json_string(data.firebase_uid)) as firebase_uid,
        json_value(to_json_string(data.last_login_country)) as last_login_country,
        json_value(to_json_string(data.last_login_ip)) as last_login_ip,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.deleted_at.`$date`)) as int64)) as deleted_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.last_login.`$date`)) as int64)) as last_login
    FROM `srpproduct-dc37e.mongo_production.decofy_users`;