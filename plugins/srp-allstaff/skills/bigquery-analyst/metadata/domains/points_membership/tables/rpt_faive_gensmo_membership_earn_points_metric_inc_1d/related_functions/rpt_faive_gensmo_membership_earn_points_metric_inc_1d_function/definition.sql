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

      -- earn dims
      earn_type,
      earn_point_type,
      hit_limit_group,

      -- metrics
      sum(earn_points_user_cnt) as earn_points_user_cnt,
      sum(earn_ponits_task_cnt) as earn_ponits_task_cnt,
      sum(earn_ponits_points_amt) as earn_ponits_points_amt
    from favie_dw.dws_faive_gensmo_membership_earn_points_metric_inc_1d
    where dt is not null and dt = dt_param
    group by
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      earn_type,
      earn_point_type,
      hit_limit_group
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

    -- earn dims
    earn_type,
    earn_point_type,
    hit_limit_group,

    -- metrics
    earn_points_user_cnt,
    earn_ponits_task_cnt,
    earn_ponits_points_amt
  from metric_with_uv