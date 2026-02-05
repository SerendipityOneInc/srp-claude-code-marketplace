CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_unregister_account_view_v2`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.id)) as id,
        json_value(to_json_string(data.uid)) as uid,
        json_value(to_json_string(data.firebase_uid)) as firebase_uid,
        json_value(to_json_string(data.device_id)) as device_id,
        safe_cast(json_value(to_json_string(data.is_active)) as bool) as is_active,
        json_value(to_json_string(data.related_user)) as related_user,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at
    FROM `srpproduct-dc37e.mongo_production.copilot_gem_unregister_account`;