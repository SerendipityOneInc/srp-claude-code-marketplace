# dwd_favie_decofy_ab_active_users_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_decofy_ab_active_users_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-09-08
**最后更新**: 2025-09-08

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
WITH today_event_ab AS (
    SELECT
      user_id,
      trim(ab_id) AS ab_unique_id,
      dt_param AS enter_ab_date
    FROM favie_dw.dwd_favie_decofy_events_inc_1d,
         UNNEST(event_ab_infos) AS ab_id
    WHERE dt = dt_param
      AND user_id IS NOT NULL
      AND ARRAY_LENGTH(event_ab_infos) > 0
    GROUP BY user_id, ab_id
  ),
  yest_ab_active AS (
    SELECT
      user_id,
      ab_unique_id,
      enter_ab_date
    FROM favie_dw.dwd_favie_decofy_ab_active_users_inc_1d
    WHERE dt = DATE_SUB(dt_param, INTERVAL 1 DAY)
  ),
  all_ab_union AS (
    SELECT * FROM today_event_ab
    UNION ALL
    SELECT * FROM yest_ab_active
  ),
  ab_active_min_date AS (
    SELECT
      user_id,
      ab_unique_id,
      MIN(enter_ab_date) AS enter_ab_date
    FROM all_ab_union
    GROUP BY user_id, ab_unique_id
  ),
  ab_config AS (
    SELECT
      CAST(unique_id AS STRING) AS ab_unique_id,
      trim(project) AS ab_project,
      trim(router) AS ab_router,
      SAFE_CAST(`start_date` AS DATE) AS ab_start_date,
      COALESCE(SAFE_CAST(`end_date` AS DATE), DATE('2999-12-31')) AS ab_end_date
    FROM favie_dw.dim_decofy_user_ab_config_view
    WHERE enabled = true
  )
  SELECT
    dt_param AS dt,
    a.user_id,
    c.ab_project,
    c.ab_router,
    a.ab_unique_id,
    c.ab_start_date,
    a.enter_ab_date
  FROM ab_active_min_date a
  LEFT JOIN ab_config c
    ON a.ab_unique_id = c.ab_unique_id
  WHERE c.ab_end_date >= dt_param
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
