# rpt_gem_user_dimension_metrics_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gem_user_dimension_metrics_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-04-17
**最后更新**: 2025-04-17

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
WITH user_info AS (
        SELECT
            dt,
            last_platform,  
            last_app_version, 
            geo_country_name AS country,
            last_login_type,  
            CASE 
                WHEN user_type = 0 THEN 'unregister'
                WHEN user_type = 1 THEN 'register'
                WHEN user_type = 2 THEN 'deregister'
            END AS user_type,

            COUNT(1) AS total_user_cnt,
            COUNTIF(DATE(created_at) = dt_param) AS new_user_cnt,

            COUNTIF(DATE(last_access_at) = dt_param) AS active_user_d1_cnt,
            COUNTIF(DATE(last_access_at) >= DATE_SUB(dt_param, INTERVAL 6 DAY)) AS active_user_d7_cnt,
            COUNTIF(DATE(last_access_at) >= DATE_SUB(dt_param, INTERVAL 29 DAY)) AS active_user_d30_cnt,

            COUNTIF(DATE(created_at) = DATE_SUB(dt_param, INTERVAL 1 DAY) AND DATE(last_access_at) = dt_param) AS retention_users, 
            COUNTIF(DATE(created_at) = DATE_SUB(dt_param, INTERVAL 1 DAY)) AS yesterday_new_users,

            SUM(IF(DATE(last_access_at) = dt_param, last_duration, NULL)) AS total_duration
        FROM
            srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_full_1d
        WHERE
            dt = dt_param
        GROUP BY
            dt,
            last_platform,  
            last_app_version,  
            country,
            last_login_type,
            user_type  
    ),

    duration_insights AS (
        SELECT
            dt,
            last_platform,  
            last_app_version, 
            geo_country_name AS country,
            last_login_type,  
            CASE 
                WHEN user_type = 0 THEN 'unregister'
                WHEN user_type = 1 THEN 'register'
                WHEN user_type = 2 THEN 'deregister'
            END AS user_type,
            PERCENTILE_CONT(coalesce(last_duration,0) , 0.95) OVER(partition by dt, last_platform, last_app_version, geo_country_name, last_login_type,user_type) AS duration_0_05_percentile,
            PERCENTILE_CONT(coalesce(last_duration,0) , 0.75) OVER(partition by dt, last_platform, last_app_version, geo_country_name, last_login_type,user_type) AS duration_0_25_percentile, 
            PERCENTILE_CONT(coalesce(last_duration,0) , 0.5) OVER(partition by dt, last_platform, last_app_version, geo_country_name, last_login_type,user_type) AS duration_0_50_percentile,           
            PERCENTILE_CONT(coalesce(last_duration,0) , 0.25) OVER(partition by dt, last_platform, last_app_version, geo_country_name, last_login_type,user_type) AS duration_0_75_percentile,
            PERCENTILE_CONT(coalesce(last_duration,0) , 0.05) OVER(partition by dt, last_platform, last_app_version, geo_country_name, last_login_type,user_type) AS duration_0_95_percentile     
        FROM
            srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_full_1d
        WHERE
            dt = dt_param
            AND DATE(last_access_at) = dt_param
            -- AND last_duration IS NOT NULL
        LIMIT 1
    ),

    gem_user_info AS (
        SELECT
            t1.dt,
            t1.last_platform,  
            t1.last_app_version,  
            t1.country,
            t1.last_login_type,  
            t1.user_type,

            t1.total_user_cnt,
            t1.new_user_cnt,

            t1.active_user_d1_cnt,
            t1.active_user_d7_cnt,
            t1.active_user_d30_cnt,
            t1.retention_users,
            t1.yesterday_new_users,

            t1.total_duration,

            t2.duration_0_05_percentile,
            t2.duration_0_25_percentile, 
            t2.duration_0_50_percentile,           
            t2.duration_0_75_percentile,
            t2.duration_0_95_percentile
        FROM
            user_info t1
        LEFT JOIN 
            duration_insights t2
        ON
            t1.dt = t2.dt AND
            t1.last_platform = t2.last_platform AND
            t1.last_app_version = t2.last_app_version AND
            t1.country = t2.country AND
            t1.last_login_type = t2.last_login_type AND
            t1.user_type = t2.user_type
    )


    SELECT
        dt,
        last_platform,  
        last_app_version,  
        country,
        last_login_type,  
        user_type,

        total_user_cnt,
        new_user_cnt,

        active_user_d1_cnt,
        active_user_d7_cnt,
        active_user_d30_cnt,
        retention_users,
        yesterday_new_users,

        total_duration,

        duration_0_05_percentile,
        duration_0_25_percentile, 
        duration_0_50_percentile,           
        duration_0_75_percentile,
        duration_0_95_percentile
    FROM
        gem_user_info
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
