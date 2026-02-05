# dws_gensmo_user_tryon_duration_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_tryon_duration_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-11-12
**最后更新**: 2025-11-12

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

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read` (dws_gensmo_user_group_inc_1d_function_read)
- `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d` (dwd_favie_gensmo_events_inc_1d)

---

## 💻 函数定义

```sql
WITH avatar_task_info AS (
        SELECT
            device_id,
            MIN(UNIX_SECONDS(event_timestamp)) AS first_completed_timestamp
        FROM
            `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_events_inc_1d`
        WHERE
            dt = dt_param and refer_group = 'valid'
            AND event_action_type = 'try_on_complete'
            AND NOT EXISTS(SELECT 1 FROM UNNEST(event_items) AS event_item WHERE event_item.item_type IN ('try_on_scenario_collage'))
        GROUP BY
            device_id
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

    user_tryon_complete_interval AS (
        SELECT
            t1.device_id,
            t1.first_completed_timestamp - t2.first_event_timestamp AS tryon_complete_interval
        FROM
            avatar_task_info t1
        LEFT OUTER JOIN user_first_event t2
        ON
            t1.device_id = t2.device_id
    ),

    info_with_user_group AS (
        SELECT
            t1.device_id,
            t1.tryon_complete_interval,
            t2.user_group,
            t2.user_tenure_type,
            t2.user_login_type,
            t2.country_name,
            t2.app_version,
            t2.platform
        FROM
            user_tryon_complete_interval t1
        LEFT JOIN `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param) t2
        ON
            t1.device_id = t2.device_id
        WHERE t2.dt = dt_param
    )

    SELECT
        dt_param AS dt,
        device_id,
        tryon_complete_interval,
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

**文档生成**: 2026-01-30 13:42:55
**扫描工具**: scan_functions.py
