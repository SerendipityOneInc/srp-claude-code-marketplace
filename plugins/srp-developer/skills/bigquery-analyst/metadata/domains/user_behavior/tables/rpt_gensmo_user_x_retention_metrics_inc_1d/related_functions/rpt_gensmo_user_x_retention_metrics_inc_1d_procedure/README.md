# rpt_gensmo_user_x_retention_metrics_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_x_retention_metrics_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-20
**最后更新**: 2025-10-20

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| retention_type_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.STRING: 'STRING'>, ...) | None |
| retention_period | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |
| retention_start_period_seq | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |
| retention_end_period_seq | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
begin
    DECLARE current_dt DATE;
    DECLARE dt_param_1 DATE;
    DECLARE active_user_start_dt DATE;
    DECLARE active_user_end_dt DATE;
    DECLARE retention_user_start_dt DATE;
    DECLARE retention_user_end_dt DATE;
    set current_dt = dt_param;

    WHILE n_day >= 1 DO     
        set active_user_start_dt = date_sub(dt_param, interval (retention_end_period_seq+1) * retention_period -1 day);
        set active_user_end_dt = date_sub(dt_param, interval (retention_end_period_seq) * retention_period day);

        set retention_user_start_dt = date_add(active_user_end_dt, interval (retention_start_period_seq-1)*retention_period +1 day);
        set retention_user_end_dt = date_add(active_user_end_dt, interval (retention_end_period_seq)*retention_period day);

        select 
            current_dt as debug_current_dt,
            retention_period as debug_retention_period,
            retention_start_period_seq as debug_retention_start_period_seq,
            retention_end_period_seq as debug_retention_end_period_seq,
            retention_type_param as debug_retention_type,
            active_user_start_dt as debug_active_user_start_dt,
            active_user_end_dt as debug_active_user_end_dt,
            retention_user_start_dt as debug_retention_user_start_dt,
            retention_user_end_dt as debug_retention_user_end_dt;

        delete from `favie_rpt.rpt_gensmo_user_x_retention_metrics_inc_1d`
        where dt = active_user_end_dt and retention_type = retention_type_param;
        
        INSERT INTO `favie_rpt.rpt_gensmo_user_x_retention_metrics_inc_1d`
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

            retention_type,
            retention_user_cnt,
            active_user_cnt
        )
        SELECT
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

            retention_type,
            retention_user_cnt,
            active_user_cnt
        FROM favie_rpt.rpt_gensmo_user_x_retention_metrics_inc_1d_function(
            retention_type_param,
            active_user_start_dt,
            active_user_end_dt,
            retention_user_start_dt,
            retention_user_end_dt
        );
        SET n_day = n_day - 1;
        SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
    END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
