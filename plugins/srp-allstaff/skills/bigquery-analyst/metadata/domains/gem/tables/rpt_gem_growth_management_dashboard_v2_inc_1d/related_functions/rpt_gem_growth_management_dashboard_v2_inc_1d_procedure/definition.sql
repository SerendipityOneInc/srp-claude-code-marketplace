BEGIN
  -- 刷新三个日期的数据：昨天、前天和6天前
  -- 按照正确顺序处理：先刷 base_date-6，再刷 base_date-1，最后刷 base_date
  DECLARE dt_param DATE;
  DECLARE dates ARRAY<INT64> DEFAULT [6, 1, 0]; -- 6天前、前天、昨天
  DECLARE i INT64 DEFAULT 0;
  
  WHILE i < ARRAY_LENGTH(dates) DO
    SET dt_param = DATE_SUB(base_date, INTERVAL dates[OFFSET(i)] DAY);
    
    -- 删除指定日期的数据
    DELETE FROM `favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d` WHERE dt = dt_param;
    
    -- 插入新数据
    INSERT INTO `favie_rpt.rpt_gem_growth_management_dashboard_v4_inc_1d` (
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
      ,impression
      ,click
      ,conversion
      ,cost
      ,install_cnt
      ,new_user_cnt
      ,d0_active_cnt
      ,d1_retention_cnt
      ,lt7_cnt
    FROM `favie_dw.rpt_gem_growth_management_dashboard_v4_inc_1d_function`(dt_param);
    
    SET i = i + 1;
  END WHILE;
END