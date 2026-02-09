CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_membership_view`
AS SELECT
        JSON_VALUE(to_json_string(data._id.`$oid`)) AS _id,
        SAFE_CAST(JSON_VALUE(to_json_string(data.checkin_days)) AS INT64) AS checkin_days,
        SAFE_CAST(JSON_VALUE(to_json_string(data.last_checkin_time)) AS INT64) AS last_checkin_time,
        SAFE_CAST(JSON_VALUE(to_json_string(data.last_updated)) AS INT64) AS last_updated,
        JSON_VALUE(to_json_string(data.local_country)) AS local_country,
        JSON_VALUE(to_json_string(data.local_ip)) AS local_ip,
        JSON_VALUE(to_json_string(data.local_time_zone)) AS local_time_zone,
        SAFE_CAST(JSON_VALUE(to_json_string(data.membership_expire_time)) AS INT64) AS membership_expire_time,
        SAFE_CAST(JSON_VALUE(to_json_string(data.membership_left_days)) AS INT64) AS membership_left_days,
        JSON_VALUE(to_json_string(data.membership_rule)) AS membership_rule,
        JSON_VALUE(to_json_string(data.membership_type)) AS membership_type,
        JSON_QUERY_ARRAY(data, '$.point_consume_records') AS point_consume_records,
        JSON_QUERY_ARRAY(data, '$.point_earn_records') AS point_earn_records,
        SAFE_CAST(JSON_VALUE(to_json_string(data.points_earned_today)) AS INT64) AS points_earned_today,
        SAFE_CAST(JSON_VALUE(to_json_string(data.points_left_today)) AS INT64) AS points_left_today,
        SAFE_CAST(JSON_VALUE(to_json_string(data.points_permanent)) AS INT64) AS points_permanent,
        SAFE_CAST(JSON_VALUE(to_json_string(data.points_used_today)) AS INT64) AS points_used_today,
        SAFE_CAST(JSON_VALUE(to_json_string(data.subscription_expire_time)) AS INT64) AS subscription_expire_time,
        SAFE_CAST(JSON_VALUE(to_json_string(data.total_points)) AS INT64) AS total_points,
        JSON_QUERY_ARRAY(data, '$.used_redeem_codes') AS used_redeem_codes,
        JSON_VALUE(to_json_string(data.user_id)) AS user_id
    FROM `srpproduct-dc37e.mongo_production.copilot_gem_membership`;