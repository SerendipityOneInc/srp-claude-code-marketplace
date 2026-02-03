CREATE VIEW `srpproduct-dc37e.favie_dw.dwd_gensmo_user_try_on_urls_and_vibe_detail_view`
AS SELECT
        JSON_EXTRACT_SCALAR(t1.data, '$.created_time') AS created_time,

        JSON_EXTRACT_SCALAR(t1.data, '$.created_user_id') AS user_id,
        JSON_EXTRACT_SCALAR(t1.data, '$.try_on_task_id') AS try_on_task_id,


        JSON_EXTRACT_SCALAR(t1.data, '$.model_id') AS model_id,
        JSON_EXTRACT_SCALAR(t1.data, '$.model_type') AS model_type,
        JSON_EXTRACT_SCALAR(t1.data, '$.user_image_url') AS user_image_url,
        JSON_EXTRACT_SCALAR(t1.data, '$.try_on_preview_url') AS try_on_preview_url,
        JSON_EXTRACT_SCALAR(t1.data, '$.try_on_url') AS try_on_url,
        JSON_EXTRACT_SCALAR(t1.data, '$.outfit_comment.scenario_guru.background_prompt') AS background_prompt_offered,
        JSON_EXTRACT_SCALAR(t1.data, '$.outfit_comment.outfit_enthusiast[0].text') AS outfit_enthusiast_text,

        JSON_EXTRACT_SCALAR(t1.data, '$.prompt') AS change_background_prompt,
        JSON_EXTRACT_SCALAR(t2.data, '$.input_image_url') AS change_background_input_image_url,
        JSON_EXTRACT_SCALAR(t2.data, '$.change_background_image_url') AS change_background_image_url,
        JSON_EXTRACT_SCALAR(t2.data, '$.status') AS change_background_status

    FROM
        `srpproduct-dc37e.favie_mongodb_integration_airbyte.try_on_task` t1
    LEFT JOIN
        `srpproduct-dc37e.favie_mongodb_integration_airbyte.try_on_change_background_task` t2
    ON
        JSON_EXTRACT_SCALAR(t1.data, '$.try_on_task_id') = JSON_EXTRACT_SCALAR(t2.data, '$.try_on_task_id');