begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_tryon_model_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_tryon_model_metric_inc_1d (
        dt,

        -- 用户信息

        item_task_model,

        -- 浏览指标
        item_task_list_item_cnt,
        item_task_save_item_cnt,
        item_task_download_item_cnt
    )
    SELECT
        dt,

        -- 用户信息

        item_task_model,

        -- 浏览指标
        item_task_list_item_cnt,
        item_task_save_item_cnt,
        item_task_download_item_cnt
    FROM favie_rpt.rpt_favie_gensmo_tryon_model_metric_inc_1d_function(dt_param);
end