WITH 
  -- 获取前一天的维度表数据 (dt_param - 1)
  previous_dim_data AS (
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
    FROM `favie_dw.dim_all_app_appsflyer_ad_info_mapping_full_1d`
    WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
  ),
  
  -- 获取当天的dwd数据 (dt_param)
  current_dwd_data AS (
    SELECT 
      app_name,
      event_name,
      appsflyer_id,
      source,
      account_id,
      campaign_id,
      ad_group_id,
      ad_id,
      event_time
    FROM `favie_dw.dwd_all_app_total_appsflyer_webhook_inc_1d_view`
    WHERE dt = dt_param
      AND appsflyer_id IS NOT NULL
      AND event_name IS NOT NULL
  ),
  
  -- 合并逻辑：当天有新数据的appsflyer_id使用新数据（完全替换），没有的保留前一天数据
  merged_data AS (
    -- 当天有新数据的记录（完全替换该appsflyer_id+app_name的所有历史数据）
    SELECT 
      dt_param AS dt,
      app_name,
      event_name,
      appsflyer_id,
      source,
      account_id,
      campaign_id,
      ad_group_id,
      ad_id,
      event_time,
      dt_param AS event_dt
    FROM current_dwd_data
    
    UNION ALL
    
    -- 前一天的数据，但排除当天有新数据的appsflyer_id+app_name组合
    SELECT 
      dt_param AS dt,
      app_name,
      p.event_name,
      p.appsflyer_id,
      p.source,
      p.account_id,
      p.campaign_id,
      p.ad_group_id,
      p.ad_id,
      NULL AS event_time,
      p.event_dt
    FROM previous_dim_data p
    WHERE NOT EXISTS (
      SELECT 1 
      FROM current_dwd_data c 
      WHERE c.appsflyer_id = p.appsflyer_id
        AND c.app_name = p.app_name
    )
  ),
  
  -- 为每个appsflyer_id重新计算event_order_seq
  final_data AS (
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
      ROW_NUMBER() OVER (
        PARTITION BY appsflyer_id
        ORDER BY event_time ASC
      ) AS event_order_seq,
      event_dt
    FROM merged_data
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
  FROM final_data