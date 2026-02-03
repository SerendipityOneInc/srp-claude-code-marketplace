begin
    DECLARE current_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        delete from `favie_rpt.rpt_decofy_user_active_metrics_inc_1d`
        where dt is not null and dt = current_dt;
        
        INSERT INTO `favie_rpt.rpt_decofy_user_active_metrics_inc_1d` 
        (
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            active_user_d1_cnt,
            total_duration
        )
        select 
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            membership_tenure_type,
            membership_pay_status,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            active_user_d1_cnt,
            total_duration
        from favie_rpt.rpt_decofy_user_active_metrics_inc_1d_function(current_dt) ;
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    end WHILE;
end