BEGIN
  -- 删除指定日期的数据
  declare weekly_end DATE DEFAULT date_add(dt_param, INTERVAL 6 DAY);
  DELETE FROM `favie_rpt.rpt_favie_product_review_metric_full_1w`
  WHERE dt = weekly_end;

  -- 插入数据
  INSERT INTO `favie_rpt.rpt_favie_product_review_metric_full_1w` (
    site,
    total_review_num,
    weekly_new_review_num,
    weekly_update_review_num,
    total_spu_num_with_review,
    spu_num_with_review_count_ge_10,
    dt
  )
  SELECT
    site,
    total_review_num,
    weekly_new_review_num,
    weekly_update_review_num,
    total_spu_num_with_review,
    spu_num_with_review_count_ge_10,
    dt
  FROM `favie_rpt.rpt_favie_product_review_metric_full_1w_function`(weekly_end);
  call favie_dw.record_partition('favie_rpt.rpt_favie_product_review_metric_full_1w', weekly_end,"");
END