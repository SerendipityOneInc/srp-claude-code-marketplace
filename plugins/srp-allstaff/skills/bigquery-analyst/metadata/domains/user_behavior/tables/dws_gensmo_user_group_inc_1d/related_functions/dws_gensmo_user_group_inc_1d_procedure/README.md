# dws_gensmo_user_group_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-05
**最后更新**: 2025-10-05

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
    -- DECLARE n_day int64 default 2;
    DECLARE current_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        DELETE FROM `favie_dw.dws_gensmo_user_group_inc_1d`
        WHERE dt is not null and dt = current_dt;
    
        INSERT INTO `favie_dw.dws_gensmo_user_group_inc_1d`(
            dt,
            user_group,
            device_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type
        )
        select 
            dt,
            user_group,
            device_id,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type
        from favie_dw.dws_gensmo_user_group_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
