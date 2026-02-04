begin
    DECLARE current_dt DATE;
    DECLARE dt_param_1 DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        set dt_param_1 = DATE_SUB(current_dt, INTERVAL 1 DAY);
        
        delete from `favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
        where dt is not null and dt = dt_param_1;
        
        INSERT INTO `favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
        (
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            
            retention_user_d1_cnt,
            active_user_cnt
        )
        SELECT
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,

            retention_user_d1_cnt,
            active_user_cnt
        FROM favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END