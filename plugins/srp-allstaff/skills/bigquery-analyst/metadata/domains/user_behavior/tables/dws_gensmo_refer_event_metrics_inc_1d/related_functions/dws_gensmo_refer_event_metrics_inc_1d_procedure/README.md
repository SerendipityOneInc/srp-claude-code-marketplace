# dws_gensmo_refer_event_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_refer_event_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-08-07
**最后更新**: 2025-08-07

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
    DELETE FROM `favie_dw.dws_gensmo_refer_event_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param;
  
    INSERT INTO `favie_dw.dws_gensmo_refer_event_metrics_inc_1d`(
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        user_country_name,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        pre_refer,
        pre_refer_ap_name,
        pre_refer_event_name,
        pre_refer_event_method,
        pre_refer_event_action_type,
        next_refer,
        platform,
        app_version,
        web_version,
        event_version,
        event_cnt
    )
    select 
        dt,
        device_id,
        user_tenure_type,
        user_login_type,
        user_country_name,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        pre_refer,
        pre_refer_ap_name,
        pre_refer_event_name,
        pre_refer_event_method,
        pre_refer_event_action_type,
        next_refer,
        platform,
        app_version,
        web_version,
        event_version,
        event_cnt
    from favie_dw.dws_gensmo_refer_event_metrics_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
