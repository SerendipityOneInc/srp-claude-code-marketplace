begin
    -- DECLARE n_day int64 default 2;
    DECLARE current_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        DELETE FROM `favie_dw.dws_decofy_user_group_inc_1d`
        WHERE dt is not null and dt = current_dt;
    
        INSERT INTO `favie_dw.dws_decofy_user_group_inc_1d`(
            dt,
            user_group,
            user_id,
            appsflyer_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_activity_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        )
        select 
            dt,
            user_group,
            user_id,
            appsflyer_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_activity_type,
            membership_tenure_type,
            membership_pay_status,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id
        from favie_dw.dws_decofy_user_group_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
end