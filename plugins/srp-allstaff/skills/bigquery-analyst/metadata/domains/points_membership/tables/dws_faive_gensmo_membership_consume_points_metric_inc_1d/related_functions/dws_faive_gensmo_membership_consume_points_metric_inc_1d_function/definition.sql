with base_process_node_data AS (
    SELECT
      dt,

      --user info
      device_id,

      --consume dims
      process_node_type as consume_type,

      --for metrics
      process_node_id,
      process_node_points
    FROM `favie_dw.dwd_favie_gensmo_membership_process_node_inc_1d`
    where 1=1
      and dt = dt_param
      and process_node_name = 'consume'
      and process_node_status = 'consumed'
  ),

  base_dws_data AS (
    SELECT
      dt,

      --user info
      device_id,

      --consume dims
      consume_type,

      --metrics
      1 as consume_points_user_cnt,
      count(process_node_id) as consume_ponits_task_cnt,
      coalesce(sum(process_node_points), 0) as consume_ponits_points_amt
    FROM base_process_node_data
    GROUP BY
      dt,
      device_id,
      consume_type
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

      --consume dims
      t1.consume_type,

      --metrics
      t1.consume_points_user_cnt,
      t1.consume_ponits_task_cnt,
      t1.consume_ponits_points_amt
    from base_dws_data t1
    left outer join user_info_with_group t2
      on t1.device_id = t2.device_id
    where t2.user_group is not null
  )

  SELECT
    dt,

    --user info
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group,
    device_id,

    --consume dims
    consume_type,

    --metrics
    consume_points_user_cnt,
    consume_ponits_task_cnt,
    consume_ponits_points_amt
  FROM base_dws_data_with_user