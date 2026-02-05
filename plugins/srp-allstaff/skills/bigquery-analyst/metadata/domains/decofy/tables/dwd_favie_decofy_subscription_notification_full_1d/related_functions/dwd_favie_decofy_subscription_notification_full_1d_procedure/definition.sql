BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;
    WHILE n_day >= 1 DO
        -- 删除目标日期的现有数据
        DELETE FROM `favie_dw.dwd_favie_decofy_subscription_notification_full_1d`
        WHERE dt = current_dt;

        -- 插入新数据
        INSERT INTO `favie_dw.dwd_favie_decofy_subscription_notification_full_1d`
        (
            dt,
            user_id,
            appsflyer_id,
            product_id,
            simple_product_id,
            product_price,
            product_first_order_price,
            product_currency,
            product_with_trial,
            product_period,
            notification_uuid,
            notification_type,
            transaction_id,
            original_transaction_id,
            subscription_status,
            subtype,
            created_at,
            updated_at
        )
        SELECT 
            dt,
            user_id,
            appsflyer_id,
            product_id,
            simple_product_id,
            product_price,
            product_first_order_price,
            product_currency,
            product_with_trial,
            product_period,
            notification_uuid,
            notification_type,
            transaction_id,
            original_transaction_id,
            subscription_status,
            subtype,
            created_at,
            updated_at
        FROM `favie_dw.dwd_favie_decofy_subscription_notification_full_1d_function`(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END