BEGIN
    -- 1) 先删掉前一天的数据
    DELETE FROM favie_dw.dws_gem_operation_banner_detail_inc_1d
    WHERE dt = dt_param;

    -- 2) 插入最新数据
    INSERT INTO favie_dw.dws_gem_operation_banner_detail_inc_1d
    (
      dt,
      item_name,
      user_media_source,
      is_internal_user,
      user_type,
      user_tenure_type,
      login_type,
      platform,
      app_version,
      banner_view_pv,
      banner_view_uv,
      banner_click_pv,
      banner_click_uv
    )
    SELECT
      dt,
      item_name,
      user_media_source,
      is_internal_user,
      user_type,
      user_tenure_type,
      login_type,
      platform,
      app_version,
      banner_view_pv,
      banner_view_uv,
      banner_click_pv,
      banner_click_uv
    FROM favie_dw.dws_gem_operation_banner_detail_inc_1d_function(dt_param);
END