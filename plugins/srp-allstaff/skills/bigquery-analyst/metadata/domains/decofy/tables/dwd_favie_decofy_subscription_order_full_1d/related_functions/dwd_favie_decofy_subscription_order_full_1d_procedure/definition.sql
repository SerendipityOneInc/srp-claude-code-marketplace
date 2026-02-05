BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;
    WHILE n_day >= 1 DO
        -- 删除目标日期的现有数据
        DELETE FROM `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
        WHERE dt = current_dt;

        -- 插入新数据
        INSERT INTO `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
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
            subscription_id,
            subscription_created_at,
            subscription_seq,
            original_transaction_id,
            order_id,
            order_source,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            order_renewal_at,
            order_category,
            order_type,
            order_seq,
            order_subscription_seq,
            order_days_to_expire
            
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
            subscription_id,
            subscription_created_at,
            subscription_seq,
            original_transaction_id,
            order_id,
            order_source,
            order_paid_amount,
            order_paid_currency,
            order_created_at,
            order_updated_at,
            order_expires_date,
            order_deleted_at,
            order_renewal_at,
            order_category,
            order_type,
            order_seq,
            order_subscription_seq,
            order_days_to_expire,
            
        FROM `favie_dw.dwd_favie_decofy_subscription_order_full_1d_function`(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END