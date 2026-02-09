BEGIN
    -- 先删除当天的数据，确保幂等性
    DELETE FROM `srpdev-7b1d3.favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d`
    WHERE dt = dt_param;

    -- 插入最新数据
    INSERT INTO `srpdev-7b1d3.favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d`
    (
      dt,
      user_id,
      device_id,
      event_item_item_id,
      count_hashtag,
      user_group,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type
    )
    SELECT
      dt,
      user_id,
      device_id,
      event_item_item_id,
      count_hashtag,
      user_group,
      country_name,
      platform,
      app_version,
      user_login_type,
      user_tenure_type
    FROM `favie_dw.dws_gem_operation_hashtag_message_metrics_inc_1d_function`(dt_param);
END