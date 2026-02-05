begin
    DECLARE current_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        delete from `favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d`
        where dt = current_dt and active_period = active_period_param;
        
        INSERT INTO `favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d` 
        (
            dt,
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

            active_period,

            active_user_cnt,
            user_duration
        )
        select 
            dt,
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

            active_period,

            active_user_cnt,
            user_duration
        from favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d_function(current_dt,active_period_param);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    end WHILE;
end