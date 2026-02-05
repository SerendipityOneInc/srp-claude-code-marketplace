with base_process_node_data AS (
    SELECT
      dt,

      --user info
      device_id,

      --earn dims
      process_node_type as earn_type,

      process_node_point_type as earn_point_type,

      case
        when earn_group = 'hit_limit' then 'hit_limit'
        else 'not_hit_limit'
      end as hit_limit_group,

      --for metrics
      process_node_id,
      process_node_points
    FROM `favie_dw.dwd_favie_gensmo_membership_process_node_inc_1d`
    where 1=1
      and dt = dt_param
      and process_node_name = 'earn'
  ),

  base_dws_data AS (
    SELECT
      dt,

      --user info
      device_id,

      --earn dims
      earn_type,
      earn_point_type,
      hit_limit_group,

      --metrics
      1 as earn_points_user_cnt,
      count(process_node_id) as earn_ponits_task_cnt,
      coalesce(sum(process_node_points), 0) as earn_ponits_points_amt
    FROM base_process_node_data
    GROUP BY
      dt,
      device_id,
      earn_type,
      earn_point_type,
      hit_limit_group
  ),

  user_info_with_group as (
    select
      device_id,
      user_tenure_type,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_group
    from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param, dt_param)
  ),

  base_dws_data_with_user as (
    select
      t1.dt,

      --user info
      t2.platform,
      t2.app_version,
      t2.country_name,
      t2.user_login_type,
      t2.user_tenure_type,
      t2.user_group,
      t1.device_id,

      --earn dims
      t1.earn_type,
      t1.earn_point_type,
      t1.hit_limit_group,

      --metrics
      t1.earn_points_user_cnt,
      t1.earn_ponits_task_cnt,
      t1.earn_ponits_points_amt
    from base_dws_data t1
    left outer join user_info_with_group t2
    on t1.device_id = t2.device_id
    where t2.user_group is not null
  )

  SELECT
    dt,

    --用户信息
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    device_id,

    --积分获取维度
    earn_type,
    earn_point_type,
    hit_limit_group,

    --指标
    earn_points_user_cnt,
    earn_ponits_task_cnt,
    earn_ponits_points_amt
  FROM base_dws_data_with_user