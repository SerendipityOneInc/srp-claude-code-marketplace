BEGIN
  -- 删除指定日期的数据
  DELETE FROM `favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d`
  WHERE dt = dt_param;

  -- 插入数据
  INSERT INTO `favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d` (
    dt,
    site,
    country,
    impid,
    exp_id,
    vibe_list,
    product_id,
    show_cnt,
    click_cnt,
    unique_click_cnt,
    unique_click_product_cnt
  )
  SELECT
    dt,
    site,
    country,
    impid,
    exp_id,
    vibe_list,
    product_id,
    show_cnt,
    click_cnt,
    unique_click_cnt,
    unique_click_product_cnt
  FROM `favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d_function`(dt_param);

  call favie_dw.record_partition('favie_dw.dws_gensmo_tob_group_trace_metric_inc_1d', dt_param,"");
END