CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_comment_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.content)) as content,
        json_value(to_json_string(data.parent_comment_id)) as parent_comment_id,
        json_value(to_json_string(data.user_id)) as user_id,
        json_value(to_json_string(data.post_id)) as post_id,
        safe_cast(json_value(to_json_string(data.is_deleted)) as bool) as is_deleted,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at
    FROM `srpproduct-dc37e.mongo_production.copilot_comments`;