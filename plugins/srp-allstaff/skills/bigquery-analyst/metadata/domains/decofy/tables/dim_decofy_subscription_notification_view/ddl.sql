CREATE VIEW `srpproduct-dc37e.favie_dw.dim_decofy_subscription_notification_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.consumption_request_reason)) as consumption_request_reason,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.deleted_at.`$date`)) as int64)) as deleted_at,
        json_value(to_json_string(data.notification_type)) as notification_type,
        json_value(to_json_string(data.notification_uuid)) as notification_uuid,
        json_value(to_json_string(data.renewal_info)) as renewal_info,
        safe_cast(json_value(to_json_string(data.signed_date)) as int64) as signed_date,
        safe_cast(json_value(to_json_string(data.subscription_status)) as int64) as subscription_status,
        json_value(to_json_string(data.subtype)) as subtype,
        json_value(to_json_string(data.transaction_info)) as transaction_info,
        json_value(to_json_string(data.version)) as version
    FROM `srpproduct-dc37e.mongo_production.decofy_app_store_server_notifications`;