# dws_gensmo_refer_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_refer_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-08-19
**最后更新**: 2025-08-19

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
begin
    DECLARE i INT64 DEFAULT 0;
    DECLARE current_dt DATE;
    
    -- 循环处理n_day天的数据
    WHILE i < n_day DO
        SET current_dt = DATE_SUB(dt_param, INTERVAL i DAY);
        
        -- 删除当前日期的数据
        delete from favie_dw.dws_gensmo_refer_metrics_inc_1d
        where dt = current_dt;

        -- 插入当前日期的数据
        INSERT INTO favie_dw.dws_gensmo_refer_metrics_inc_1d 
        (
            dt,
            
            platform,
            app_version,
            country_name,
            user_group,
            user_login_type,
            user_tenure_type,

            device_id,
            ap_name,
            refer,
            event_name,
            event_method,
            event_action_type,

            refer_ap_click_cnt,
            refer_pv_cnt,
            refer_leave_directly_cnt,
            refer_duration_amount,
            refer_click_device_id,
            refer_directly_leave_device_id
        )
        select 
            dt,
            
            platform,
            app_version,
            country_name,
            user_group,
            user_login_type,
            user_tenure_type,

            device_id,
            ap_name,
            refer,
            event_name,
            event_method,
            event_action_type,

            refer_ap_click_cnt,
            refer_pv_cnt,
            refer_leave_directly_cnt,
            refer_duration_amount,
            refer_click_device_id,
            refer_directly_leave_device_id
        from favie_dw.dws_gensmo_refer_metrics_inc_1d_function(current_dt);
        
        SET i = i + 1;
    END WHILE;
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
