CREATE VIEW `srpproduct-dc37e.favie_dw.dim_chat_sessions_view`
AS SELECT
        json_value(to_json_string(data._id.`$oid`)) as _id,
        timestamp_seconds(safe_cast(safe_cast(json_value(to_json_string(data.created_at)) as float64) as int64)) as created_at,
        parse_timestamp('%Y-%m-%dT%H:%M:%S', json_value(to_json_string(data.created_time))) as created_time,
        nullif(to_json_string(data.headers), 'null') as headers,
        safe_cast(json_value(to_json_string(data.last_updated)) as int64) as last_updated,
        parse_timestamp('%Y-%m-%dT%H:%M:%S', json_value(to_json_string(data.last_updated_time))) as last_updated_time,
        nullif(to_json_string(data.message_list), 'null') as message_list,
        nullif(to_json_string(data.passthrough), 'null') as passthrough,
        json_value(to_json_string(data.session_id)) as session_id,
        json_value(to_json_string(data.session_title)) as session_title,
        json_value(to_json_string(data.user_uid)) as user_uid
    FROM `srpproduct-dc37e.mongo_production.copilot_chat_sessions`;