# dws_faive_gensmo_membership_points_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_faive_gensmo_membership_points_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2026-01-04
**最后更新**: 2026-01-04

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
with base_process_node_data as (
    select
      dt,

      --user info
      device_id,

      --process info
      process_node_name,
      process_node_type,
      process_node_point_type,
      process_node_status,
      process_node_id,
      process_node_points
    from `favie_dw.dwd_favie_gensmo_membership_process_node_inc_1d`
    where 1=1
      and dt = dt_param
  ),

  base_device_metric as (
    select
      dt,

      --user info
      device_id,

      --earn points
      case when countif(process_node_name = 'earn') > 0 then 1 else 0 end as earn_points_user_cnt,
      countif(process_node_name = 'earn') as earn_points_task_cnt,
      coalesce(sum(if(process_node_name = 'earn', process_node_points, 0)), 0) as earn_points_points_amt,

      --earn points not checkin
      case
        when countif(
          process_node_name = 'earn'
          and lower(process_node_type) not like '%checkin%'
        ) > 0 then 1
        else 0
      end as earn_points_not_checkin_user_cnt,
      count(distinct if(
        process_node_name = 'earn'
        and lower(process_node_type) not like '%checkin%',
        process_node_id,
        null
      )) as earn_points_not_checkin_task_cnt,
      coalesce(sum(if(
        process_node_name = 'earn'
        and lower(process_node_type) not like '%checkin%',
        process_node_points,
        0
      )), 0) as earn_points_not_checkin_points_amt,

      --earn points transaction
      case
        when countif(
          process_node_name = 'earn'
          and lower(process_node_type) like '%transaction%'
        ) > 0 then 1
        else 0
      end as earn_points_transaction_user_cnt,
      count(distinct if(
        process_node_name = 'earn'
        and lower(process_node_type) like '%transaction%',
        process_node_id,
        null
      )) as earn_points_transaction_task_cnt,
      coalesce(sum(if(
        process_node_name = 'earn'
        and lower(process_node_type) like '%transaction%',
        process_node_points,
        0
      )), 0) as earn_points_transaction_points_amt,

      --consume points (only consumed)
      case when countif(process_node_name = 'consume' and process_node_status = 'consumed') > 0 then 1 else 0 end as consume_points_user_cnt,
      countif(process_node_name = 'consume' and process_node_status = 'consumed') as consume_points_task_cnt,
      coalesce(sum(if(process_node_name = 'consume' and process_node_status = 'consumed', process_node_points, 0)), 0) as consume_points_points_amt,

      --hit limit
      case when countif(process_node_name = 'hit_limit') > 0 then 1 else 0 end as hit_limit_user_cnt,

      --daily points (process_point_type = daily_points)
      coalesce(
        sum(
          if(
            process_node_point_type = 'daily_points',
            process_node_points,
            0
          )
        ),
        0
      ) as daily_points_amt
    from base_process_node_data
    group by
      dt,
      device_id
  ),

  base_dws_data as (
    select
      dt,

      --user info
      device_id,

      --earn points
      earn_points_user_cnt,
      earn_points_task_cnt,
      earn_points_points_amt,

      earn_points_not_checkin_user_cnt,
      earn_points_not_checkin_task_cnt,
      earn_points_not_checkin_points_amt,

      earn_points_transaction_user_cnt,
      earn_points_transaction_task_cnt,
      earn_points_transaction_points_amt,

      --consume points
      consume_points_user_cnt,
      consume_points_task_cnt,
      consume_points_points_amt,

      --derived metrics
      (earn_points_points_amt - consume_points_points_amt) as net_points_change,

      case
        when consume_points_points_amt >= 13 then 1
        else 0
      end as consume_points_ge_task_claimed_user_cnt,

      case
        when consume_points_points_amt >= 10 then 1
        else 0
      end as consume_points_ge_checkin_user_cnt,

      hit_limit_user_cnt,

      greatest(daily_points_amt - consume_points_points_amt, 0) as points_expired
    from base_device_metric
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

      --earn points
      t1.earn_points_user_cnt,
      t1.earn_points_task_cnt,
      t1.earn_points_points_amt,

      t1.earn_points_not_checkin_user_cnt,
      t1.earn_points_not_checkin_task_cnt,
      t1.earn_points_not_checkin_points_amt,

      t1.earn_points_transaction_user_cnt,
      t1.earn_points_transaction_task_cnt,
      t1.earn_points_transaction_points_amt,

      --consume points
      t1.consume_points_user_cnt,
      t1.consume_points_task_cnt,
      t1.consume_points_points_amt,

      --derived metrics
      t1.net_points_change,
      t1.consume_points_ge_task_claimed_user_cnt,
      t1.consume_points_ge_checkin_user_cnt,
      t1.hit_limit_user_cnt,
      t1.points_expired
    from base_dws_data t1
    left outer join user_info_with_group t2
      on t1.device_id = t2.device_id
    where t2.user_group is not null
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
    device_id,

    --earn points
    earn_points_user_cnt,
    earn_points_task_cnt,
    earn_points_points_amt,

    earn_points_not_checkin_user_cnt,
    earn_points_not_checkin_task_cnt,
    earn_points_not_checkin_points_amt,

    earn_points_transaction_user_cnt,
    earn_points_transaction_task_cnt,
    earn_points_transaction_points_amt,

    --consume points
    consume_points_user_cnt,
    consume_points_task_cnt,
    consume_points_points_amt,

    --derived metrics
    net_points_change,
    consume_points_ge_task_claimed_user_cnt,
    consume_points_ge_checkin_user_cnt,
    hit_limit_user_cnt,
    points_expired
  from base_dws_data_with_user
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
