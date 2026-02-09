BEGIN
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d (
        dt,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        first_order_due_30d_cnt,
        first_order_renewal_30d_cnt,
        first_order_due_60d_cnt,
        first_order_renewal_60d_cnt,
        default_first_order_renewal_rate,
        second_order_due_30d_cnt,
        second_order_renewal_30d_cnt,
        second_order_due_60d_cnt,
        second_order_renewal_60d_cnt,
        default_second_order_renewal_rate,
        third_more_order_due_30d_cnt,
        third_more_order_renewal_30d_cnt,
        third_more_order_due_60d_cnt,
        third_more_order_renewal_60d_cnt,
        default_third_more_order_renewal_rate
    )
    SELECT
        dt,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        first_order_due_30d_cnt,
        first_order_renewal_30d_cnt,
        first_order_due_60d_cnt,
        first_order_renewal_60d_cnt,
        default_first_order_renewal_rate,
        second_order_due_30d_cnt,
        second_order_renewal_30d_cnt,
        second_order_due_60d_cnt,
        second_order_renewal_60d_cnt,
        default_second_order_renewal_rate,
        third_more_order_due_30d_cnt,
        third_more_order_renewal_30d_cnt,
        third_more_order_due_60d_cnt,
        third_more_order_renewal_60d_cnt,
        default_third_more_order_renewal_rate
    FROM favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d_function(dt_param);
END