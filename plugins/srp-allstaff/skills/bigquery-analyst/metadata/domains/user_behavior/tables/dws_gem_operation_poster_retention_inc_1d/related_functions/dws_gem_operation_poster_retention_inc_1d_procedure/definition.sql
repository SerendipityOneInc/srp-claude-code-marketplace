BEGIN
  -- 1) 删除当天旧分区数据（目标分区是 dt = dt_param - 1）
  DELETE FROM favie_dw.dws_gem_operation_poster_retention_inc_1d
  WHERE dt = dt_param;

  -- 2) 插入当天结果（字段顺序与表结构完全一致）
  INSERT INTO favie_dw.dws_gem_operation_poster_retention_inc_1d (
    dt,
    user_media_source,
    is_internal_user,
    user_type,
    user_tenure_type,
    login_type,
    platform,
    app_version,
    active_users,
    d1_retained_users,
    d7_retained_users,
    lt7,
    active_post_users,
    passive_post_users,
    no_post_users,
    active_post_d1_retained,
    passive_post_d1_retained,
    no_post_d1_retained,
    active_post_d7_retained,
    passive_post_d7_retained,
    no_post_d7_retained,
    active_post_lt7,
    passive_post_lt7,
    no_post_lt7
  )
  SELECT
    dt,
    user_media_source,
    is_internal_user,
    user_type,
    user_tenure_type,
    login_type,
    platform,
    app_version,
    active_users,
    d1_retained_users,
    d7_retained_users,
    lt7,
    active_post_users,
    passive_post_users,
    no_post_users,
    active_post_d1_retained,
    passive_post_d1_retained,
    no_post_d1_retained,
    active_post_d7_retained,
    passive_post_d7_retained,
    no_post_d7_retained,
    active_post_lt7,
    passive_post_lt7,
    no_post_lt7
  FROM favie_dw.dws_gem_operation_poster_retention_inc_1d_function(dt_param);
END