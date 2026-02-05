# rpt_favie_gensmo_tryon_with_dau_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-15
**最后更新**: 2025-07-15

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
    DELETE FROM favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d (
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
        tryon_change_scene_browse_user_cnt

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
        tryon_change_scene_browse_user_cnt
    FROM favie_rpt.rpt_favie_gensmo_tryon_with_dau_metric_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
