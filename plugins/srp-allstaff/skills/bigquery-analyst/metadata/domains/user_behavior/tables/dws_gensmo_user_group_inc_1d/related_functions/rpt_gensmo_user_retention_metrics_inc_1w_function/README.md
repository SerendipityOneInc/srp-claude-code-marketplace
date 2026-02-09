# rpt_gensmo_user_retention_metrics_inc_1w_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_retention_metrics_inc_1w_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-09-17
**最后更新**: 2025-09-17

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` (dws_gensmo_user_group_inc_1d)
- `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d` (dws_favie_gensmo_user_feature_inc_1d)

---

## 💻 函数定义

```sql
WITH user_first_week_active_data AS (
        SELECT DISTINCT
            device_id,
            FIRST_VALUE(user_tenure_type) OVER (PARTITION BY device_id ORDER BY if(user_tenure_type is not null,0,1), IF(user_tenure_type = "New User", 0, 1)) AS user_tenure_type,
            FIRST_VALUE(last_day_feature.login_type) OVER (PARTITION BY device_id ORDER BY if(last_day_feature.login_type is not null,0,1), IF(last_day_feature.login_type = 'login', 0, 1)) AS user_login_type,
            FIRST_VALUE(last_30_days_feature.geo_country_name) OVER (PARTITION BY device_id ORDER BY if(last_30_days_feature.geo_country_name is not null,0,1), dt DESC) AS country_name,
            FIRST_VALUE(last_day_feature.platform) OVER (PARTITION BY device_id ORDER BY if(last_day_feature.platform is not null,0,1), dt DESC) AS platform,
            FIRST_VALUE(last_day_feature.app_version) OVER (PARTITION BY device_id ORDER BY if(last_day_feature.app_version is not null,0,1), dt DESC) AS app_version,
            row_number() OVER (PARTITION BY device_id ORDER BY dt DESC) AS rn
        FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt >= DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(SUNDAY))
    ),

    user_week_group_data AS (
        SELECT 
            distinct 
            device_id,
            user_group
        FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d`
        WHERE dt is not null 
            AND dt >= DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(SUNDAY))
    ),

    user_first_week_data_with_group AS (
        SELECT 
            t1.device_id,
            t1.user_tenure_type,
            t1.user_login_type,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t2.user_group
        FROM (select * from user_first_week_active_data where rn = 1) t1
        INNER JOIN user_week_group_data t2
        ON t1.device_id = t2.device_id 
        WHERE t2.user_group IS NOT NULL
    ),

    user_second_week_active_data AS (
        SELECT DISTINCT
            device_id
        FROM `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_feature_inc_1d`
        WHERE dt >= DATE_TRUNC(dt_param, WEEK(MONDAY)) 
            AND dt <= DATE_TRUNC(dt_param, WEEK(SUNDAY))
    ),

    user_retention_data AS (
        SELECT
            t1.device_id,
            t1.country_name,
            t1.platform,
            t1.app_version,
            t1.user_login_type,
            t1.user_tenure_type,
            t1.user_group,
            t2.device_id AS second_week_device_id
        FROM user_first_week_data_with_group t1
        LEFT JOIN user_second_week_active_data t2
        ON t1.device_id = t2.device_id
    ),

    user_retention_metric AS (
        SELECT
            DATE_TRUNC(DATE_SUB(dt_param, INTERVAL 7 DAY), WEEK(SUNDAY)) AS week_end_dt,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_group,
            COUNT(DISTINCT second_week_device_id) as retention_user_w1_cnt,
            COUNT(DISTINCT device_id) as active_user_cnt
        FROM user_retention_data
        GROUP BY
            week_end_dt,
            country_name,
            platform,
            app_version,
            user_login_type,
            user_tenure_type,
            user_group
    )

    SELECT
        week_end_dt,
        country_name,
        platform,
        app_version,
        user_login_type,
        user_tenure_type,
        user_group,

        retention_user_w1_cnt,
        active_user_cnt
    FROM user_retention_metric
```

---

**文档生成**: 2026-01-30 13:39:55
**扫描工具**: scan_functions.py
