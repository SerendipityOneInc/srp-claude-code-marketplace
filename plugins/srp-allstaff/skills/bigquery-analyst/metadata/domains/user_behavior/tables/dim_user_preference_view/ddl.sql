CREATE VIEW `srpproduct-dc37e.favie_dw.dim_user_preference_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.gender)) as gender,
        timestamp_seconds(safe_cast(json_value(to_json_string(data.last_updated)) as int64)) as last_updated,
        nullif(to_json_string(data.onboard_brands), 'null') as onboard_brands,
        nullif(to_json_string(data.onboard_tags), 'null') as onboard_tags,
        nullif(to_json_string(data.onboard_vibe), 'null') as onboard_vibe,
        nullif(to_json_string(data.preference), 'null') as preference,
        json_value(to_json_string(data.user_id)) as user_id
    FROM `srpproduct-dc37e.mongo_production.copilot_user_preference`;