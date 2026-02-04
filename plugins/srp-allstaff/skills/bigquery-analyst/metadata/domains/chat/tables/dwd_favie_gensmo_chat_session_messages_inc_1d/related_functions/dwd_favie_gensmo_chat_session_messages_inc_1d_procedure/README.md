# dwd_favie_gensmo_chat_session_messages_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-31
**最后更新**: 2025-10-31

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |
| n_day | StandardSqlDataType(type_kind=<StandardSqlTypeNames.INT64: 'INT64'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
  DECLARE current_dt DATE;
  SET current_dt = dt_param;

  WHILE n_day > 0 DO
    -- delete existing data
    DELETE FROM favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d
    WHERE dt IS NOT NULL AND dt = current_dt;

    -- insert new data
    INSERT INTO favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d (
      dt,
      chat_session_id,
      message_id,
      message_type,
      message_visibility,
      message_value,
      message_sent_at,
      user_id,
      user_role,
      created_at,
      updated_at
    )
    SELECT
      dt,
      chat_session_id,
      message_id,
      message_type,
      message_visibility,
      message_value,
      message_sent_at,
      user_id,
      user_role,
      created_at,
      updated_at
    FROM favie_dw.dwd_favie_gensmo_chat_session_messages_inc_1d_function(current_dt);
    SET n_day = n_day - 1;
    SET current_dt = DATE_SUB(current_dt, INTERVAL 1 DAY);
  END WHILE;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
