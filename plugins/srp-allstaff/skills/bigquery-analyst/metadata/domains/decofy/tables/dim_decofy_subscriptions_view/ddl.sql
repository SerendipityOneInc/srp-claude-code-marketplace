CREATE VIEW `srpproduct-dc37e.favie_dw.dim_decofy_subscriptions_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) as _id,
        json_value(to_json_string(data.currency)) as currency,
        json_value(to_json_string(data.original_transaction_id)) as original_transaction_id,
        safe_cast(json_value(to_json_string(data.price)) as int64) as price,
        json_value(to_json_string(data.product_id)) as product_id,
        json_value(to_json_string(data.transaction_id)) as transaction_id,
        json_value(to_json_string(data.user_id)) as user_id,
        datetime(timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64))) as created_at,
        datetime(timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64))) as updated_at,
        datetime(timestamp_millis(safe_cast(json_value(to_json_string(data.deleted_at.`$date`)) as int64))) as deleted_at,
        datetime(timestamp_millis(safe_cast(json_value(to_json_string(data.expires_date)) as int64))) as expires_date
    FROM `srpproduct-dc37e.mongo_production.decofy_subscriptions`;