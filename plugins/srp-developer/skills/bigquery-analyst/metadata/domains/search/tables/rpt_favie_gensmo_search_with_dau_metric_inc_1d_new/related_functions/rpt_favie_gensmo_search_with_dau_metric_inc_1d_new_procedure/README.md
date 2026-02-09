# rpt_favie_gensmo_search_with_dau_metric_inc_1d_new_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_new_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-10
**最后更新**: 2025-09-10

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
    DELETE FROM favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_new
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_new (
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

    FROM favie_rpt.rpt_favie_gensmo_search_with_dau_metric_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
