# rpt_gensmo_user_x_active_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-21
**最后更新**: 2025-10-21

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| active_period_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
begin
    DECLARE current_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO
        delete from `favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d`
        where dt = current_dt and active_period = active_period_param;
        
        INSERT INTO `favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d` 
        (
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_segment,
            user_tenure_type,

            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            user_group,

            active_period,

            active_user_cnt,
            user_duration
        )
        select 
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_segment,
            user_tenure_type,

            ad_source,
            ad_id,
            ad_group_id,
            ad_campaign_id,

            user_group,

            active_period,

            active_user_cnt,
            user_duration
        from favie_rpt.rpt_gensmo_user_x_active_metrics_inc_1d_function(current_dt,active_period_param);
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    end WHILE;
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
