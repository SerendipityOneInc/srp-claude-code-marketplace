begin
    declare dt_param_n date default date_sub(dt_param, interval n-1 day);

    DELETE FROM `favie_rpt.rpt_gensmo_user_action_ltn_metrics_inc_1d`
    WHERE dt = dt_param_n;
  
    INSERT INTO `favie_rpt.rpt_gensmo_user_action_ltn_metrics_inc_1d`(
        dt,
        action_type,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_segment,
        user_tenure_type,

        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,

        user_group,
        lifetime_days,
        active_days_cnt,
        active_user_cnt
    )
    select 
        dt,
        action_type,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_segment,
        user_tenure_type,

        ad_source,
        ad_id,
        ad_group_id,
        ad_campaign_id,
        
        user_group,
        lifetime_days,
        active_days_cnt,
        active_user_cnt
    from favie_rpt.rpt_gensmo_user_action_ltn_metrics_inc_1d_function_v2(dt_param,n, group_type);
end