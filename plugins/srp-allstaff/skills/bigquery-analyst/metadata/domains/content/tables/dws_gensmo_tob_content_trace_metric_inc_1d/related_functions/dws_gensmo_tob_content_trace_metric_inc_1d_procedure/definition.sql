BEGIN
  -- 删除指定日期的数据
  DELETE FROM `favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d`
  WHERE dt = dt_param;

  -- 插入数据
  INSERT INTO `favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d` (
    dt,
    site,
    country,
    vibe_id,
    product_id,
    vibe_image_url,
    try_on_image_url,
    product_url,
    product_image_url,
    show_cnt,
    click_cnt
  )
  SELECT
    dt,
    site,
    country,
    vibe_id,
    product_id,
    vibe_image_url,
    try_on_image_url,
    product_url,
    product_image_url,
    show_cnt,
    click_cnt
  FROM `favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d_function`(dt_param);

  call favie_dw.record_partition('favie_dw.dws_gensmo_tob_content_trace_metric_inc_1d', dt_param,"");
END