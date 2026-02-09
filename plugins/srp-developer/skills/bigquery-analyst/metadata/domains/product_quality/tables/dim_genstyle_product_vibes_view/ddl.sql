CREATE VIEW `srpproduct-dc37e.favie_dw.dim_genstyle_product_vibes_view`
AS SELECT  
        json_value(to_json_string(data._id.`$oid`)) AS _id,
        json_value(to_json_string(data.business)) AS business,
        json_value(to_json_string(data.business_product_id)) AS business_product_id,
        timestamp_millis(safe_cast(json_value(to_json_string(data.created_at.`$date`)) as int64)) AS created_at,
        timestamp_millis(safe_cast(json_value(to_json_string(data.deleted_at.`$date`)) as int64)) AS deleted_at,
        json_value(to_json_string(data.offline_task_id)) AS offline_task_id,
        json_value(to_json_string(data.product_vibe_id)) AS product_vibe_id,
        data.products AS products,
        json_value(to_json_string(data.rejection_reason)) AS rejection_reason,
        json_value(to_json_string(data.review_note)) AS review_note,
        json_value(to_json_string(data.status)) AS status,
        json_value(to_json_string(data.try_on_image_url)) AS try_on_image_url,
        timestamp_millis(safe_cast(json_value(to_json_string(data.updated_at.`$date`)) as int64)) AS updated_at,
        json_value(to_json_string(data.vibe_image_url)) AS vibe_image_url
    FROM `mongo_production.genstyle_product_vibes`;