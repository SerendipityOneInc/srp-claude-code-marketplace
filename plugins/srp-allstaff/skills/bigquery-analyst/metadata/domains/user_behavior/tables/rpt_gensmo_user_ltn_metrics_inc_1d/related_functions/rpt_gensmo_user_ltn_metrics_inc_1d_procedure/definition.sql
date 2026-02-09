begin
    declare dt_param_n date default date_sub(dt_param, interval n-1 day);

    DELETE FROM `favie_rpt.rpt_gensmo_user_ltn_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param_n;
  
    INSERT INTO `favie_rpt.rpt_gensmo_user_ltn_metrics_inc_1d`(
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        lifetime_days,
        active_days_cnt,
        active_user_cnt
    )
    select 
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        lifetime_days,
        active_days_cnt,
        active_user_cnt
    from favie_rpt.rpt_gensmo_user_ltn_metrics_inc_1d_function(dt_param,n);
end