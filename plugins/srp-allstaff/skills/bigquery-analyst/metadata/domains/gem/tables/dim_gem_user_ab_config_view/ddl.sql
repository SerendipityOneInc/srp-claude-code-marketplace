CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_user_ab_config_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.id)) as id,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) as created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) as updated_at,
        json_value(to_json_string(data.description)) as `description`,
        safe_cast(json_value(to_json_string(data.enabled)) as boolean) as `enabled`,
        json_value(to_json_string(data.user_id)) as user_id,
        json_value(to_json_string(data.project)) as project,
        json_value(to_json_string(data.rewrite_uri)) as rewrite_uri,
        json_value(to_json_string(data.route_id)) as route_id,
        json_value(to_json_string(data.router)) as router,
        json_value(to_json_string(data.service)) as `service`,
        json_value(to_json_string(data.start_date)) as `start_date`,
        json_value(to_json_string(data.end_date)) as `end_date`,
        json_value(to_json_string(data.tags)) as tags,
        safe_cast(json_value(to_json_string(data.unique_id)) as int64) as unique_id,
        json_value(to_json_string(data.uri)) as uri,
        safe_cast(json_value(to_json_string(data.weight)) as int64) as weight
    FROM `srpproduct-dc37e.mongo_production.copilot_gem_user_ab_config`;