# rpt_favie_gensmo_tryon_bysource_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_bysource_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-11
**最后更新**: 2025-07-11

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
begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_tryon_bysource_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_tryon_bysource_metric_inc_1d (
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,

        cal_pre_refer,
        cal_pre_refer_ap_name,
        cal_pre_event_source,

        task_model,
        task_type,

        home_pv_cnt,
        home_device_id,

        tryon_pv_cnt,
        tryon_device_id,

        tryon_select_panel_pv_cnt,
        tryon_select_panel_confirm_click_cnt,
        tryon_select_panel_device_id,

        tryon_gen_panel_pv_cnt,
        tryon_gen_panel_pv_cnt_2_0,
        tryon_gen_action_cnt,
        tryon_gen_panel_click_cnt,
        tryon_gen_panel_click_action_through_rate,
        tryon_gen_panel_click_pv_through_rate,
        tryon_gen_device_id,

        tryon_complete_pv_cnt,
        tryon_complete_device_id
    )
    SELECT
        dt,
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,
        device_id,

        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        event_source,

        cal_pre_refer,
        cal_pre_refer_ap_name,
        cal_pre_event_source,

        task_model,
        task_type,

        home_pv_cnt,
        home_device_id,

        tryon_pv_cnt,
        tryon_device_id,

        tryon_select_panel_pv_cnt,
        tryon_select_panel_confirm_click_cnt,
        tryon_select_panel_device_id,

        tryon_gen_panel_pv_cnt,
        tryon_gen_panel_pv_cnt_2_0,
        tryon_gen_action_cnt,
        tryon_gen_panel_click_cnt,
        tryon_gen_panel_click_action_through_rate,
        tryon_gen_panel_click_pv_through_rate,
        tryon_gen_device_id,

        tryon_complete_pv_cnt,
        tryon_complete_device_id
    FROM favie_rpt.rpt_favie_gensmo_tryon_bysource_metric_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
