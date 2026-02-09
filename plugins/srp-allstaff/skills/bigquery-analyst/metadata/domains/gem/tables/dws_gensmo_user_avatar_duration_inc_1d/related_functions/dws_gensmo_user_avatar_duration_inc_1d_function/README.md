# dws_gensmo_user_avatar_duration_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_avatar_duration_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-09
**最后更新**: 2025-12-09

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
WITH avatar_task_info AS (
        SELECT
            t2.device_id,
            MIN(t1.created_timestamp) AS first_created_timestamp
        FROM
            `srpproduct-dc37e.favie_dw.dim_gem_user_replica_view` t1
        LEFT JOIN `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_snapshot_function`(dt_param) t2
        ON
            t1.user_id = t2.user_id
        WHERE
            DATE(TIMESTAMP_SECONDS(t1.created_timestamp)) = dt_param 
        GROUP BY
            t2.device_id
    ),

    user_first_event AS (
        SELECT
            device_id,
            MIN(UNIX_SECONDS(event_timestamp)) AS first_event_timestamp
        FROM
            `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
        WHERE dt = dt_param and refer_group = 'valid'
        GROUP BY
            device_id
    ),

    user_avatar_complete_interval AS (
        SELECT
            t1.device_id,
            t1.first_created_timestamp - t2.first_event_timestamp AS avatar_task_interval
        FROM
            avatar_task_info t1
        LEFT OUTER JOIN user_first_event t2
        ON
            t1.device_id = t2.device_id
    ),

    info_with_user_group AS (
        SELECT
            t1.device_id,
            t1.avatar_task_interval,
            t2.user_group,
            t2.user_tenure_type,
            t2.user_login_type,
            t2.country_name,
            t2.app_version,
            t2.platform
        FROM
            user_avatar_complete_interval t1
        LEFT JOIN (select * from `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param)) t2
        ON
            t1.device_id = t2.device_id
        WHERE t2.dt = dt_param
    )

    SELECT
        dt_param AS dt,
        device_id,
        avatar_task_interval,
        user_group,
        user_tenure_type,
        user_login_type,
        country_name,
        app_version,
        platform
    FROM
        info_with_user_group
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
