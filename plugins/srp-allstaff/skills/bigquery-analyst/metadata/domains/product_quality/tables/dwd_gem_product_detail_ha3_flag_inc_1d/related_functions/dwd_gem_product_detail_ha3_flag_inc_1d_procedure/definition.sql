BEGIN
    MERGE favie_dw.dwd_gem_product_ha3_index_flag_inc_1d AS target
    USING (
        select 
            dt,
            biz_param as biz,
            merge_mode,
            model_config,
            CURRENT_TIMESTAMP() as processed_at
        from favie_dw.dwd_gem_product_ha3_index_config_function(dt_param, product_index_config_json)
    ) AS source
    ON target.dt = dt_param and target.dt = source.dt AND target.biz = source.biz
    WHEN MATCHED THEN
        UPDATE SET
            merge_mode = source.merge_mode,
            model_config = source.model_config,
            updated_at = source.processed_at
    WHEN NOT MATCHED THEN
        INSERT (dt, biz, merge_mode, model_config, created_at, updated_at)
        VALUES (source.dt, source.biz, source.merge_mode, source.model_config, source.processed_at, source.processed_at);

    -- 调用另一个存储过程来注册分区，这很可能是为了元数据管理或依赖跟踪。
    CALL favie_dw.record_partition('favie_dw.dwd_gem_product_ha3_index_flag_inc_1d', dt_param, "");
END