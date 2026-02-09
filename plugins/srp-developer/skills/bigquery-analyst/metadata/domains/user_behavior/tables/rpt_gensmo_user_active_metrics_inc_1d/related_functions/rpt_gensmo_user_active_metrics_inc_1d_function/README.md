# rpt_gensmo_user_active_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_active_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-10-04
**最后更新**: 2025-10-04

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
with active_users as (
        select 
            dt,
            device_id,
            last_30_days_feature.geo_country_name as country_name,  
            last_day_feature.platform as platform, 
            last_day_feature.app_version as app_version,  
            last_day_feature.login_type as user_login_type,
            user_tenure_type,
            last_day_feature.duration as last_duration,
        FROM favie_dw.dws_favie_gensmo_user_feature_inc_1d
        WHERE dt = dt_param
            -- and DATE(last_access_at) = dt_param
    ),

    user_group_info as (
        SELECT
            t1.dt,
            t1.device_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.last_duration,
            t2.user_group
        FROM active_users t1 
        left outer join (select * from favie_dw.dws_gensmo_user_group_inc_1d where dt is not null and  dt = dt_param) t2 
        on t1.device_id = t2.device_id
        where t2.user_group is not null
    ),
    
    user_actvice_metric AS (
        SELECT
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            COUNT(1) AS active_user_d1_cnt,
            SUM(last_duration) AS total_duration,
        FROM user_group_info
        GROUP BY
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group         
    )

    SELECT
        dt,
        country_name,  
        platform, 
        app_version,  
        user_login_type,
        user_tenure_type,
        user_group,
        active_user_d1_cnt,
        total_duration
    FROM
        user_actvice_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
