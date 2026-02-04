# dws_favie_gensmo_user_1d7s_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gensmo_user_1d7s_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-09-16
**最后更新**: 2025-09-16

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
begin
    DELETE FROM favie_dw.dws_favie_gensmo_user_1d7s_inc_1d
    WHERE base_dt is not null and base_dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_dw.dws_favie_gensmo_user_1d7s_inc_1d (
    base_dt,
    user_login_type,
    platform,
    app_version,
    function_type,
    active_user_cnt,
    revisit_user_cnt
    )
    SELECT
    base_dt,
    user_login_type,
    platform,
    app_version,
    function_type,
    active_user_cnt,
    revisit_user_cnt
    FROM favie_dw.dws_favie_gensmo_user_1d7s_inc_1d_function(
        dt_param
    );   
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
