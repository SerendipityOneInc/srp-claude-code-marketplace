# dws_gensmo_user_tryon_duration_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_gensmo_user_tryon_duration_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-09
**最后更新**: 2025-09-09

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
    DELETE FROM `favie_dw.dws_gensmo_user_tryon_duration_inc_1d`
    WHERE dt IS NOT NULL AND dt = dt_param;
    -- Call the function to insert data into the table
    INSERT INTO favie_dw.dws_gensmo_user_tryon_duration_inc_1d (
        dt,
        device_id,
        tryon_complete_interval,
        user_group,
        user_tenure_type,
        user_login_type,
        country_name,
        app_version,
        platform
    )
    SELECT
        dt,
        device_id,
        tryon_complete_interval,
        user_group,
        user_tenure_type,
        user_login_type,
        country_name,
        app_version,
        platform
    FROM `favie_dw.dws_gensmo_user_tryon_duration_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
