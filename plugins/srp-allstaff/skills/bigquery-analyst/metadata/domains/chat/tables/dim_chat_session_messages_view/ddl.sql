CREATE VIEW `srpproduct-dc37e.favie_dw.dim_chat_session_messages_view`
AS SELECT
        json_value(to_json_string(data._id.`$oid`)) as _id,
        timestamp_seconds(safe_cast(safe_cast(json_value(to_json_string(data.created_at)) as float64) as int64)) as created_at,
        parse_timestamp('%Y-%m-%dT%H:%M:%S', json_value(to_json_string(data.created_time))) as created_time,
        timestamp_seconds(safe_cast(safe_cast(json_value(to_json_string(data.last_updated_at)) as float64) as int64)) as last_updated_at,
        json_value(to_json_string(data.message_id)) as message_id,
        timestamp_seconds(safe_cast(safe_cast(json_value(to_json_string(data.message_order)) as float64) as int64)) as message_order,
        json_value(to_json_string(data.role)) as role,
        json_value(to_json_string(data.session_id)) as session_id,
        json_value(to_json_string(data.type)) as type,
        json_value(to_json_string(data.user_uid)) as user_uid,
        nullif(to_json_string(data.value), 'null') as value,
        safe_cast(json_value(to_json_string(data.visible)) as boolean) as visible
    FROM `srpproduct-dc37e.mongo_production.copilot_chat_session_messages`;