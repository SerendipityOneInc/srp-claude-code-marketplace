# rpt_favie_gensmo_tryon_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-11-12
**最后更新**: 2025-11-12

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d` (rpt_gensmo_user_active_metrics_inc_1d)

---

## 💻 函数定义

```sql
with user_dau as (
    select 
      dt,
      platform,
      app_version,
      country_name,
      user_login_type,
      user_tenure_type,
      user_group,
      SUM(active_user_d1_cnt) as active_user_d1_cnt
    from srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
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

      sum(tryon_trigger_cnt) as tryon_trigger_cnt,
      count(distinct tryon_trigger_device_id) as tryon_trigger_user_cnt,

      sum(tryon_request_cnt) as tryon_request_cnt,
      count(distinct tryon_request_device_id) as tryon_request_user_cnt,

      sum(tryon_complete_succeed_task_cnt) as tryon_complete_succeed_task_cnt,
      count(distinct tryon_complete_succeed_device_id) as tryon_complete_succeed_user_cnt,

      sum(tryon_complete_fail_task_cnt) as tryon_complete_fail_task_cnt,
      count(distinct tryon_complete_fail_device_id) as tryon_complete_fail_user_cnt,

      count(distinct coalesce(tryon_complete_succeed_device_id, tryon_complete_fail_device_id)) as tryon_complete_user_cnt,

      sum(tryon_load_succeed_task_cnt) as tryon_load_succeed_task_cnt,
      count(distinct tryon_load_succeed_device_id) as tryon_load_succeed_user_cnt,

      sum(tryon_load_fail_task_cnt) as tryon_load_fail_task_cnt,
      count(distinct tryon_load_fail_device_id) as tryon_load_fail_user_cnt,

      sum(tryon_view_detail_task_cnt) as tryon_view_detail_task_cnt,
      count(distinct tryon_view_detail_device_id) as tryon_view_detail_user_cnt

    from favie_dw.dws_favie_gensmo_tryon_metric_inc_1d 
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

  metric_with_dau as (
    select 
      coalesce(t1.dt,t2.dt) as dt,

      --user info
      coalesce(t1.platform,t2.platform) as platform,
      coalesce(t1.app_version,t2.app_version) as app_version,
      coalesce(t1.country_name,t2.country_name) as country_name,
      coalesce(t1.user_login_type,t2.user_login_type) as user_login_type,
      coalesce(t1.user_tenure_type,t2.user_tenure_type) as user_tenure_type,
      coalesce(t1.user_group,t2.user_group) as user_group,

      --app
      t2.active_user_d1_cnt as active_user_d1_cnt,

      --tryon intention
      t1.tryon_trigger_cnt as tryon_trigger_cnt,
      t1.tryon_trigger_user_cnt as tryon_trigger_user_cnt,

      t1.tryon_request_cnt as tryon_request_cnt,
      t1.tryon_request_user_cnt as tryon_request_user_cnt,

      t1.tryon_complete_succeed_task_cnt as tryon_complete_succeed_task_cnt,
      t1.tryon_complete_succeed_user_cnt as tryon_complete_succeed_user_cnt,

      t1.tryon_complete_fail_task_cnt as tryon_complete_fail_task_cnt,
      t1.tryon_complete_fail_user_cnt as tryon_complete_fail_user_cnt,

      t1.tryon_complete_user_cnt as tryon_complete_user_cnt,
      
      t1.tryon_load_succeed_task_cnt as tryon_load_succeed_task_cnt,
      t1.tryon_load_succeed_user_cnt as tryon_load_succeed_user_cnt,

      t1.tryon_load_fail_task_cnt as tryon_load_fail_task_cnt,
      t1.tryon_load_fail_user_cnt as tryon_load_fail_user_cnt,

      t1.tryon_view_detail_task_cnt as tryon_view_detail_task_cnt,
      t1.tryon_view_detail_user_cnt as tryon_view_detail_user_cnt
    from metric_with_uv t1 full outer join user_dau t2
    on t1.dt = t2.dt
      and t1.platform = t2.platform
      and t1.app_version = t2.app_version
      and t1.country_name = t2.country_name
      and t1.user_login_type = t2.user_login_type
      and t1.user_tenure_type = t2.user_tenure_type
      and t1.user_group = t2.user_group
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

    --app
    active_user_d1_cnt,

    --tryon intention
    tryon_trigger_cnt,
    tryon_trigger_user_cnt,
    tryon_request_cnt,
    tryon_request_user_cnt,
    tryon_complete_succeed_task_cnt,
    tryon_complete_succeed_user_cnt,
    tryon_complete_fail_task_cnt,
    tryon_complete_fail_user_cnt,
    tryon_complete_user_cnt,
    tryon_load_succeed_task_cnt,
    tryon_load_succeed_user_cnt,
    tryon_load_fail_task_cnt,
    tryon_load_fail_user_cnt,
    tryon_view_detail_task_cnt,
    tryon_view_detail_user_cnt
  FROM metric_with_dau
```

---

**文档生成**: 2026-01-30 13:39:08
**扫描工具**: scan_functions.py
