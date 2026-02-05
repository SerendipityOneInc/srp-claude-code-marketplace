BEGIN
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d
    WHERE dt = dt_param and n_day = n_day_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d (
        dt,
        user_id,
        appsflyer_id,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        n_day,
        first_order_due_cnt,
        first_order_renewal_cnt,
        second_order_due_cnt,
        second_order_renewal_cnt,
        third_more_order_due_cnt,
        third_more_order_renewal_cnt
    )
    SELECT
        dt,
        user_id,
        appsflyer_id,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        n_day,
        first_order_due_cnt,
        first_order_renewal_cnt,
        second_order_due_cnt,
        second_order_renewal_cnt,
        third_more_order_due_cnt,
        third_more_order_renewal_cnt
    FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d_function(dt_param,n_day_param);
END