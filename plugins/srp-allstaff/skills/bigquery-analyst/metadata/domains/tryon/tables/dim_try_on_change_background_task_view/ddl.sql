CREATE VIEW `srpproduct-dc37e.favie_dw.dim_try_on_change_background_task_view`
AS SELECT
        JSON_VALUE(to_json_string(data._id.`$oid`)) AS _id,
        JSON_EXTRACT_ARRAY(to_json_string(data.change_background_image_url)) AS change_background_image_url,
        TIMESTAMP_MILLIS(SAFE_CAST(JSON_VALUE(to_json_string(data.created_time.`$date`)) AS INT64)) AS created_time,
        DATE(TIMESTAMP_MILLIS(SAFE_CAST(JSON_VALUE(to_json_string(data.created_time.`$date`)) AS INT64))) AS dt,
        JSON_VALUE(to_json_string(data.generate_uuid)) AS generate_uuid,
        JSON_VALUE(to_json_string(data.input_image_url.`$binary`)) AS input_image_url,
        TIMESTAMP_SECONDS(SAFE_CAST(JSON_VALUE(to_json_string(data.last_updated)) AS INT64)) AS last_updated,
        JSON_VALUE(to_json_string(data.mask_image_url)) AS mask_image_url,
        JSON_VALUE(to_json_string(data.model)) AS model,
        JSON_VALUE(to_json_string(data.negative_prompt)) AS negative_prompt,
        JSON_VALUE(to_json_string(data.prompt)) AS prompt,
        SAFE_CAST(JSON_VALUE(to_json_string(data.stability_submit_latency)) AS FLOAT64) AS stability_submit_latency,
        JSON_VALUE(to_json_string(data.status)) AS status,
        TIMESTAMP_SECONDS(SAFE_CAST(SAFE_CAST(JSON_VALUE(to_json_string(data.task_start_time)) AS FLOAT64) AS INT64)) AS task_start_time,
        JSON_VALUE(to_json_string(data.try_on_task_id)) AS try_on_task_id
    FROM `srpproduct-dc37e.mongo_production.gem-sensitive_try_on_change_background_task`;