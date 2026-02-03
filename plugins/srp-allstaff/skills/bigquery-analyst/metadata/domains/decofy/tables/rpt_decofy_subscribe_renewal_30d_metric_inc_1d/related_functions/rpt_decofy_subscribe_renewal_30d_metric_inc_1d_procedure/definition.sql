BEGIN
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_rpt.rpt_decofy_subscribe_renewal_30d_metric_inc_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_decofy_subscribe_renewal_30d_metric_inc_1d (
        dt,
        user_group,
        country_name,
        platform,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        first_order_due_30d_cnt,
        first_order_renewal_30d_cnt,

        second_order_due_30d_cnt,
        second_order_renewal_30d_cnt,

        third_more_order_due_30d_cnt,
        third_more_order_renewal_30d_cnt
    )
    SELECT
        dt,
        user_group,
        country_name,
        platform,
        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        product_id,
        simple_product_id,
        product_with_trial,
        order_source,
        first_order_due_30d_cnt,
        first_order_renewal_30d_cnt,

        second_order_due_30d_cnt,
        second_order_renewal_30d_cnt,

        third_more_order_due_30d_cnt,
        third_more_order_renewal_30d_cnt
    FROM favie_rpt.rpt_decofy_subscribe_renewal_30d_metric_inc_1d_function(dt_param);
END