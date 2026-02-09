BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;
    WHILE n_day >= 1 DO
        DELETE FROM `favie_rpt.rpt_decofy_subscription_order_metrics_inc_1d`
        WHERE dt = current_dt;
        INSERT INTO `favie_rpt.rpt_decofy_subscription_order_metrics_inc_1d`
        (
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            order_source,
            product_id,
            simple_product_id,
            subscription_type,
            order_category,
            order_type,
            created_order_cnt,
            created_order_amount,
            due_order_cnt,
            due_order_amount,
            renewed_order_cnt,
            renewed_order_amount
        )
        SELECT
            dt,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            order_source,
            product_id,
            simple_product_id,
            subscription_type,
            order_category,
            order_type,
            created_order_cnt,
            created_order_amount,
            due_order_cnt,
            due_order_amount,
            renewed_order_cnt,
            renewed_order_amount
        FROM favie_rpt.rpt_decofy_subscription_order_metrics_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END