BEGIN
  DECLARE current_dt DATE;
  DECLARE start_dt DATE;
  DECLARE day_counter INT64;
  
  -- 计算开始日期：dt_param 减去 (n-1) 天
  SET start_dt = DATE_SUB(dt_param, INTERVAL (n - 1) DAY);
  
  -- 初始化计数器
  SET day_counter = 0;
  
  -- 循环处理n天数据（从 start_dt 到 dt_param，正序）
  WHILE day_counter < n DO
    -- 计算当前处理日期：从 start_dt 开始正序递增
    SET current_dt = DATE_ADD(start_dt, INTERVAL day_counter DAY);
    
    -- 删除当前日期的数据
    DELETE FROM `favie_dw.dws_savyo_growth_ad_metrics_inc_1d` 
    WHERE dt = current_dt;

    -- 插入当前日期的新数据
    INSERT INTO `favie_dw.dws_savyo_growth_ad_metrics_inc_1d` (
      dt
      ,source
      ,platform
      ,app_name
      ,account_id
      ,account_name
      ,campaign_id
      ,campaign_name
      ,ad_group_id
      ,ad_group_name
      ,ad_id
      ,ad_name
      ,ad_category
      ,country_code
      ,channel
      ,attribution_method
      ,account_put_type
      ,account_open_agency
      ,impression
      ,click
      ,conversion
      ,cost
      ,install_cnt
      ,new_user_cnt
      ,d0_active_cnt
      ,d1_retention_cnt
      ,lt7_cnt
    )
    SELECT 
      dt
      ,source
      ,platform
      ,app_name
      ,account_id
      ,account_name
      ,campaign_id
      ,campaign_name
      ,ad_group_id
      ,ad_group_name
      ,ad_id
      ,ad_name
      ,ad_category
      ,country_code
      ,channel
      ,attribution_method
      ,account_put_type
      ,account_open_agency
      ,impression
      ,click
      ,conversion
      ,cost
      ,install_cnt
      ,new_user_cnt
      ,d0_active_cnt
      ,d1_retention_cnt
      ,lt7_cnt
    FROM `favie_dw.dws_savyo_growth_ad_metrics_inc_1d_function`(current_dt);
    
    -- 递增计数器，处理下一天
    SET day_counter = day_counter + 1;
  END WHILE;
  
END