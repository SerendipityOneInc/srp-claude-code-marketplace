begin
    DECLARE current_dt DATE;
    DECLARE dt_param_1 DATE;
    DECLARE active_user_start_dt DATE;
    DECLARE active_user_end_dt DATE;
    DECLARE retention_user_start_dt DATE;
    DECLARE retention_user_end_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO     
        set active_user_start_dt = date_sub(dt_param, interval (retention_end_period_seq+1) * retention_period -1 day);
        set active_user_end_dt = date_sub(dt_param, interval (retention_end_period_seq) * retention_period day);

        set retention_user_start_dt = date_add(active_user_end_dt, interval (retention_start_period_seq-1)*retention_period +1 day);
        set retention_user_end_dt = date_add(active_user_end_dt, interval (retention_end_period_seq)*retention_period day);

        select 
            current_dt as debug_current_dt,
            retention_period as debug_retention_period,
            retention_start_period_seq as debug_retention_start_period_seq,
            retention_end_period_seq as debug_retention_end_period_seq,
            retention_type_param as debug_retention_type,
            active_user_start_dt as debug_active_user_start_dt,
            active_user_end_dt as debug_active_user_end_dt,
            retention_user_start_dt as debug_retention_user_start_dt,
            retention_user_end_dt as debug_retention_user_end_dt;

        delete from `favie_rpt.rpt_gensmo_user_x_action_retention_metrics_inc_1d`
        where dt = active_user_end_dt and retention_type = retention_type_param;

        INSERT INTO `favie_rpt.rpt_gensmo_user_x_action_retention_metrics_inc_1d`
        (
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

            retention_type,
            retention_user_cnt,
            active_user_cnt
        )
        SELECT
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

            retention_type,
            retention_user_cnt,
            active_user_cnt
        FROM favie_rpt.rpt_gensmo_user_x_action_retention_metrics_inc_1d_function(
            retention_type_param,
            active_user_start_dt,
            active_user_end_dt,
            retention_user_start_dt,
            retention_user_end_dt
        );
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END