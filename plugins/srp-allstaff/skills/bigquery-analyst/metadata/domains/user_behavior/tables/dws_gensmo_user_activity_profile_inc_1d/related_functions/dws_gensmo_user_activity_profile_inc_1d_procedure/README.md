# dws_gensmo_user_activity_profile_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_activity_profile_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-16
**最后更新**: 2025-12-16

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
    DELETE FROM `favie_dw.dws_gensmo_user_activity_profile_inc_1d`
    WHERE dt is not null and dt = dt_param;

    INSERT INTO `favie_dw.dws_gensmo_user_activity_profile_inc_1d`(
        dt,
        device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        user_tenure_segment,
        user_login_type,
        user_created_at,
        user_ids,
        first_event_timestamp,
        last_event_timestamp,
        geo_address,
        app_info,
        user_duration,
        common_actions
    )
    select 
        dt,
        device_id,
        appsflyer_id,
        is_internal_user,
        user_type,
        user_tenure_type,
        user_tenure_segment,
        user_login_type,
        user_created_at,
        user_ids,
        first_event_timestamp,
        last_event_timestamp,
        geo_address,
        app_info,
        user_duration,
        common_actions
    from favie_dw.dws_gensmo_user_activity_profile_inc_1d_function(dt_param);

    call favie_dw.record_partition('favie_dw.dws_gensmo_user_activity_profile_inc_1d', dt_param,"");
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
