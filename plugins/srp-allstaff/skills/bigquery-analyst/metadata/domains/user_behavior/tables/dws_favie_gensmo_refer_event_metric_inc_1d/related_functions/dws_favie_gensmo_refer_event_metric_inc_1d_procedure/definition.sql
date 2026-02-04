BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;  

  WHILE n_day > 0 DO
   -- delete existing data
   DELETE FROM favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d
   WHERE dt = current_dt;

   -- insert
   INSERT INTO favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d (
    dt,
    refer,
    ap_name,
    event_name,
    event_method,
    event_action_type,
    item_type,
    app_version,
    platform,
    event_cnt
   )
   SELECT
    dt,
    refer,
    ap_name,
    event_name,
    event_method,
    event_action_type,
    item_type,
    app_version,
    platform,
    event_cnt
    FROM favie_dw.dws_favie_gensmo_refer_event_metric_inc_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END