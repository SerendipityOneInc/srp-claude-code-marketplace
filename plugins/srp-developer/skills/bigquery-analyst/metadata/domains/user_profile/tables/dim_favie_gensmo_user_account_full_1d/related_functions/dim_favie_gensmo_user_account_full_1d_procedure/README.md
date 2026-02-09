# dim_favie_gensmo_user_account_full_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_account_full_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-16
**最后更新**: 2025-12-16

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
BEGIN
    -- 删除目标分区的数据
    DELETE FROM favie_dw.dim_favie_gensmo_user_account_full_1d
    WHERE dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dim_favie_gensmo_user_account_full_1d (
        dt,
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
    )
    SELECT
        dt,
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
    FROM favie_dw.dim_favie_gensmo_user_account_full_1d_function(dt_param);
    call favie_dw.record_partition('favie_dw.dim_favie_gensmo_user_account_full_1d', dt_param,"");
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
