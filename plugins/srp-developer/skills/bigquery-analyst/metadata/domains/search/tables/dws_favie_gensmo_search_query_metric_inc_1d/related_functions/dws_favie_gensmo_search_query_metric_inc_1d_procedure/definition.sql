BEGIN 

    DECLARE current_dt DATE;
    SET current_dt = dt_param;

    while n_day>=1 do
    -- Remove old data for the given date
        DELETE FROM favie_dw.dws_favie_gensmo_search_query_metric_inc_1d
        WHERE dt IS NOT NULL AND dt = current_dt;

        -- Insert new data for the given date
        INSERT INTO favie_dw.dws_favie_gensmo_search_query_metric_inc_1d(
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
        FROM favie_dw.dws_favie_gensmo_search_query_metric_inc_1d_function(current_dt);    
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;  
END