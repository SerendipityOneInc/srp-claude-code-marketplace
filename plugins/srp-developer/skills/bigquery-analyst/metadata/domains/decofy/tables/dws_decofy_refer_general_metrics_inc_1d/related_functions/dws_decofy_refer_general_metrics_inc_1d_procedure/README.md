# dws_decofy_refer_general_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_decofy_refer_general_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-27
**最后更新**: 2025-07-27

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
    declare dt_param_180 date default date_sub(dt_param, interval 180 day);

    DELETE FROM `favie_dw.dws_decofy_refer_general_metrics_inc_1d`
    WHERE dt is not null and dt = dt_param;
  
    INSERT INTO `favie_dw.dws_decofy_refer_general_metrics_inc_1d`(
        dt,
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    )
    select 
        dt,
        user_id,
        refer,
        ap_name,
        event_name,
        event_method,
        event_action_type,
        data_name,
        data_value
    from favie_dw.dws_decofy_refer_general_metrics_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
