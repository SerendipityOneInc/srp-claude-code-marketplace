with user_dau as (
    select
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      sum(active_user_1d_cnt) as active_user_1d_cnt
    from favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
    where dt is not null and dt = dt_param
    group by
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group
  ),

  user_login as (
    select
      dt,
      platform,
      app_version,
      country_name,
      user_tenure_type,
      user_group,
      sum(active_user_1d_cnt) as login_user_1d_cnt
    from favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
    where dt is not null and dt = dt_param
      and user_login_type = 'login'
    group by
      dt,
      platform,
      app_version,
      country_name,
      user_tenure_type,
      user_group
  ),

  metric_with_uv as (
    select
      dt,

      --user info
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,

      -- points metrics
      sum(earn_points_user_cnt) as earn_points_user_cnt,
      sum(earn_points_task_cnt) as earn_points_task_cnt,
      sum(earn_points_points_amt) as earn_points_points_amt,

      sum(earn_points_not_checkin_user_cnt) as earn_points_not_checkin_user_cnt,
      sum(earn_points_not_checkin_task_cnt) as earn_points_not_checkin_task_cnt,
      sum(earn_points_not_checkin_points_amt) as earn_points_not_checkin_points_amt,

      sum(earn_points_transaction_user_cnt) as earn_points_transaction_user_cnt,
      sum(earn_points_transaction_task_cnt) as earn_points_transaction_task_cnt,
      sum(earn_points_transaction_points_amt) as earn_points_transaction_points_amt,

      sum(consume_points_user_cnt) as consume_points_user_cnt,
      sum(consume_points_task_cnt) as consume_points_task_cnt,
      sum(consume_points_points_amt) as consume_points_points_amt,

      sum(net_points_change) as net_points_change,

      sum(consume_points_ge_task_claimed_user_cnt) as consume_points_ge_task_claimed_user_cnt,
      sum(consume_points_ge_checkin_user_cnt) as consume_points_ge_checkin_user_cnt,

      sum(hit_limit_user_cnt) as hit_limit_user_cnt,

      sum(points_expired) as points_expired
    from favie_dw.dws_faive_gensmo_membership_points_metric_inc_1d
    where dt is not null and dt = dt_param
    group by
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group
  ),

  metric_with_dau_login as (
    select
      t1.dt,

      --user info
      t1.platform,
      t1.app_version,
      t1.country_name,
      t1.user_login_type,
      t1.user_tenure_type,
      t1.user_group,

      --dau & login
      coalesce(t2.active_user_1d_cnt, 0) as active_user_1d_cnt,
      coalesce(t3.login_user_1d_cnt, 0) as login_user_1d_cnt,

      --points metrics
      t1.earn_points_user_cnt,
      t1.earn_points_task_cnt,
      t1.earn_points_points_amt,

      t1.earn_points_not_checkin_user_cnt,
      t1.earn_points_not_checkin_task_cnt,
      t1.earn_points_not_checkin_points_amt,

      t1.earn_points_transaction_user_cnt,
      t1.earn_points_transaction_task_cnt,
      t1.earn_points_transaction_points_amt,

      t1.consume_points_user_cnt,
      t1.consume_points_task_cnt,
      t1.consume_points_points_amt,

      t1.net_points_change,

      t1.consume_points_ge_task_claimed_user_cnt,
      t1.consume_points_ge_checkin_user_cnt,

      t1.hit_limit_user_cnt,

      t1.points_expired
    from metric_with_uv t1
    left outer join user_dau t2
      on t1.dt = t2.dt
     and t1.platform = t2.platform
     and t1.app_version = t2.app_version
     and t1.country_name = t2.country_name
     and t1.user_login_type = t2.user_login_type
     and t1.user_tenure_type = t2.user_tenure_type
     and t1.user_group = t2.user_group
    left outer join user_login t3
      on t1.dt = t3.dt
     and t1.platform = t3.platform
     and t1.app_version = t3.app_version
     and t1.country_name = t3.country_name
     and t1.user_tenure_type = t3.user_tenure_type
     and t1.user_group = t3.user_group
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

    --dau & login
    active_user_1d_cnt,
    login_user_1d_cnt,

    --points metrics
    earn_points_user_cnt,
    earn_points_task_cnt,
    earn_points_points_amt,

    earn_points_not_checkin_user_cnt,
    earn_points_not_checkin_task_cnt,
    earn_points_not_checkin_points_amt,

    earn_points_transaction_user_cnt,
    earn_points_transaction_task_cnt,
    earn_points_transaction_points_amt,

    consume_points_user_cnt,
    consume_points_task_cnt,
    consume_points_points_amt,

    net_points_change,

    consume_points_ge_task_claimed_user_cnt,
    consume_points_ge_checkin_user_cnt,

    hit_limit_user_cnt,

    points_expired
  from metric_with_dau_login