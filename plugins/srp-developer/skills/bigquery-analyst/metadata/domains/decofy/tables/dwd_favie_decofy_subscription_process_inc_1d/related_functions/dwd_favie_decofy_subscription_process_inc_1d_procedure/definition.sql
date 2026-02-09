BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;
    WHILE n_day >= 1 DO
        -- 删除目标日期的现有数据
        DELETE FROM `favie_dw.dwd_favie_decofy_subscription_process_inc_1d`
        WHERE dt = current_dt;

        -- 插入新数据
        INSERT INTO `favie_dw.dwd_favie_decofy_subscription_process_inc_1d`
        (
            dt,
            user_id,
            process_node,
            trigger_source,
            product_id,
            simple_product_id,
            order_id,
            order_category,
            order_type,
            order_subscription_seq,
            subscription_id,
            process_time,
            trigger_pay_seq
        )
        SELECT 
            dt,
            user_id,
            process_node,
            trigger_source,
            product_id,
            simple_product_id,
            order_id,
            order_category,
            order_type,
            order_subscription_seq,
            subscription_id,
            process_time,
            trigger_pay_seq
        FROM `favie_dw.dwd_favie_decofy_subscription_process_inc_1d_function`(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END