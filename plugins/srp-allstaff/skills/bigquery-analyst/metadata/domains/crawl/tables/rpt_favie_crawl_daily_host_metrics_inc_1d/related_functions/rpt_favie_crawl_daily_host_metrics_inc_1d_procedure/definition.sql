BEGIN
  -- 1. 先删除这一天已有的数据，避免重复 & 支持重跑
  DELETE FROM `favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d`
  WHERE dt = dt_param;

  -- 2. 插入 function 计算出的这一天所有 host 指标
  INSERT INTO `favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d` (
    dt,
    host,
    success_cnt,
    failed_cnt,
    duplicate_cnt,
    not_found_cnt,
    delisted_cnt,
    parse_failed_cnt,
    total_cnt
  )
  SELECT
    dt,
    host,
    success_cnt,
    failed_cnt,
    duplicate_cnt,
    not_found_cnt,
    delisted_cnt,
    parse_failed_cnt,
    total_cnt
  FROM `favie_dw.rpt_favie_crawl_daily_host_metrics_inc_1d_function`(dt_param);
END