begin
    -- DECLARE n_day int64 default 2;
    DECLARE current_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        DELETE FROM `favie_dw.dws_gensmo_user_group_inc_1d`
        WHERE dt is not null and dt = current_dt;
    
        INSERT INTO `favie_dw.dws_gensmo_user_group_inc_1d`(
            dt,
            user_group,
            device_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type
        )
        select 
            dt,
            user_group,
            device_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type
        from favie_dw.dws_gensmo_user_group_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
end