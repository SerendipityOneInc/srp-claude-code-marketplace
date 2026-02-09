WITH base_data AS (
    SELECT 
        dt,
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
     FROM favie_dw.dws_decofy_refer_general_metrics_inc_1d
     WHERE dt = dt_param
  ),

  base_dws_data AS (
    SELECT 
        dt,
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        CAST(SUM(IF(data_name='refer_ap_click_cnt', data_value, 0)) AS INT64) AS refer_ap_click_cnt,
        CAST(SUM(IF(data_name='refer_pv_cnt', data_value, 0)) AS INT64) AS refer_pv_cnt,
        CAST(SUM(IF(data_name='refer_view_item_list_cnt', data_value, 0)) AS INT64) AS refer_view_item_list_cnt,
        CAST(SUM(IF(data_name='refer_true_view_cnt', data_value, 0)) AS INT64) AS refer_true_view_cnt,
        CAST(SUM(IF(data_name='refer_leave_directly_cnt', data_value, 0)) AS INT64) AS refer_leave_directly_cnt,
        CAST(SUM(IF(data_name='refer_duration_amount', data_value, 0)) AS INT64) AS refer_duration_amount
    FROM base_data
    GROUP BY 
        dt,
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type
  ),

  user_info_with_group as (
    select 
      user_id,
      appsflyer_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group,
      ad_source,
      ad_campaign_id,
      ad_group_id,
      ad_id
    from `favie_dw.dws_decofy_user_group_inc_1d` 
    where dt = dt_param
  ),

  base_data_with_user AS (
    SELECT 
      t1.dt,

      t1.user_id,
      t2.platform,
      t2.app_version,
      t2.country_name,
      t2.user_group,
      t2.user_login_type,
      t2.user_tenure_type,

      t2.appsflyer_id,
      t2.ad_source,
      t2.ad_campaign_id,
      t2.ad_group_id,
      t2.ad_id,

      t1.refer,
      t1.ap_name,
      t1.event_name,
      t1.event_method,
      t1.event_action_type,
      t1.refer_ap_click_cnt,
      t1.refer_pv_cnt,
      t1.refer_view_item_list_cnt,
      t1.refer_true_view_cnt,
      t1.refer_leave_directly_cnt,
      t1.refer_duration_amount,
      IF(t1.refer_ap_click_cnt>0, t1.user_id, NULL) AS refer_click_user_id,
      IF(t1.refer_leave_directly_cnt>0, t1.user_id, NULL) AS refer_directly_leave_user_id
    FROM base_dws_data AS t1
    LEFT OUTER JOIN user_info_with_group t2
    ON t1.user_id = t2.user_id
    where t2.user_id is not null
  )
  
  SELECT 
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
    FROM base_data_with_user