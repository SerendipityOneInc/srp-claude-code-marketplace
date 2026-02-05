BEGIN

  DELETE FROM favie_rpt.rpt_decofy_subscribe_renewal_metric_inc_1d
  WHERE dt = dt_param;

  -- 插入新数据
  INSERT INTO favie_rpt.rpt_decofy_subscribe_renewal_metric_inc_1d (
    dt,

    country_name,
    platform,
    user_group,
    ad_source,
    ad_id,
    ad_group_id,
    ad_campaign_id,
    product_id,
    simple_product_id,
    product_with_trial,
    order_source,
    first_order_due_cnt,
    first_order_renewal_cnt,
    second_order_due_cnt,
    second_order_renewal_cnt,
    third_more_order_due_cnt,
    third_more_order_renewal_cnt
  )
  SELECT
    dt,
    country_name,
    platform,
    user_group,
    ad_source,
    ad_id,
    ad_group_id,
    ad_campaign_id,
    product_id,
    simple_product_id,
    product_with_trial,
    order_source,
    first_order_due_cnt,
    first_order_renewal_cnt,
    second_order_due_cnt,
    second_order_renewal_cnt,
    third_more_order_due_cnt,
    third_more_order_renewal_cnt
  FROM favie_rpt.rpt_decofy_subscribe_renewal_metric_inc_1d_function(dt_param, 30);

END