# rpt_gensmo_user_retention_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d_procedure`
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
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
begin
    DECLARE current_dt DATE;
    DECLARE dt_param_1 DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        set dt_param_1 = DATE_SUB(current_dt, INTERVAL 1 DAY);
        
        delete from `favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
        where dt is not null and dt = dt_param_1;
        
        INSERT INTO `favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d`
        (
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            
            retention_user_d1_cnt,
            active_user_cnt
        )
        SELECT
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,

            retention_user_d1_cnt,
            active_user_cnt
        FROM favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d_function(current_dt);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
