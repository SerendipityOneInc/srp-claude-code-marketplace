BEGIN
    DECLARE i INT64 DEFAULT 0;
    DECLARE current_dt DATE;
    
    -- 循环处理n_day天的数据
    WHILE i < n_day DO
        SET current_dt = DATE_SUB(dt_param, INTERVAL i DAY);
        
        -- 删除当前日期的数据
        DELETE FROM favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d
        WHERE dt = current_dt;

        -- 插入当前日期的数据
        INSERT INTO favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d
        (
            dt,
            refer,
            ap_name,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            pv_user_cnt,
            click_user_cnt
        )
        SELECT 
            dt,
            refer,
            ap_name,
            user_group,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            ad_source,
            ad_group_id,
            ad_campaign_id,
            ad_id,
            pv_user_cnt,
            click_user_cnt
        FROM favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d_function(current_dt);
        
        CALL favie_dw.record_partition('favie_rpt.rpt_gensmo_refer_click_user_penetration_metric_inc_1d', current_dt, "");
        SET i = i + 1;
    END WHILE;
END