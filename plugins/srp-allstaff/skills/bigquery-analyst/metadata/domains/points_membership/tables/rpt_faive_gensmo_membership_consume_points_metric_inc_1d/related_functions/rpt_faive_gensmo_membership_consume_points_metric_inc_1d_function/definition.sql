with metric_with_uv as (
    select
      dt,

      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      --consume dims
      consume_type,

      --metrics
      sum(consume_points_user_cnt) as consume_points_user_cnt,
      sum(consume_ponits_task_cnt) as consume_ponits_task_cnt,
      sum(consume_ponits_points_amt) as consume_ponits_points_amt
    from favie_dw.dws_faive_gensmo_membership_consume_points_metric_inc_1d
    where dt is not null and dt = dt_param
    group by
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      consume_type
  )

  select
    dt,

    --user info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,

    --consume dims
    consume_type,

    --metrics
    consume_points_user_cnt,
    consume_ponits_task_cnt,
    consume_ponits_points_amt
  from metric_with_uv