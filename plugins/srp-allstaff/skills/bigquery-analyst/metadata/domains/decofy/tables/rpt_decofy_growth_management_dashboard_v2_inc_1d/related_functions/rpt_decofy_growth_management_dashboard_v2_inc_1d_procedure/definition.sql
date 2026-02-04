BEGIN
  -- 计算full_dt：当前日期-1（最新一天的数据）
  DECLARE full_dt_param DATE DEFAULT DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY);
  
  -- 刷新8个日期的数据：base_date-0 到 base_date-7
  -- 按照正确顺序处理：先刷 base_date-7，最后刷 base_date
  DECLARE dt_param DATE;
  DECLARE dates ARRAY<INT64> DEFAULT [7, 6, 5, 4, 3, 2, 1, 0]; -- 7天前到当天
  DECLARE i INT64 DEFAULT 0;
  
  WHILE i < ARRAY_LENGTH(dates) DO
    SET dt_param = DATE_SUB(base_date, INTERVAL dates[OFFSET(i)] DAY);
    
    -- 删除指定日期的数据
    DELETE FROM `favie_rpt.rpt_decofy_growth_management_dashboard_v2_inc_1d` WHERE dt = dt_param;
    
    -- 插入新数据
    INSERT INTO `favie_rpt.rpt_decofy_growth_management_dashboard_v2_inc_1d` (
      dt,
      source,
      platform,
      app_name,
      account_id,
      account_name,
      campaign_id,
      campaign_name,
      ad_group_id,
      ad_group_name,
      ad_id,
      ad_name,
      country_code,
      channel,
      impression,
      click,
      conversion,
      cost,
      install_cnt,
      user_cnt,
      subscription_7d_cnt,
      subscription_3d_cnt,
      subscription_1d_cnt,
      subscription_0d_cnt,
      paid_7d_cnt,
      paid_3d_cnt,
      paid_1d_cnt,
      paid_0d_cnt,
      trial_7d_cnt,
      trial_3d_cnt,
      trial_1d_cnt,
      trial_0d_cnt,
      total_order_paid_amount,
      first_paid_weekly_9990_cnt,
      first_paid_annual_39990_cnt,
      first_paid_free_trial_cnt,
      second_paid_weekly_9990_cnt,
      second_paid_annual_39990_cnt,
      second_paid_free_trial_cnt
    )
    SELECT 
      dt,
      source,
      platform,
      app_name,
      account_id,
      account_name,
      campaign_id,
      campaign_name,
      ad_group_id,
      ad_group_name,
      ad_id,
      ad_name,
      country_code,
      channel,
      impression,
      click,
      conversion,
      cost,
      install_cnt,
      user_cnt,
      subscription_7d_cnt,
      subscription_3d_cnt,
      subscription_1d_cnt,
      subscription_0d_cnt,
      paid_7d_cnt,
      paid_3d_cnt,
      paid_1d_cnt,
      paid_0d_cnt,
      trial_7d_cnt,
      trial_3d_cnt,
      trial_1d_cnt,
      trial_0d_cnt,
      total_order_paid_amount,
      first_paid_weekly_9990_cnt,
      first_paid_annual_39990_cnt,
      first_paid_free_trial_cnt,
      second_paid_weekly_9990_cnt,
      second_paid_annual_39990_cnt,
      second_paid_free_trial_cnt
    FROM `favie_rpt.rpt_decofy_growth_management_dashboard_v2_inc_1d_function`(full_dt_param, dt_param);
    
    SET i = i + 1;
  END WHILE;
END