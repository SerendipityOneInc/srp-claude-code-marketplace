# dwd_favie_gensmo_chat_session_messages_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d_function`
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
SELECT
    DATE(created_at) AS dt,
    session_id AS chat_session_id,
    message_id AS message_id,
    type AS message_type,
    cast(visible as string) AS message_visibility,
    PARSE_JSON(value) AS message_value,
    message_order AS message_sent_at,
    user_uid AS user_id,
    role AS user_role,
    created_at,
    last_updated_at AS updated_at
  FROM `favie_dw.dim_chat_session_messages_view`
  WHERE DATE(created_at) = dt_param
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
