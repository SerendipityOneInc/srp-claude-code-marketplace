BEGIN
  DECLARE previous_date DATE;
  DECLARE partition_count INT64;
  
  -- 计算前一天日期
  SET previous_date = DATE_SUB(base_date, INTERVAL 1 DAY);
  
  -- 检查前一天的分区是否存在
  SET partition_count = (
    SELECT COUNT(1)
    FROM `favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d`
    WHERE dt = previous_date
  );
  
  -- 如果前一天分区不存在，抛出异常
  IF partition_count = 0 THEN
    RAISE USING MESSAGE = CONCAT('前一天分区不存在: dt = ', CAST(previous_date AS STRING), ', 请先处理前一天的数据');
  END IF;
  
  -- 删除当天数据
  DELETE FROM `favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d` 
  WHERE dt = base_date;
  
  -- 插入新数据
  INSERT INTO `favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d` (
    dt,
    app_name,
    event_name,
    appsflyer_id,
    source,
    account_id,
    campaign_id,
    ad_group_id,
    ad_id,
    event_order_seq,
    event_dt
  )
  SELECT 
    dt,
    app_name,
    event_name,
    appsflyer_id,
    source,
    account_id,
    campaign_id,
    ad_group_id,
    ad_id,
    event_order_seq,
    event_dt
  FROM `favie_dw.dim_all_app_appsflyer_all_reachout_info_mapping_full_1d_function`(base_date);
  
END