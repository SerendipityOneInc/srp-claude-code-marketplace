begin
    DELETE FROM favie_rpt.rpt_gensmo_analysis_search_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_gensmo_analysis_search_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        query_input_inspo,
        query_input_type,
        search_type,
        user_count,
        load_finish_count,
        agg_load_finish,
        agg_error_block,
        agg_login_block,
        first_collage_gen_position,
        second_collage_gen_position
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,
        query_input_inspo,
        query_input_type,
        search_type,
        user_count,
        load_finish_count,
        agg_load_finish,
        agg_error_block,
        agg_login_block,
        first_collage_gen_position,
        second_collage_gen_position
    FROM favie_rpt.rpt_gensmo_analysis_search_1d_function(
        dt_param
    );
end