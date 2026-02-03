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
      dt,
      app_name,
      event_name,
      appsflyer_id,
      source,
      account_id,
      campaign_id,
      ad_group_id,
      ad_id,
      event_time,
      ROW_NUMBER() OVER (
        PARTITION BY event_name, appsflyer_id 
        ORDER BY event_time ASC
      ) AS event_order_seq,
      dt as event_dt
    FROM `favie_dw.dwd_all_app_appsflyer_webhook_v2_inc_1d_view`
    WHERE dt = dt_param
      AND appsflyer_id IS NOT NULL
      AND event_name IS NOT NULL
  ),
  
  -- 合并逻辑：优先使用当天数据，如果没有则保留前一天数据
  merged_data AS (
    -- 当天有新数据的记录
    SELECT 
       dt,
      app_name,
      c.event_name,
      c.appsflyer_id,
      c.source,
      c.account_id,
      c.campaign_id,
      c.ad_group_id,
      c.ad_id,
      c.event_order_seq,
      c.event_dt
    FROM current_dwd_data c
    
    UNION ALL
    
    -- 当天没有新数据，保留前一天的记录
    SELECT 
      dt,
      app_name,
      p.event_name,
      p.appsflyer_id,
      p.source,
      p.account_id,
      p.campaign_id,
      p.ad_group_id,
      p.ad_id,
      p.event_order_seq,
      p.event_dt
    FROM previous_dim_data p
    WHERE NOT EXISTS (
      SELECT 1 
      FROM current_dwd_data c 
      WHERE  c.appsflyer_id = p.appsflyer_id
      and c.app_name = p.app_name
    )
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
  FROM merged_data