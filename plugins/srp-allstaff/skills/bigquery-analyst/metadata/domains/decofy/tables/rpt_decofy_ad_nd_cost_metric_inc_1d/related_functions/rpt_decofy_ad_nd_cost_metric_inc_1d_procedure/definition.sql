BEGIN
    DECLARE current_dt DATE;
    DECLARE start_dt DATE;
    
    -- 计算开始日期
    SET start_dt = DATE_SUB(dt_param, INTERVAL x_day DAY);
    SET current_dt = start_dt;
    
    -- 循环处理从 start_dt 到 dt_param 的每一天
    WHILE current_dt <= dt_param DO
        -- 删除当前日期的数据，避免重复插入
        DELETE FROM favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d
        WHERE dt = current_dt and n_day = 7;

        -- 插入当前日期的新数据
        INSERT INTO favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d (
            dt,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            n_day,
            ad_cost
        )
        SELECT
            dt,
            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,
            n_day,
            ad_cost
        FROM favie_rpt.rpt_decofy_ad_nd_cost_metric_inc_1d_function(current_dt, 7);
        
        -- 移动到下一天
        SET current_dt = DATE_ADD(current_dt, INTERVAL 1 DAY);
    END WHILE;
END