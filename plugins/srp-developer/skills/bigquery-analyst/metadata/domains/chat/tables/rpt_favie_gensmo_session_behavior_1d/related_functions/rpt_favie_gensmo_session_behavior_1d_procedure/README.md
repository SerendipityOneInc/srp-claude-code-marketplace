# rpt_favie_gensmo_session_behavior_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_session_behavior_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-22
**最后更新**: 2025-07-22

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
    DELETE FROM favie_rpt.rpt_favie_gensmo_session_behavior_1d
    WHERE dt = dt_param;
    INSERT INTO favie_rpt.rpt_favie_gensmo_session_behavior_1d (
    session_id,
    user_uid,
    dt,
    last_device_id,
    message_type,
    total_message_count,
    search_query_count,
    search_res_count,
    tryon_query_count,
    tryon_res_count,
    tryon_changebg_query_count,
    tryon_changebg_res_count,
    session_start_count,
    unexpect_error_count,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group
    )
    select
    session_id,
    user_uid,
    dt,
    last_device_id,
    message_type,
    total_message_count,
    search_query_count,
    search_res_count,
    tryon_query_count,
    tryon_res_count,
    tryon_changebg_query_count,
    tryon_changebg_res_count,
    session_start_count,
    unexpect_error_count,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_tenure_type,
    user_group
    from favie_rpt.rpt_favie_gensmo_session_behavior_1d_function( dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
