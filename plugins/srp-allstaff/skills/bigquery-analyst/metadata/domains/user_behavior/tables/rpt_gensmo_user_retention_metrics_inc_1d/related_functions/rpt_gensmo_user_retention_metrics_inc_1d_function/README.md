# rpt_gensmo_user_retention_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-07-23
**最后更新**: 2025-07-23

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
with user_yestoday_active_data as (
        select 
            dt,
            device_id,
            last_30_days_feature.geo_country_name as country_name,
            last_day_feature.platform as platform,
            last_day_feature.app_version as app_version,
            last_day_feature.login_type as user_login_type,
            user_tenure_type,
            created_at
        from favie_dw.dws_favie_gensmo_user_feature_inc_1d 
        where dt = DATE_SUB(dt_param, INTERVAL 1 DAY) 
    ),

    user_yestoday_active_data_with_group as (
        select 
            t1.dt,
            t1.device_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.created_at,
            t2.user_group
        from user_yestoday_active_data t1
        left outer join (select * from favie_dw.dws_gensmo_user_group_inc_1d where dt is not null and dt = DATE_SUB(dt_param, INTERVAL 1 DAY)) t2
        on t1.device_id = t2.device_id
        where t2.user_group is not null
    ),

    user_today_active_data as (
        select 
            dt,
            device_id,
        from favie_dw.dws_favie_gensmo_user_feature_inc_1d 
        where dt = dt_param 
    ),

    user_retention_data AS (
        select
            t1.dt,
            t1.device_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.user_group,
            t2.device_id as today_device_id,
        from user_yestoday_active_data_with_group t1 
        left outer join user_today_active_data t2
        on t1.device_id = t2.device_id
    ),

    user_retention_metric as (
        select
            dt,
            country_name,  
            platform, 
            app_version,  
            user_login_type,
            user_tenure_type,
            user_group,
            COUNTIF(today_device_id is not null) as retention_user_d1_cnt,
            COUNT(device_id) as active_user_cnt
        from user_retention_data
        group by
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

        retention_user_d1_cnt,
        active_user_cnt
    FROM user_retention_metric
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
