BEGIN
  -- 删除指定日期的数据
  declare weekly_end DATE DEFAULT date_add(dt_param, INTERVAL 6 DAY);
  DELETE FROM `favie_rpt.rpt_favie_webpage_metric_full_1w`
  WHERE dt = weekly_end;

  -- 插入数据
  INSERT INTO `favie_rpt.rpt_favie_webpage_metric_full_1w` (
    domain,
    total_webpage_num,
    weekly_new_webpage_num,
    weekly_update_webpage_num,
    dt
  )
  SELECT
    domain,
    total_webpage_num,
    weekly_new_webpage_num,
    weekly_update_webpage_num,
    dt
  FROM `favie_rpt.rpt_favie_webpage_metric_full_1w_function`(weekly_end);
  call favie_dw.record_partition('favie_rpt.rpt_favie_webpage_metric_full_1w', weekly_end,"");
END