BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;
  WHILE n_day >= 1 DO
    DELETE FROM favie_dw.dws_decofy_membership_full_1d
    WHERE dt = current_dt;
    INSERT INTO favie_dw.dws_decofy_membership_full_1d
    (
      dt,
      user_id,
      appsflyer_id,
      order_source,
      membership_tenure_type,
      first_subscribe_at,
      first_subscribe_product_id,
      first_subscribe_simple_product_id,
      first_pay_at,
      first_pay_subscribe_at,
      latest_subscribe_at,
      latest_subscribe_seq,
      latest_order_product_id,
      latest_order_simple_product_id,
      latest_order_expires_date,
      latest_order_renewal_at,
      latest_order_created_at,
      latest_order_subscription_seq,
      latest_order_category,
      latest_order_type,
      latest_order_seq,
      total_paid_order_cnt,
      total_paid_order_usd_amount,
      total_subscribe_cnt,
      total_subscribe_product_cnt,
      total_order_cnt,
      subscribe_products
    )
    SELECT
      dt,
      user_id,
      appsflyer_id,
      order_source,
      membership_tenure_type,
      first_subscribe_at,
      first_subscribe_product_id,
      first_subscribe_simple_product_id,
      first_pay_at,
      first_pay_subscribe_at,
      latest_subscribe_at,
      latest_subscribe_seq,
      latest_order_product_id,
      latest_order_simple_product_id,
      latest_order_expires_date,
      latest_order_renewal_at,
      latest_order_created_at,
      latest_order_subscription_seq,
      latest_order_category,
      latest_order_type,
      latest_order_seq,
      total_order_cnt,
      total_paid_order_cnt,
      total_paid_order_usd_amount,
      total_subscribe_cnt,
      total_subscribe_product_cnt,
      subscribe_products
    FROM favie_dw.dws_decofy_membership_full_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END