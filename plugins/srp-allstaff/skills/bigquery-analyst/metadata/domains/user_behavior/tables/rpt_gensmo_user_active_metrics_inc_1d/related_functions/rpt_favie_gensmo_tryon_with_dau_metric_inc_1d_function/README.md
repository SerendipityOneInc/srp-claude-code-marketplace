# rpt_favie_gensmo_tryon_with_dau_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d_function`
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

      --home
      sum(home_pv_cnt) as home_pv_cnt,
      count(distinct home_device_id) as home_user_cnt,

      --tryon intention
      sum(tryon_intention_cnt) as tryon_intention_cnt,
      count(distinct tryon_intention_device_id) as tryon_intention_user_cnt,

      --tryon select panel
      sum(tryon_select_panel_pv_cnt) as tryon_select_panel_pv_cnt,
      sum(tryon_select_panel_confirm_click_cnt) as tryon_select_panel_confirm_click_cnt,
      count(distinct tryon_select_panel_device_id) as tryon_select_panel_user_cnt,

      --tryon gen action
      sum(tryon_gen_action_cnt) as tryon_gen_action_cnt,
      count(distinct tryon_gen_action_device_id) as tryon_gen_action_user_cnt,
      sum(tryon_gen_action_cnt_2_0) as tryon_gen_action_cnt_2_0,
      count(distinct tryon_gen_action_device_id_2_0) as tryon_gen_action_user_cnt_2_0,

      --tryon complete
      sum(tryon_complete_cnt) as tryon_complete_cnt,
      count(distinct tryon_complete_device_id) as tryon_complete_user_cnt,

      sum(tryon_channel_click_cnt) as tryon_channel_click_cnt,
      count(distinct tryon_channel_click_device_id) as tryon_channel_click_user_cnt,

      sum(tryon_complete_detail_task_cnt) as tryon_complete_detail_task_cnt,
      count(distinct tryon_complete_detail_device_id) as tryon_complete_detail_user_cnt,

      sum(tryon_gen_panel_pv_cnt) as tryon_gen_panel_pv_cnt,
      sum(tryon_gen_panel_click_cnt) as tryon_gen_panel_click_cnt,
      count(distinct tryon_gen_panel_device_id) as tryon_gen_panel_user_cnt,

      --tryon change scene
      sum(tryon_change_scene_intention_cnt) as tryon_change_scene_intention_cnt,
      count(distinct tryon_change_scene_intention_device_id) as tryon_change_scene_intention_user_cnt,
      sum(tryon_change_scene_gen_cnt) as tryon_change_scene_gen_cnt,
      count(distinct tryon_change_scene_gen_device_id) as tryon_change_scene_gen_user_cnt,
      sum(tryon_change_scene_browse_cnt) as tryon_change_scene_browse_cnt,
      count(distinct tryon_change_scene_browse_device_id) as tryon_change_scene_browse_user_cnt,

      sum(tryon_load_fail_cnt) as tryon_load_fail_cnt,
      count(distinct tryon_load_fail_device_id) as tryon_load_fail_user_cnt

    from favie_dw.dws_favie_gensmo_tryon_by_event_metric_inc_1d 
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
      coalesce(t1.platform,t2.platform,t3.platform) as platform,
      coalesce(t1.app_version,t2.app_version,t3.app_version) as app_version,
      coalesce(t1.country_name,t2.country_name,t3.country_name) as country_name,
      coalesce(t1.user_login_type,t2.user_login_type,t3.user_login_type) as user_login_type,
      coalesce(t1.user_tenure_type,t2.user_tenure_type,t3.user_tenure_type) as user_tenure_type,
      coalesce(t1.user_group,t2.user_group,t3.user_group) as user_group,

      --app
      t2.active_user_d1_cnt as active_user_d1_cnt,

      --home
      t1.home_pv_cnt as home_pv_cnt,
      t1.home_user_cnt as home_user_cnt,

      --tryon intention
      t1.tryon_intention_cnt as tryon_intention_cnt,
      t1.tryon_intention_user_cnt as tryon_intention_user_cnt,

      --tryon select panel
      t1.tryon_select_panel_pv_cnt as tryon_select_panel_pv_cnt,
      t1.tryon_select_panel_confirm_click_cnt as tryon_select_panel_confirm_click_cnt,
      t1.tryon_select_panel_user_cnt as tryon_select_panel_user_cnt,

      --tryon gen action
      t1.tryon_gen_action_cnt as tryon_gen_action_cnt,
      t1.tryon_gen_action_user_cnt as tryon_gen_action_user_cnt,
      t1.tryon_gen_action_cnt_2_0 as tryon_gen_action_cnt_2_0,
      t1.tryon_gen_action_user_cnt_2_0 as tryon_gen_action_user_cnt_2_0,

      --tryon server complete
      t3.tryon_server_complete_task_cnt as tryon_server_complete_task_cnt,
      t3.tryon_server_complete_user_cnt as tryon_server_complete_user_cnt,

      --tryon complete
      t1.tryon_complete_cnt as tryon_complete_cnt,
      t1.tryon_complete_user_cnt as tryon_complete_user_cnt,
      t1.tryon_channel_click_cnt as tryon_channel_click_cnt,
      t1.tryon_channel_click_user_cnt as tryon_channel_click_user_cnt,
      t1.tryon_complete_detail_task_cnt as tryon_complete_detail_task_cnt,
      t1.tryon_complete_detail_user_cnt as tryon_complete_detail_user_cnt,
      t1.tryon_gen_panel_pv_cnt as tryon_gen_panel_pv_cnt,
      t1.tryon_gen_panel_click_cnt as tryon_gen_panel_click_cnt,
      t1.tryon_gen_panel_user_cnt as tryon_gen_panel_user_cnt,

      --tryon change scene
      t1.tryon_change_scene_intention_cnt as tryon_change_scene_intention_cnt,
      t1.tryon_change_scene_intention_user_cnt as tryon_change_scene_intention_user_cnt,
      t1.tryon_change_scene_gen_cnt as tryon_change_scene_gen_cnt,
      t1.tryon_change_scene_gen_user_cnt as tryon_change_scene_gen_user_cnt,
      t1.tryon_change_scene_browse_cnt as tryon_change_scene_browse_cnt,
      t1.tryon_change_scene_browse_user_cnt as tryon_change_scene_browse_user_cnt,

      t1.tryon_load_fail_cnt as tryon_load_fail_cnt,
      t1.tryon_load_fail_user_cnt as tryon_load_fail_user_cnt

    from metric_with_uv t1 full outer join user_dau t2
    on t1.dt = t2.dt
      and t1.platform = t2.platform
      and t1.app_version = t2.app_version
      and t1.country_name = t2.country_name
      and t1.user_login_type = t2.user_login_type
      and t1.user_tenure_type = t2.user_tenure_type
      and t1.user_group = t2.user_group
    full outer join favie_rpt.rpt_favie_gensmo_tryon_by_server_metric_inc_1d_function(dt_param) t3
    on t1.dt = t3.dt
      and t1.platform = t3.platform
      and t1.app_version = t3.app_version
      and t1.country_name = t3.country_name
      and t1.user_login_type = t3.user_login_type
      and t1.user_tenure_type = t3.user_tenure_type
      and t1.user_group = t3.user_group
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

    --home
    home_pv_cnt,
    home_user_cnt,

    --tryon intention
    tryon_intention_cnt,
    tryon_intention_user_cnt,

    --tryon select panel
    tryon_select_panel_pv_cnt,
    tryon_select_panel_confirm_click_cnt,
    tryon_select_panel_user_cnt,

    --tryon gen action
    tryon_gen_action_cnt,
    tryon_gen_action_user_cnt,
    tryon_gen_action_cnt_2_0,
    tryon_gen_action_user_cnt_2_0,

    --tryon server complete
    tryon_server_complete_task_cnt,
    tryon_server_complete_user_cnt,

    --tryon complete
    tryon_complete_cnt,
    tryon_complete_user_cnt,
    tryon_channel_click_cnt,
    tryon_channel_click_user_cnt,
    tryon_complete_detail_task_cnt,
    tryon_complete_detail_user_cnt,
    tryon_gen_panel_pv_cnt,
    tryon_gen_panel_click_cnt,
    tryon_gen_panel_user_cnt,

    --tryon change scene
    tryon_change_scene_intention_cnt,
    tryon_change_scene_intention_user_cnt,
    tryon_change_scene_gen_cnt,
    tryon_change_scene_gen_user_cnt,
    tryon_change_scene_browse_cnt,
    tryon_change_scene_browse_user_cnt,

    tryon_load_fail_cnt,
    tryon_load_fail_user_cnt
  FROM metric_with_dau
```

---

**文档生成**: 2026-01-30 13:39:10
**扫描工具**: scan_functions.py
