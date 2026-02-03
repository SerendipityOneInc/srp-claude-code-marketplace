BEGIN
    delete from favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d
    where dt = dt_param;
    
    INSERT INTO favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d (
      dt,
      platform,
      app_version,
      geo_country_name,
      event_name,
      event_method,
      invalid_user_cnt
    )
    SELECT
      dt,
      platform,
      app_version,
      geo_country_name,
      event_name,
      event_method,
      invalid_user_cnt
    FROM favie_rpt.rpt_gensmo_invalid_user_metrics_inc_1d_function(dt_param);
END