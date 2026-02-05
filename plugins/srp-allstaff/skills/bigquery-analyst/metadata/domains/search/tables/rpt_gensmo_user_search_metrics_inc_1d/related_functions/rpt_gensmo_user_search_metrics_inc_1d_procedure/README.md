# rpt_gensmo_user_search_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_search_metrics_inc_1d_procedure`
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
    delete from favie_rpt.rpt_gensmo_user_search_metrics_inc_1d
    where dt = dt_param;

    INSERT INTO favie_rpt.rpt_gensmo_user_search_metrics_inc_1d
    (
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        search_trigger_pv_cnt,
        search_boot_page_view_pv_cnt,
        search_boot_polish_pv_cnt,
        search_boot_focus_pv_cnt,
        search_trigger_user_cnt,
        search_boot_page_view_user_cnt,
        search_boot_polish_user_cnt,
        search_boot_focus_user_cnt,
        DAU
    )
    select
        dt,
        user_tenure_type,
        user_login_type,
        country_name,
        platform,
        app_version,
        user_group,
        search_trigger_pv_cnt,
        search_boot_page_view_pv_cnt,
        search_boot_polish_pv_cnt,
        search_boot_focus_pv_cnt,
        search_trigger_user_cnt,
        search_boot_page_view_user_cnt,
        search_boot_polish_user_cnt,
        search_boot_focus_user_cnt,
        DAU
    from favie_rpt.rpt_gensmo_user_search_metrics_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
