with order_base as (
    SELECT
      dt_param as dt,
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
    FROM
      `favie_dw.dwd_favie_decofy_subscription_order_full_1d`
    WHERE
      dt = (select max(dt) from `favie_dw.dwd_favie_decofy_subscription_order_full_1d`)
      and 
      (
        date(order_created_at) <= dt_param and date(order_created_at) > date_sub(dt_param, INTERVAL n_day_param DAY)
        or 
        date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)
      )
      
  ),

  renewal_metric as (
    SELECT
        dt,
        user_id,
        appsflyer_id,

        product_id,
        simple_product_id,
        product_with_trial,
        subscription_id,

        order_source,
        countif(order_subscription_seq = 1 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)) as first_order_due_cnt,
        countif(order_subscription_seq = 1 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY) and order_renewal_at is not null) as first_order_renewal_cnt,
        countif(order_subscription_seq = 2 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)) as second_order_due_cnt,
        countif(order_subscription_seq = 2 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY) and order_renewal_at is not null) as second_order_renewal_cnt,
        countif(order_subscription_seq >= 3 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY)) as third_more_order_due_cnt,
        countif(order_subscription_seq >= 3 and date(order_expires_date) <= dt_param and date(order_expires_date) > date_sub(dt_param, INTERVAL n_day_param DAY) and order_renewal_at is not null) as third_more_order_renewal_cnt
    FROM order_base
    GROUP BY dt, user_id, appsflyer_id, product_id, simple_product_id, product_with_trial, subscription_id, order_source
  )

  SELECT
    dt,

    user_id,
    appsflyer_id,

    product_id,
    simple_product_id,
    product_with_trial,
    order_source,

    n_day_param as n_day,

    first_order_due_cnt,
    first_order_renewal_cnt,

    second_order_due_cnt,
    second_order_renewal_cnt,

    third_more_order_due_cnt,
    third_more_order_renewal_cnt
  FROM renewal_metric