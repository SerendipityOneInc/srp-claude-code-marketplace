# rpt_favie_gensmo_session_behavior_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_session_behavior_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**语言**: SQL
**创建时间**: 2025-12-10
**最后更新**: 2025-12-10

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
WITH messages AS (
  SELECT 
    date(created_at) as dt,
    session_id,
    user_uid,
    created_at,
    created_time,
    last_updated,
    last_updated_time,
    session_title,
    json_value(m, '$.message_id') AS message_id,
    json_value(m, '$.type') AS message_type,
  FROM 
    `favie_dw.dim_chat_sessions_view`,
    UNNEST(JSON_QUERY_ARRAY(message_list)) AS m
  WHERE created_at IS NOT NULL
  and date(created_at) = dt_param
),

user_device_map AS (
  SELECT 
    user_id AS user_uid,
    last_device_id
  FROM `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_changelog_1d`
),
session_stats AS (
  SELECT
    session_id,
    ANY_VALUE(messages.user_uid) AS user_uid,
    dt,
    last_device_id,
    message_type,
    COUNT(*) AS total_message_count,
    SUM(IF(message_type = 'search_query', 1, 0)) AS search_query_count,
    SUM(IF(message_type = 'search_res', 1, 0)) AS search_res_count,
    SUM(IF(message_type = 'tryon_query', 1, 0)) AS tryon_query_count,
    SUM(IF(message_type = 'tryon_res', 1, 0)) AS tryon_res_count,
    SUM(IF(message_type = 'tryon_changebg_query', 1, 0)) AS tryon_changebg_query_count,
    SUM(IF(message_type = 'tryon_changebg_res', 1, 0)) AS tryon_changebg_res_count,
    SUM(IF(message_type = 'session_start', 1, 0)) AS session_start_count,
    SUM(IF(message_type = 'unexpect_error', 1, 0)) AS unexpect_error_count
  FROM messages
  LEFT JOIN user_device_map
    ON messages.user_uid = user_device_map.user_uid
  GROUP BY session_id, dt, last_device_id,message_type
),
user_features AS (
  SELECT 
    device_id,
    user_tenure_type,
    platform,
    app_version,
    country_name,
    user_login_type,
    user_group
  FROM `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d_function_read`(dt_param,dt_param) 
  WHERE user_group IS NOT NULL
)
SELECT
  s.session_id,
  s.user_uid,
  s.dt,
  s.last_device_id,
  s.message_type,
  s.total_message_count,
  s.search_query_count,
  s.search_res_count,
  s.tryon_query_count,
  s.tryon_res_count,
  s.tryon_changebg_query_count,
  s.tryon_changebg_res_count,
  s.session_start_count,
  s.unexpect_error_count,
  u.platform,
  u.app_version,
  u.country_name,
  u.user_login_type,
  u.user_tenure_type,
  u.user_group
FROM session_stats s
LEFT JOIN user_features u
  ON s.last_device_id = u.device_id
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
