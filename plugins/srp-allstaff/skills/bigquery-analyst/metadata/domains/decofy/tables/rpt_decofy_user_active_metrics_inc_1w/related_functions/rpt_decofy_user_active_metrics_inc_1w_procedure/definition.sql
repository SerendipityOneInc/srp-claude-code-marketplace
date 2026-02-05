begin
    declare end_dt date default DATE_TRUNC(date_sub(DATE_TRUNC(dt_param, WEEK(SUNDAY)),interval 1 day),WEEK(SUNDAY));
    IF EXTRACT(DAYOFWEEK FROM dt_param) IN (1, 2, 3) THEN

        DELETE FROM `favie_rpt.rpt_decofy_user_active_metrics_inc_1w`
        WHERE week_end_dt is not null and week_end_dt = end_dt;
    
        INSERT INTO `favie_rpt.rpt_decofy_user_active_metrics_inc_1w`(
            week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            active_user_w1_cnt,
            total_duration
        )
        select 
            week_end_dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            active_user_w1_cnt,
            total_duration
        from favie_rpt.rpt_decofy_user_active_metrics_inc_1w_function(end_dt);
    end if;
end