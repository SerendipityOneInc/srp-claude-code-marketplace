CREATE VIEW `srpproduct-dc37e.favie_dw.dim_decofy_user_vote_metric_view`
AS SELECT
        json_value(to_json_string(data._id.`$oid`)) as _id,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.deleted_at.`$date`)) as int64)) as deleted_at,
        json_value(to_json_string(data.obj_id)) as obj_id,
        json_value(to_json_string(data.obj_type)) as obj_type,
        json_value(to_json_string(data.reason)) as reason,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at,
        json_value(to_json_string(data.user_id)) as user_id,
        json_value(to_json_string(data.user_vote_id)) as user_vote_id,
        safe_cast(json_value(to_json_string(data.vote_value)) as int64) as vote_value
    FROM `srpproduct-dc37e.mongo_production.decofy_user_votes`;