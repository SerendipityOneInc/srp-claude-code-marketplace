# rpt_gensmo_user_retention_metrics_inc_1w_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-28
**最后更新**: 2025-07-28

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
    declare end_dt date default DATE_TRUNC(date_sub(DATE_TRUNC(dt_param, WEEK(SUNDAY)),interval 1 day),WEEK(SUNDAY));
    IF EXTRACT(DAYOFWEEK FROM dt_param) IN (1, 2, 3) THEN

        DELETE FROM `favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w`
        WHERE week_end_dt is not null and week_end_dt = DATE_TRUNC(DATE_SUB(end_dt, INTERVAL 7 DAY), WEEK(SUNDAY));
    
        INSERT INTO `favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w`(
            week_end_dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            retention_user_w1_cnt,
            active_user_cnt
        )
        select 
            week_end_dt,
            user_tenure_type,
            user_login_type,
            country_name,
            platform,
            app_version,
            user_group,
            retention_user_w1_cnt,
            active_user_cnt
        from favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w_function(end_dt);
    end if;
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
