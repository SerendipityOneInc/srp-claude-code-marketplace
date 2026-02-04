# dwd_favie_gensmo_user_ids_map_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_ids_map_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-08-16
**最后更新**: 2025-08-16

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
            user_id,
            device_id,
            appsflyer_id,
            dt,
            event_timestamp,
            ROW_NUMBER() OVER (
                PARTITION BY user_id
                ORDER BY event_timestamp DESC
            ) AS rn
        FROM favie_dw.dwd_favie_gensmo_events_inc_1d
        WHERE dt = dt_param
            AND user_id IS NOT NULL
            AND device_id IS NOT NULL
            AND appsflyer_id IS NOT NULL
            AND refer_group = 'valid'
    )
    SELECT
        user_id,
        device_id,
        appsflyer_id,
        dt,
        event_timestamp
    FROM latest_mapping
    WHERE rn = 1
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
