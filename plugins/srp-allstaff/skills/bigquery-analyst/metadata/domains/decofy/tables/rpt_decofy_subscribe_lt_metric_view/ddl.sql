CREATE VIEW `srpproduct-dc37e.favie_rpt.rpt_decofy_subscribe_lt_metric_view`
AS with renewal_rate as (
        select
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
            case 
                when first_order_due_30d_cnt >= 20 then first_order_renewal_30d_cnt / first_order_due_30d_cnt
                when first_order_due_60d_cnt >= 20 then first_order_renewal_60d_cnt / first_order_due_60d_cnt
                else default_first_order_renewal_rate
            end as first_order_renewal_rate,

            second_order_due_30d_cnt,
            second_order_renewal_30d_cnt,
            second_order_due_60d_cnt,
            second_order_renewal_60d_cnt,
            default_second_order_renewal_rate,
            case 
                when second_order_due_30d_cnt >= 20 then second_order_renewal_30d_cnt / second_order_due_30d_cnt
                when second_order_due_60d_cnt >= 20 then second_order_renewal_60d_cnt / second_order_due_60d_cnt
                else default_second_order_renewal_rate
            end as second_order_renewal_rate,

            third_more_order_due_30d_cnt,
            third_more_order_renewal_30d_cnt,
            third_more_order_due_60d_cnt,
            third_more_order_renewal_60d_cnt,
            default_third_more_order_renewal_rate,
            case 
                when third_more_order_due_30d_cnt >= 20 then third_more_order_renewal_30d_cnt / third_more_order_due_30d_cnt
                when third_more_order_due_60d_cnt >= 20 then third_more_order_renewal_60d_cnt / third_more_order_due_60d_cnt
                else default_third_more_order_renewal_rate
            end as third_more_order_renewal_rate
        from favie_rpt.rpt_decofy_subscribe_renewal_ltv_metric_inc_1d
        where dt is not null
    ),
    renewal_rate_fix as(
        select 
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
        first_order_renewal_rate,

        second_order_due_30d_cnt,
        second_order_renewal_30d_cnt,
        second_order_due_60d_cnt,
        second_order_renewal_60d_cnt,
        default_second_order_renewal_rate,
        second_order_renewal_rate,

        third_more_order_due_30d_cnt,
        third_more_order_renewal_30d_cnt,
        third_more_order_due_60d_cnt,
        third_more_order_renewal_60d_cnt,
        default_third_more_order_renewal_rate,
        third_more_order_renewal_rate,
        if(third_more_order_renewal_rate=1,0.9,third_more_order_renewal_rate) as third_more_order_renewal_rate_fix
        from renewal_rate
    )

    select
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
        first_order_renewal_rate,

        second_order_due_30d_cnt,
        second_order_renewal_30d_cnt,
        second_order_due_60d_cnt,
        second_order_renewal_60d_cnt,
        default_second_order_renewal_rate,
        second_order_renewal_rate,

        third_more_order_due_30d_cnt,
        third_more_order_renewal_30d_cnt,
        third_more_order_due_60d_cnt,
        third_more_order_renewal_60d_cnt,
        default_third_more_order_renewal_rate,
        third_more_order_renewal_rate,
        third_more_order_renewal_rate_fix,
        1 + first_order_renewal_rate + first_order_renewal_rate * second_order_renewal_rate / (1 - third_more_order_renewal_rate_fix) as subscription_LT,
        if(product_with_trial=1,0,1) + first_order_renewal_rate + first_order_renewal_rate * second_order_renewal_rate / (1 - third_more_order_renewal_rate_fix) as subscription_paid_LT,
        case when product_with_trial = 1 then first_order_renewal_rate else 1 end as free_trial_paid_rate,
        (if(product_with_trial=1,0,1) + first_order_renewal_rate + first_order_renewal_rate * second_order_renewal_rate / (1 - third_more_order_renewal_rate_fix)) / (case when product_with_trial = 1 then first_order_renewal_rate else 1 end) as paid_LT
    from renewal_rate_fix;