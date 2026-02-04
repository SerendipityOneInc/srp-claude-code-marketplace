# dim_favie_gensmo_user_ids_map_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_ids_map_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-11
**最后更新**: 2025-12-11

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
WITH latest_mapping AS (
        SELECT
            dt,
            user_id,
            device_id,
            appsflyer_id,
            event_timestamp,
            first_value(event_timestamp) OVER (
                PARTITION BY user_id,device_id,appsflyer_id
                ORDER BY event_timestamp desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) AS last_timestamp,
            ROW_NUMBER() OVER (
                PARTITION BY user_id,device_id,appsflyer_id
                ORDER BY event_timestamp DESC
            ) AS rn
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND user_id IS NOT NULL
            AND device_id IS NOT NULL
            AND appsflyer_id IS NOT NULL
            AND refer_group = 'valid'
    ),

    dim_gensmo_user_account as (
        select 
            dt_param as dt,
            user_id,
            user_name,
            user_email,
            user_phone,
            user_type,
            last_device_id,
            device_ids,
            first_device_id,
            updated_at,
            created_at,
            is_internal_user,
            is_bot_user
        from favie_dw.dim_gensmo_user_account_view
    ),

    latest_mapping_with_internal as (
        SELECT
            t1.dt,
            t1.user_id,
            t1.device_id,
            t1.appsflyer_id,
            t2.is_internal_user,
            t1.last_timestamp
        FROM (select * from latest_mapping WHERE rn = 1) t1
        left outer join dim_gensmo_user_account t2
        on t1.user_id = t2.user_id
    )
    select 
        dt,
        user_id,
        device_id,
        appsflyer_id,
        is_internal_user,
        last_timestamp
    from latest_mapping_with_internal
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
