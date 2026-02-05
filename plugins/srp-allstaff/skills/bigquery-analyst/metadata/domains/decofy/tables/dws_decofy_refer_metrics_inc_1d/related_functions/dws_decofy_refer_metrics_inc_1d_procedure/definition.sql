begin
    DECLARE i INT64 DEFAULT 0;
    DECLARE current_dt DATE;
    
    -- 循环处理n_day天的数据
    WHILE i < n_day DO
        SET current_dt = DATE_SUB(dt_param, INTERVAL i DAY);
        
        -- 删除当前日期的数据
        delete from favie_dw.dws_decofy_refer_metrics_inc_1d
        where dt = current_dt;

        -- 插入当前日期的数据
        INSERT INTO favie_dw.dws_decofy_refer_metrics_inc_1d 
        (
            dt,
            
            user_id,
            platform,
            app_version,
            country_name,
            user_group,
            user_login_type,
            user_tenure_type,

            appsflyer_id,
            ad_source,
            ad_campaign_id,
            ad_group_id,
            ad_id,

            ap_name,
            refer,
            event_name,
            event_method,
            event_action_type,

            refer_ap_click_cnt,
            refer_pv_cnt,
            refer_view_item_list_cnt,
            refer_true_view_cnt,
            refer_leave_directly_cnt,
            refer_duration_amount,
            refer_click_user_id,
            refer_directly_leave_user_id
        )
        select 
            dt,
            
            user_id,
            platform,
            app_version,
            country_name,
            user_group,
            user_login_type,
            user_tenure_type,

            appsflyer_id,
            ad_source,
            ad_campaign_id,
            ad_group_id,
            ad_id,

            ap_name,
            refer,
            event_name,
            event_method,
            event_action_type,

            refer_ap_click_cnt,
            refer_pv_cnt,
            refer_view_item_list_cnt,
            refer_true_view_cnt,
            refer_leave_directly_cnt,
            refer_duration_amount,
            refer_click_user_id,
            refer_directly_leave_user_id
        from favie_dw.dws_decofy_refer_metrics_inc_1d_function(current_dt);
        
        SET i = i + 1;
    END WHILE;
end