WITH base_dws_data AS (
    SELECT 
      dt,
      item_type,
      item_task_model,
      item_task_type,
      COUNT(DISTINCT IF(item_task_created_time IS NOT NULL 
                        AND DATE(item_task_created_time) = dt_param, item_id, NULL)) AS item_task_list_item_cnt,
      COUNT(DISTINCT IF(event_action_type = "save", item_id, NULL)) AS item_task_save_item_cnt,
      COUNT(DISTINCT IF(event_action_type = 'download', item_id, NULL)) AS item_task_download_item_cnt
    FROM favie_dw.dwd_gensmo_channel_action_info_inc_1d_function(dt_param)
    WHERE item_task_type = 'mix'
    GROUP BY dt, item_type, item_task_model, item_task_type
  )
  SELECT
    dt,
    item_task_model,
    SUM(item_task_list_item_cnt) AS item_task_list_item_cnt,
    SUM(item_task_save_item_cnt) AS item_task_save_item_cnt,
    SUM(item_task_download_item_cnt) AS item_task_download_item_cnt
  FROM base_dws_data
  GROUP BY dt, item_task_model