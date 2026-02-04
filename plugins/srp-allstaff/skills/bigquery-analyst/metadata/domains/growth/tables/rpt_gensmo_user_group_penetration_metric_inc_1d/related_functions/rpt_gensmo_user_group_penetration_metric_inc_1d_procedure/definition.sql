BEGIN
    DECLARE current_dt DATE;
    SET current_dt = dt_param;

    WHILE n_day >= 1 DO
        -- 删除当前日期的数据
        DELETE FROM `favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d`
        WHERE dt = current_dt;
        
        -- 插入新数据
        INSERT INTO `favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d` 
        (
            dt,
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
            group_user_cnt,
            active_user_cnt
        )
        SELECT 
            dt,
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
            group_user_cnt,
            active_user_cnt
        FROM favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d_function(current_dt);
        call favie_dw.record_partition('favie_rpt.rpt_gensmo_user_group_penetration_metric_inc_1d', current_dt,"");
        -- 日期递减
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END