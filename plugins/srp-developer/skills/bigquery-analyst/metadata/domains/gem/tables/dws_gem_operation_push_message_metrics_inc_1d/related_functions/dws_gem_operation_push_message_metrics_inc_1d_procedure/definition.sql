BEGIN
    -- 先删除当天的数据，确保幂等性
    DELETE FROM favie_dw.dws_gem_operation_push_message_metrics_inc_1d
    WHERE dt = dt_param;

    -- 插入最新数据
    INSERT INTO favie_dw.dws_gem_operation_push_message_metrics_inc_1d
    (
      dt,
      user_id,
      push_name,
      sent_count,
      click_count,
      platform,
      user_type
    )
    SELECT
      dt,
      user_id,
      push_name,
      sent_count,
      click_count,
      platform,
      user_type,
    FROM favie_dw.dws_gem_operation_push_message_metrics_inc_1d_function(dt_param);
END