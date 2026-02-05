begin
    declare end_dt date default DATE_TRUNC(date_sub(DATE_TRUNC(dt_param, WEEK(SUNDAY)),interval 1 day),WEEK(SUNDAY));
    IF EXTRACT(DAYOFWEEK FROM dt_param) IN (1, 2, 3) THEN

        DELETE FROM `favie_rpt.rpt_decofy_user_retention_metrics_inc_1w`
        WHERE week_end_dt is not null and week_end_dt = DATE_TRUNC(DATE_SUB(end_dt, INTERVAL 7 DAY), WEEK(SUNDAY));
    
        INSERT INTO `favie_rpt.rpt_decofy_user_retention_metrics_inc_1w`(
            week_end_dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            retention_user_w1_cnt,
            active_user_cnt
        )
        select 
            week_end_dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            retention_user_w1_cnt,
            active_user_cnt
        from favie_rpt.rpt_decofy_user_retention_metrics_inc_1w_function(end_dt);
    end if;
end