BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;
  WHILE n_day >= 1 DO
    -- 删除指定分区，避免重复插入
    DELETE FROM favie_rpt.rpt_decofy_subscribe_process_user_metric_inc_1d
    WHERE dt = current_dt;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_decofy_subscribe_process_user_metric_inc_1d (
      dt,
      country_name,
      platform,
      app_version,
      user_group,
      ad_source,
      ad_id,
      ad_group_id,
      ad_campaign_id,
      active_user_cnt,
      subscribe_trigger_user_cnt,
      subscribe_first_order_user_cnt
    )
    SELECT
      dt,
      country_name,
      platform,
      app_version,
      user_group,
      ad_source,
      ad_id,
      ad_group_id,
      ad_campaign_id,
      active_user_cnt,
      subscribe_trigger_user_cnt,
      subscribe_first_order_user_cnt
    FROM favie_rpt.rpt_decofy_subscribe_process_user_metric_inc_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END