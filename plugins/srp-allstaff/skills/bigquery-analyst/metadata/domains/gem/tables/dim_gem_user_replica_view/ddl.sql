CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view`
AS SELECT
        JSON_VALUE(to_json_string(data._id.`$oid`)) AS _id,
        TIMESTAMP_SECONDS(SAFE_CAST(JSON_VALUE(to_json_string(data.created_timestamp)) AS INT64)) AS created_timestamp,
        TIMESTAMP_SECONDS(SAFE_CAST(JSON_VALUE(to_json_string(data.deleted_timestamp)) AS INT64)) AS deleted_timestamp,
        JSON_VALUE(to_json_string(data.model_id)) AS model_id,
        JSON_VALUE(to_json_string(data.model_url.`$binary`)) AS model_url,
        JSON_VALUE(to_json_string(data.user_id)) AS user_id
    FROM
        `srpproduct-dc37e.mongo_production.gem-sensitive_gem_user_replica`;