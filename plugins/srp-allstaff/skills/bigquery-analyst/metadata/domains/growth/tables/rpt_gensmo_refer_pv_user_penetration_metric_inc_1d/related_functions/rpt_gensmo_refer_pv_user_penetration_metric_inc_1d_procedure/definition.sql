BEGIN
    DECLARE i INT64 DEFAULT 0;
    DECLARE current_dt DATE;
    
    -- 循环处理n_day天的数据
    WHILE i < n_day DO
        SET current_dt = DATE_SUB(dt_param, INTERVAL i DAY);
        
        -- 删除当前日期的数据
        DELETE FROM favie_rpt.rpt_gensmo_refer_pv_user_penetration_metric_inc_1d
        WHERE dt = current_dt;

        -- 插入当前日期的数据
        INSERT INTO favie_rpt.rpt_gensmo_refer_pv_user_penetration_metric_inc_1d
        (
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group,
            refer,
            refer_user_cnt,
            active_user_d1_cnt
        )
        SELECT 
            dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            user_group,
            refer,
            refer_user_cnt,
            active_user_d1_cnt
        FROM favie_rpt.rpt_gensmo_refer_pv_user_penetration_metric_inc_1d_function(current_dt);
        
        CALL favie_dw.record_partition('favie_rpt.rpt_gensmo_refer_pv_user_penetration_metric_inc_1d', current_dt, "");
        SET i = i + 1;
    END WHILE;
END