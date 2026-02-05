BEGIN 
    -- Remove old data for the given date
    DELETE FROM favie_dw.dws_favie_gem_search_query_metric_inc_1d
    WHERE dt = dt_param;

    -- Insert new data for the given date
    INSERT INTO favie_dw.dws_favie_gem_search_query_metric_inc_1d(
        raw_query,
        qp_query,
        query_modality,
        raw_query_word_amt,
        qp_query_word_amt,
        query_cnt,
        dt
    )
    SELECT 
        raw_query,
        qp_query,
        query_modality,
        raw_query_word_amt,
        qp_query_word_amt,
        query_cnt,
        dt
    FROM favie_dw.dws_favie_gem_search_query_metric_inc_1d_function(dt_param);      
END