CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_try_on_urls_and_vibe_detail_view`
AS SELECT
        t1.created_time,
        t1.created_user_id AS user_id,
        t1.try_on_task_id,
        t1.is_vibe,
        t1.source,
        t1.model_id,
        t1.model_type,
        t1.user_image_url,
        t1.try_on_preview_url,
        t1.try_on_url,
        json_value(t1.outfit_comment,"$.scenario_guru.background_prompt") as background_prompt_offered,
        json_extract_array(t1.outfit_comment,"$.outfit_enthusiast")[safe_offset(0)] as outfit_enthusiast_text,

        t2.prompt as change_background_prompt,
        t2.input_image_url aschange_background_input_image_url,
        t2.change_background_image_url,
        t2.status AS change_background_status

    FROM
        `srpproduct-dc37e.favie_dw.dim_try_on_task_view` t1
    LEFT JOIN
        `srpproduct-dc37e.favie_dw.dim_try_on_change_background_task_view` t2
    ON
        t1.try_on_task_id = t2.try_on_task_id;