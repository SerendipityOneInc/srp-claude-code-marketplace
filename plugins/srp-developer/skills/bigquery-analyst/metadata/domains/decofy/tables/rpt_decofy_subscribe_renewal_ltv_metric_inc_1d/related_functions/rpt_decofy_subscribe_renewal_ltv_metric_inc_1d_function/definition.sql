with renewal_30_day as (
    SELECT
      dt,

      user_id,
      appsflyer_id,

      product_id,
      simple_product_id,
      product_with_trial,
      order_source,

      first_order_due_cnt as first_order_due_30d_cnt,
      first_order_renewal_cnt as first_order_renewal_30d_cnt,

      second_order_due_cnt as second_order_due_30d_cnt,
      second_order_renewal_cnt as second_order_renewal_30d_cnt,

      third_more_order_due_cnt as third_more_order_due_30d_cnt,
      third_more_order_renewal_cnt as third_more_order_renewal_30d_cnt
    FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d
    where dt = dt_param and n_day = 30
  ),

  renewal_60_day as (
    SELECT
      dt,

      user_id,
      appsflyer_id,

      product_id,
      simple_product_id,
      product_with_trial,
      order_source,

      first_order_due_cnt as first_order_due_60d_cnt,
      first_order_renewal_cnt as first_order_renewal_60d_cnt,

      second_order_due_cnt as second_order_due_60d_cnt,
      second_order_renewal_cnt as second_order_renewal_60d_cnt,

      third_more_order_due_cnt as third_more_order_due_60d_cnt,
      third_more_order_renewal_cnt as third_more_order_renewal_60d_cnt
    FROM favie_dw.dws_decofy_subscribe_renewal_nd_metric_inc_1d
    where dt = dt_param and n_day = 60
  ),


  renewal_metric as (
    SELECT
      COALESCE(t1.dt, t2.dt) as dt,
      COALESCE(t1.user_id, t2.user_id) as user_id,
      COALESCE(t1.appsflyer_id, t2.appsflyer_id) as appsflyer_id,

      COALESCE(t1.product_id, t2.product_id) as product_id,
      COALESCE(t1.simple_product_id, t2.simple_product_id) as simple_product_id,
      COALESCE(t1.product_with_trial, t2.product_with_trial) as product_with_trial,
      COALESCE(t1.order_source, t2.order_source) as order_source,

      COALESCE(t1.first_order_due_30d_cnt, 0) as first_order_due_30d_cnt,
      COALESCE(t1.first_order_renewal_30d_cnt, 0) as first_order_renewal_30d_cnt,
      COALESCE(t2.first_order_due_60d_cnt, 0) as first_order_due_60d_cnt,
      COALESCE(t2.first_order_renewal_60d_cnt, 0) as first_order_renewal_60d_cnt,

      COALESCE(t1.second_order_due_30d_cnt, 0) as second_order_due_30d_cnt,
      COALESCE(t1.second_order_renewal_30d_cnt, 0) as second_order_renewal_30d_cnt,
      COALESCE(t2.second_order_due_60d_cnt, 0) as second_order_due_60d_cnt,
      COALESCE(t2.second_order_renewal_60d_cnt, 0) as second_order_renewal_60d_cnt,

      COALESCE(t1.third_more_order_due_30d_cnt, 0) as third_more_order_due_30d_cnt,
      COALESCE(t1.third_more_order_renewal_30d_cnt, 0) as third_more_order_renewal_30d_cnt,
      COALESCE(t2.third_more_order_due_60d_cnt, 0) as third_more_order_due_60d_cnt,
      COALESCE(t2.third_more_order_renewal_60d_cnt, 0) as third_more_order_renewal_60d_cnt
    FROM renewal_30_day t1
    FULL OUTER JOIN renewal_60_day t2
    ON t1.user_id = t2.user_id 
      and t1.product_id = t2.product_id 
      and t1.simple_product_id = t2.simple_product_id 
      and t1.product_with_trial = t2.product_with_trial
      and t1.order_source = t2.order_source
      and t1.dt = t2.dt
    WHERE t1.dt = dt_param
  ),

  final_data as (
    SELECT
      t1.dt,
      t1.product_id,
      t1.simple_product_id,
      t1.product_with_trial,
      t1.order_source,
      sum(t1.first_order_due_30d_cnt) as first_order_due_30d_cnt,
      sum(t1.first_order_renewal_30d_cnt) as first_order_renewal_30d_cnt,
      sum(t1.first_order_due_60d_cnt) as first_order_due_60d_cnt,
      sum(t1.first_order_renewal_60d_cnt) as first_order_renewal_60d_cnt,
      max(t2.default_first_order_renewal_rate) as default_first_order_renewal_rate,

      sum(t1.second_order_due_30d_cnt) as second_order_due_30d_cnt,
      sum(t1.second_order_renewal_30d_cnt) as second_order_renewal_30d_cnt,
      sum(t1.second_order_due_60d_cnt) as second_order_due_60d_cnt,
      sum(t1.second_order_renewal_60d_cnt) as second_order_renewal_60d_cnt,
      max(t2.default_second_order_renewal_rate) as default_second_order_renewal_rate,

      sum(t1.third_more_order_due_30d_cnt) as third_more_order_due_30d_cnt,
      sum(t1.third_more_order_renewal_30d_cnt) as third_more_order_renewal_30d_cnt,
      sum(t1.third_more_order_due_60d_cnt) as third_more_order_due_60d_cnt,
      sum(t1.third_more_order_renewal_60d_cnt) as third_more_order_renewal_60d_cnt,
      max(t2.default_third_more_order_renewal_rate) as default_third_more_order_renewal_rate
    FROM renewal_metric t1 left outer join favie_dw.dim_decofy_product_config t2
      on t1.product_id = t2.product_id
    where t2.product_id is not null

    GROUP BY 
      t1.dt,
      t1.product_id,
      t1.simple_product_id,
      t1.product_with_trial,
      t1.order_source
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
  FROM final_data