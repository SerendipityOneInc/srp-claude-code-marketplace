# rpt_favie_gensmo_search_with_dau_metric_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-09-10
**最后更新**: 2025-09-10

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
      active_user_d1_cnt
    from srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d
    where dt is not null and dt = dt_param
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

      --collage intention
      sum(collage_intention_cnt) as collage_intention_cnt,
      count(distinct collage_intention_device_id) as collage_intention_user_cnt,

      --collage select panel
      sum(search_boot_panel_pv_cnt) as search_boot_panel_pv_cnt,
      sum(search_boot_panel_generate_click_cnt) as search_boot_panel_generate_click_cnt,
      count(distinct search_boot_panel_device_id) as search_boot_panel_user_cnt,

      --collage gen action
      sum(collage_gen_action_cnt) as collage_gen_action_cnt,
      count(distinct collage_gen_action_device_id) as collage_gen_action_user_cnt,
      sum(collage_gen_action_cnt_2_0) as collage_gen_action_cnt_2_0,
      count(distinct collage_gen_action_device_id_2_0) as collage_gen_action_user_cnt_2_0,

      --collage complete
      sum(collage_complete_cnt) as collage_complete_cnt,
      count(distinct collage_complete_device_id) as collage_complete_user_cnt,

      sum(collage_channel_click_cnt) as collage_channel_click_cnt,
      count(distinct collage_channel_click_device_id) as collage_channel_click_user_cnt,

      sum(collage_complete_detail_task_cnt) as collage_complete_detail_task_cnt,
      count(distinct collage_complete_detail_device_id) as collage_complete_detail_user_cnt,

      sum(collage_gen_panel_pv_cnt) as collage_gen_panel_pv_cnt,
      sum(collage_gen_panel_click_cnt) as collage_gen_panel_click_cnt,
      count(distinct collage_gen_panel_device_id) as collage_gen_panel_user_cnt,
      --search category
      sum(search_result_product_click_cnt) as search_result_product_click_cnt,
      sum(search_result_positive_cnt) as search_result_positive_cnt,
      sum(channel_collage_click_cnt) as channel_collage_click_cnt,

      --channel
      sum(channel_screen_cnt) as channel_screen_cnt,
      count(distinct channel_device_id) as channel_user_cnt

    from favie_dw.dws_favie_gensmo_search_by_event_metric_inc_1d 
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

      --home
      t1.home_pv_cnt as home_pv_cnt,
      t1.home_user_cnt as home_user_cnt,

      --collage intention
      t1.collage_intention_cnt as collage_intention_cnt,
      t1.collage_intention_user_cnt as collage_intention_user_cnt,

      --search boot panel
      t1.search_boot_panel_pv_cnt as search_boot_panel_pv_cnt,
      t1.search_boot_panel_generate_click_cnt as search_boot_panel_generate_click_cnt,
      t1.search_boot_panel_user_cnt as search_boot_panel_user_cnt,

      --collage gen action
      t1.collage_gen_action_cnt as collage_gen_action_cnt,
      t1.collage_gen_action_user_cnt as collage_gen_action_user_cnt,
      t1.collage_gen_action_cnt_2_0 as collage_gen_action_cnt_2_0,
      t1.collage_gen_action_user_cnt_2_0 as collage_gen_action_user_cnt_2_0,

      --collage server complete
      t3.collage_server_complete_task_cnt as collage_server_complete_task_cnt,
      t3.collage_server_complete_user_cnt as collage_server_complete_user_cnt,

      --collage complete
      t1.collage_complete_cnt as collage_complete_cnt,
      t1.collage_complete_user_cnt as collage_complete_user_cnt,
      t1.collage_channel_click_cnt as collage_channel_click_cnt,
      t1.collage_channel_click_user_cnt as collage_channel_click_user_cnt,
      t1.collage_complete_detail_task_cnt as collage_complete_detail_task_cnt,
      t1.collage_complete_detail_user_cnt as collage_complete_detail_user_cnt,
      t1.collage_gen_panel_pv_cnt as collage_gen_panel_pv_cnt,
      t1.collage_gen_panel_click_cnt as collage_gen_panel_click_cnt,
      t1.collage_gen_panel_user_cnt as collage_gen_panel_user_cnt,
      t1.search_result_product_click_cnt as search_result_product_click_cnt,
      t1.search_result_positive_cnt as search_result_positive_cnt,
      t1.channel_collage_click_cnt as channel_collage_click_cnt,
      t1.channel_screen_cnt as channel_screen_cnt,
      t1.channel_user_cnt as channel_user_cnt

    from metric_with_uv t1 full outer join user_dau t2
    on t1.dt = t2.dt
      and t1.platform = t2.platform
      and t1.app_version = t2.app_version
      and t1.country_name = t2.country_name
      and t1.user_login_type = t2.user_login_type
      and t1.user_tenure_type = t2.user_tenure_type
      and t1.user_group = t2.user_group
    full outer join favie_rpt.rpt_favie_gensmo_search_by_server_metric_inc_1d_function(dt_param) t3
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

    --collage intention
    collage_intention_cnt,
    collage_intention_user_cnt,

    --search boot panel
    search_boot_panel_pv_cnt,
    search_boot_panel_generate_click_cnt,
    search_boot_panel_user_cnt,

    --collage gen action
    collage_gen_action_cnt,
    collage_gen_action_user_cnt,
    collage_gen_action_cnt_2_0,
    collage_gen_action_user_cnt_2_0,

    --collage server complete
    collage_server_complete_task_cnt,
    collage_server_complete_user_cnt,

    --collage complete
    collage_complete_cnt,
    collage_complete_user_cnt,
    collage_channel_click_cnt,
    collage_channel_click_user_cnt,
    collage_complete_detail_task_cnt,
    collage_complete_detail_user_cnt,
    collage_gen_panel_pv_cnt,
    collage_gen_panel_click_cnt,
    collage_gen_panel_user_cnt,
    search_result_product_click_cnt,
    search_result_positive_cnt,
    channel_collage_click_cnt,
    channel_screen_cnt,
    channel_user_cnt

  FROM metric_with_dau
```

---

**文档生成**: 2026-01-30 13:39:04
**扫描工具**: scan_functions.py
